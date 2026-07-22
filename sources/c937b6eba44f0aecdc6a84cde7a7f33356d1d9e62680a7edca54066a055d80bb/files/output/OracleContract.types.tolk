// Generated from the verified Tact contract ABI.
contract OracleContract {
    incomingMessages: OracleContractIncomingMessage
    thrownErrors: OracleContractErrors
}

struct (0x946a98b6) OracleContractDeploy {
    queryId: uint64
}

struct (0x79a88945) OracleContractOracleState {
    name: string
    version: uint32
    owner: address
}

struct (0x2b1aeeee) OracleContractSendPrize {
    address: address
}

struct OracleContractEventState {
    state: uint8
    changed: uint8
    updated: uint32
    completionTime: uint64
    stakeOnRock: uint64
    stakeOnRoll: uint64
    doraId: uint64
    name: string
    prize: uint64
}

type OracleContractIncomingMessage =
    | OracleContractSendPrize
    | OracleContractDeploy

enum OracleContractErrors {
    /// Stack undeflow
    StackUndeflow = 2
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
    /// Event is not completed.
    EventIsNotCompleted = 2638
    /// Received an update intended for another contract.
    ReceivedAnUpdateIntendedForAnotherContract = 34615
    /// Timestamp is outdated.
    TimestampIsOutdated = 39862
    /// Invalid hash for revealed value
    InvalidHashForRevealedValue = 40617
    /// Invalid signature
    InvalidSignature = 48401
}

get fun enclavePublicKey(): int257 {
    throw 0;
}

get fun enclaveMeasurment(): int257 {
    throw 0;
}

get fun enclaveAttestation(): string {
    throw 0;
}

get fun balance(): int257 {
    throw 0;
}

get fun state(): OracleContractOracleState {
    throw 0;
}

get fun eventState(): OracleContractEventState {
    throw 0;
}

get fun owner(): address {
    throw 0;
}
