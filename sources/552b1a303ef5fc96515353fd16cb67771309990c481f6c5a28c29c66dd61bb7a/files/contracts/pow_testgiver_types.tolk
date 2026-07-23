/// Payout policy stored in a reference cell to preserve the legacy TestGiver layout.
struct PayoutConfig {
    amount: coins
    targetInterval: uint32
    minComplexityExponent: uint8
    maxComplexityExponent: uint8
}

/// Persistent state of the Proof-of-Work TestGiver.
struct Storage {
    seqno: uint32
    subwalletId: uint32
    publicKey: uint256
    seed: uint128
    powComplexity: uint256
    lastSuccess: uint32
    payout: Cell<PayoutConfig>
}

fun Storage.load(): Storage {
    return Storage.fromCell(contract.getData());
}

fun Storage.save(self) {
    contract.setData(self.toCell());
}

/// A proof-of-work claim. Its hash must be below the current threshold.
struct (0x4d696e65) MineRequest {
    flags: int8
    expireAt: uint32
    recipientHash: uint256
    nonce: uint256
    seed: uint128
    nonceCopy: uint256
}

/// Permissionless request to relax PoW after a prolonged idle period.
struct (0x5253636c) RescaleRequest {
    expireAt: uint32
}

type SupportedExternalMessage = MineRequest | RescaleRequest
