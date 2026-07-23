import "@stdlib/gas-payments"
import "@stdlib/tvm-lowlevel"
import "pow_testgiver_types"

contract PowTestgiver {
    author: "Acton"
    version: "1.0.0"
    description: "Proof-of-work testnet faucet compatible with the legacy TestGiver state layout"
    storage: Storage
    incomingExternal: SupportedExternalMessage
}

/// # Safety
/// The caller must provide a non-negative value that fits in `bits` unsigned bits.
fun ufits(x: int, bits: int): int
    asm "UFITSX";

fun onInternalMessage(_in: InMessage) {
    // A transfer with an empty body only tops up the faucet balance.
}

fun Storage.resetParameters(mutate self, parameters: cell) {
    var input = parameters.beginParse();
    val resetComplexityExponent = input.loadUint(8);

    if (resetComplexityExponent != 0) {
        random.initializeBy(self.seed as uint256);
        self.powComplexity = 1 << resetComplexityExponent;
        self.seed = random.uint256() >> 128;
    }

    self.lastSuccess = blockchain.now();
    self.payout = PayoutConfig.fromSlice(input).toCell();
}

fun sendPayout(request: MineRequest, amount: coins) {
    sendRawMessage(beginCell()
        .storeUint(((request.flags & 1) << 6) | 0x84, 9)
        .storeInt(request.flags >> 2, 8)
        .storeUint(request.recipientHash, 256)
        .storeCoins(amount)
        .storeUint(0, 1 + 4 + 4 + 64 + 32 + 1 + 1)
        .endCell(), SEND_MODE_PAY_FEES_SEPARATELY | SEND_MODE_IGNORE_ERRORS);
}

fun handleMine(rawMessage: slice, request: MineRequest) {
    val messageHash = rawMessage.hash();
    var storage = lazy Storage.load();
    val config = lazy storage.payout.load();

    assert (messageHash < storage.powComplexity) throw 24;
    ufits(request.expireAt - blockchain.now(), 10);
    assert (request.seed == storage.seed && request.nonce == request.nonceCopy) throw 25;

    acceptExternalMessage();
    random.initialize();
    random.initializeBy(request.nonce);

    val elapsed = blockchain.now() - storage.lastSuccess;
    if (elapsed > 0) {
        var factor = mulDivRound(elapsed, 1 << 128, config.targetInterval);
        factor = min(max(factor, 7 << 125), 9 << 125);
        storage.powComplexity = mulDivRound(storage.powComplexity, factor, 1 << 128);
        storage.powComplexity = min(
            max(storage.powComplexity, 1 << config.minComplexityExponent),
            1 << config.maxComplexityExponent,
        );
    }

    storage.seed = random.uint256() >> 128;
    storage.lastSuccess = blockchain.now();
    storage.save();
    commitContractDataAndActions();

    sendPayout(request, config.amount);
}

fun handleRescale(request: RescaleRequest) {
    val now = blockchain.now();
    var storage = lazy Storage.load();
    val config = lazy storage.payout.load();

    assert (now > request.expireAt) throw 28;
    assert (request.expireAt > storage.lastSuccess) throw 29;

    val elapsed = now - storage.lastSuccess;
    assert (elapsed >= config.targetInterval * 16) throw 30;

    acceptExternalMessage();

    val factor = mulDivRound(elapsed, 1 << 128, config.targetInterval);
    val maximum = 1 << config.maxComplexityExponent;
    val maximumFactor = mulDivFloor(maximum, 1 << 128, storage.powComplexity);
    storage.powComplexity = maximumFactor < factor
        ? maximum
        : mulDivRound(storage.powComplexity, factor, 1 << 128);
    storage.lastSuccess = now - config.targetInterval;
    storage.save();
}

fun handleAdminMessage(inMsg: slice) {
    var body = inMsg;
    val signature = body.loadBits(512);
    val subwalletId = body.loadUint(32);
    val validUntil = body.loadUint(32);
    val requestSeqno = body.loadUint(32);
    var storage = lazy Storage.load();

    assert (validUntil > blockchain.now()) throw 35;
    assert (requestSeqno == storage.seqno) throw 33;
    assert (subwalletId == storage.subwalletId || subwalletId == 0) throw 34;
    assert (isSignatureValid(inMsg.hash(), signature, storage.publicKey)) throw 35;

    acceptExternalMessage();
    // Legacy admin messages interleave action refs with 8-bit send modes.
    body.stackMoveToTop();
    while (body.remainingRefsCount() != 0) {
        val action = body.loadRef();
        val mode = body.loadUint(8);
        if (mode < 0xff) {
            sendRawMessage(action, mode);
        } else {
            storage.resetParameters(action);
        }
    }

    storage.seqno += 1;
    storage.save();
}

fun onExternalMessage(inMsg: slice) {
    val message = lazy SupportedExternalMessage.fromSlice(inMsg);

    match (message) {
        MineRequest => {
            handleMine(inMsg, message);
        }
        RescaleRequest => {
            handleRescale(message);
        }
        // The signed admin envelope predates the typed external-message ABI.
        else => {
            handleAdminMessage(inMsg);
        }
    }
}

/// Returns the monotonic admin sequence number.
get fun seqno(): uint32 {
    val storage = lazy Storage.load();
    return storage.seqno;
}

/// Returns the active PoW seed, threshold, payout amount, and target interval.
get fun getPowParams(): (uint128, uint256, coins, uint32) {
    val storage = lazy Storage.load();
    val config = lazy storage.payout.load();
    return (storage.seed, storage.powComplexity, config.amount, config.targetInterval);
}

/// Returns the Ed25519 public key authorized for signed admin messages.
get fun getPublicKey(): uint256 {
    val storage = lazy Storage.load();
    return storage.publicKey;
}
