// Generated from the verified Tact contract ABI.
contract HashedTimeLockTON {
    incomingMessages: HashedTimeLockTONIncomingMessage
    thrownErrors: HashedTimeLockTONErrors
}

struct (0x946a98b6) HashedTimeLockTONDeploy {
    queryId: uint64
}

struct (0x7362d09c) HashedTimeLockTONTokenNotification {
    queryId: uint64
    amount: coins
    from: address
    forward_payload: RemainingBitsAndRefs
}

struct (0xd53276db) HashedTimeLockTONTokenExcesses {
    queryId: uint64
}

struct HashedTimeLockTONHTLC {
    dstAddress: string
    dstChain: string
    dstAsset: string
    srcAsset: string
    sender: address
    senderPubKey: int257
    srcReceiver: address
    secret: int257
    hashlock: int257
    amount: int257
    timelock: int257
    messenger: address
    redeemed: bool
    refunded: bool
    jettonMasterAddress: address
    htlcJettonWalletAddress: address
}

struct (0x5cdd41d9) HashedTimeLockTONAddLock {
    Id: int257
    hashlock: int257
    timelock: int257
}

struct (0x758db085) HashedTimeLockTONRedeem {
    Id: int257
    secret: int257
}

struct (0xad821ef9) HashedTimeLockTONRefund {
    Id: int257
}

type HashedTimeLockTONIncomingMessage =
    | HashedTimeLockTONTokenNotification
    | HashedTimeLockTONAddLock
    | HashedTimeLockTONRedeem
    | HashedTimeLockTONRefund
    | HashedTimeLockTONTokenExcesses
    | HashedTimeLockTONDeploy

enum HashedTimeLockTONErrors {
    /// Stack underflow
    StackUnderflow = 2
    /// Stack overflow
    StackOverflow = 3
    /// Integer overflow
    IntegerOverflow = 4
    /// Integer out of expected range
    IntegerOutOfExpectedRange = 5
    /// Invalid opcode
    InvalidOpcode = 6
    /// Type check error
    TypeCheckError = 7
    /// Cell overflow
    CellOverflow = 8
    /// Cell underflow
    CellUnderflow = 9
    /// Dictionary error
    DictionaryError = 10
    /// Out of gas error
    OutOfGasError = 13
    /// Method ID not found
    MethodIDNotFound = 32
    /// Action is invalid or not supported
    ActionIsInvalidOrNotSupported = 34
    /// Not enough TON
    NotEnoughTON = 37
    /// Not enough extra-currencies
    NotEnoughExtraCurrencies = 38
    /// Null reference exception
    NullReferenceException = 128
    /// Invalid serialization prefix
    InvalidSerializationPrefix = 129
    /// Invalid incoming message
    InvalidIncomingMessage = 130
    /// Constraints error
    ConstraintsError = 131
    /// Access denied
    AccessDenied = 132
    /// Contract stopped
    ContractStopped = 133
    /// Invalid argument
    InvalidArgument = 134
    /// Code of a contract was not found
    CodeOfAContractWasNotFound = 135
    /// Invalid address
    InvalidAddress = 136
    /// Masterchain support is not enabled for this contract
    MasterchainSupportIsNotEnabledForThisContract = 137
    /// Funds Not Sent
    FundsNotSent = 4670
    /// Lock Does Not Exist
    LockDoesNotExist = 6272
    /// Hashlock Already Set
    HashlockAlreadySet = 8650
    /// Not Future Timelock
    NotFutureTimelock = 21683
    /// HTLC Already Exists
    HTLCAlreadyExists = 24064
    /// No Allowance
    NoAllowance = 31687
    /// Not Passed Timelock
    NotPassedTimelock = 38239
    /// Already Redeemed
    AlreadyRedeemed = 46887
    /// Invalid signature
    InvalidSignature = 48401
    /// Already Refunded
    AlreadyRefunded = 49162
    /// Hashlock Not Match
    HashlockNotMatch = 50918
    /// Contract Does Not Exist
    ContractDoesNotExist = 58417
}

get fun getDetails(Id: int257): HashedTimeLockTONHTLC? {
    throw 0;
}

get fun getContractsLength(): int257 {
    throw 0;
}
