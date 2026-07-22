// Generated from the verified Tact contract ABI.
contract Pyramida {
    storage: PyramidaData
    incomingMessages: PyramidaIncomingMessage
    thrownErrors: PyramidaErrors
}

struct (0x946a98b6) PyramidaDeploy {
    queryId: uint64
}

struct (0x960f4697) PyramidaUpdateJettonMasterAddress {
    queryId: uint64
    address: address
}

struct (0x358d8b73) PyramidaMintInitJettonsToOwner {
    queryId: uint64
    mint: bool
}

struct (0x888bbb88) PyramidaChangePyramidaOwner {
    queryId: uint64
    owner: address
}

struct (0xd2a7c100) PyramidaDrawLottery {
    queryId: uint64
}

struct (0x4cb3b22d) PyramidaJettonsBurned {
    queryId: uint64
    amount: coins
    totalSupply: coins
}

struct (0xd53276db) PyramidaExcesses {
    queryId: uint64
}

struct PyramidaUserData {
    referrerKey: int257
    address: address
    referralsCount: int257
    earningsFromReferrals: int257
    lastActivity: int257
}

struct PyramidaUsers {
    userData: map<int257, Cell<PyramidaUserData>>
    addresses: map<address, int257>
    lastKey: int257
    userIndex: map<int257, int257>
    userCount: int257
}

struct PyramidaPruneState {
    cursor: int257
}

struct PyramidaLotteryBank {
    balance: int257
}

struct PyramidaPastLotteryInformation {
    lastLotteryTime: int257
    lastWinnerKey: int257
    lastWinnerAddress: address
    lastWinAmount: int257
    totalWinners: int257
    totalWinsAmount: int257
}

struct PyramidaCurrentLotteryRound {
    endTime: int257
    ticketMap: map<int257, int257>
    participantList: map<int257, int257>
    totalTickets: int257
    participantsCount: int257
}

struct PyramidaDrawState {
    isDrawing: bool
    cursor: int257
    accumulated: int257
    randomTarget: int257
    winnerKey: int257
    winnerFound: bool
    snapshotParticipants: int257
    prizeAmount: int257
    ownerShareAmount: int257
    lastProgressTime: int257
}

struct PyramidaJettonRewardsStats {
    lastMintTime: int257
    totalMinted: int257
}

struct PyramidaGasDeductionResult {
    initialAmount: int257
    gasAmount: int257
    remainingAmount: int257
    isEnough: bool
}

struct PyramidaStorageStats {
    lastUpdateTime: int257
    transactionCount: int257
    totalTimeInterval: int257
    totalStorageDueCollected: int257
    reservedStorage: int257
    storageLimit: int257
    lastTonsReserve: int257
    storageTonsDeficit: int257
}

struct PyramidaCurrentRoundSummary {
    endTime: int257
    totalTickets: int257
    participantsCount: int257
}

struct PyramidaUsersSummary {
    lastKey: int257
    userCount: int257
}

struct PyramidaState {
    lotteryBank: PyramidaLotteryBank
    pastLotteryInfo: PyramidaPastLotteryInformation
    currentRound: PyramidaCurrentRoundSummary
    drawState: PyramidaDrawState
    pruneState: PyramidaPruneState
    users: PyramidaUsersSummary
    jettonRewardsStats: PyramidaJettonRewardsStats
    owner: address
    jettonMasterAddress: address
}

struct PyramidaUserView {
    registered: bool
    key: int257
    referrerKey: int257
    address: address
    referralsCount: int257
    earningsFromReferrals: int257
    lastActivity: int257
}

struct PyramidaData {
    owner: address
    jettonContent: cell
    jettonMasterAddress: address
    jettonRewardsStats: PyramidaJettonRewardsStats
    ownerJettonMinted: bool
    oldIncrement: int257
    increment: int257
    gasStats: PyramidaStorageStats
    gasResults: PyramidaGasDeductionResult
    users: PyramidaUsers
    lotteryBank: PyramidaLotteryBank
    pastLotteryInfo: PyramidaPastLotteryInformation
    currentRound: PyramidaCurrentLotteryRound
    pendingRound: PyramidaCurrentLotteryRound
    drawState: PyramidaDrawState
    pruneState: PyramidaPruneState
}

type PyramidaIncomingMessage =
    | PyramidaJettonsBurned
    | PyramidaUpdateJettonMasterAddress
    | PyramidaChangePyramidaOwner
    | PyramidaDrawLottery
    | PyramidaExcesses
    | PyramidaMintInitJettonsToOwner
    | PyramidaDeploy

enum PyramidaErrors {
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
    /// 'Unknown' error
    UnknownError = 11
    /// Fatal error
    FatalError = 12
    /// Out of gas error
    OutOfGasError = 13
    /// Virtualization error
    VirtualizationError = 14
    /// Action list is invalid
    ActionListIsInvalid = 32
    /// Action list is too long
    ActionListIsTooLong = 33
    /// Action is invalid or not supported
    ActionIsInvalidOrNotSupported = 34
    /// Invalid source address in outbound message
    InvalidSourceAddressInOutboundMessage = 35
    /// Invalid destination address in outbound message
    InvalidDestinationAddressInOutboundMessage = 36
    /// Not enough Toncoin
    NotEnoughToncoin = 37
    /// Not enough extra currencies
    NotEnoughExtraCurrencies = 38
    /// Outbound message does not fit into a cell after rewriting
    OutboundMessageDoesNotFitIntoACellAfterRewriting = 39
    /// Cannot process a message
    CannotProcessAMessage = 40
    /// Library reference is null
    LibraryReferenceIsNull = 41
    /// Library change action error
    LibraryChangeActionError = 42
    /// Exceeded maximum number of cells in the library or the maximum depth of the Merkle tree
    ExceededMaximumNumberOfCellsInTheLibraryOrTheMaximumDepthOfTheMerkleTree = 43
    /// Account state size exceeded limits
    AccountStateSizeExceededLimits = 50
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
    /// Invalid standard address
    InvalidStandardAddress = 136
    /// Not a basechain address
    NotABasechainAddress = 138
    /// Insufficient value
    InsufficientValue = 2805
    /// Amount too small for owner change
    AmountTooSmallForOwnerChange = 3571
    /// Not mintable
    NotMintable = 3688
    /// Invalid sender
    InvalidSender = 4429
    /// Insufficient value send remaining
    InsufficientValueSendRemaining = 12516
    /// Not owner
    NotOwner = 14534
    /// DrawLottery can only be sent by the contract itself
    DrawLotteryCanOnlyBeSentByTheContractItself = 14901
    /// receiverCount must be positive
    ReceiverCountMustBePositive = 17821
    /// Owner cannot be the same
    OwnerCannotBeTheSame = 18152
    /// Invalid receiver
    InvalidReceiver = 21516
    /// Only owner can change owner
    OnlyOwnerCanChangeOwner = 27145
    /// Insufficient value for multi-mint
    InsufficientValueForMultiMint = 33014
    /// Not enough gas
    NotEnoughGas = 33150
    /// Only Pyramida JettonMaster contract can update total amount
    OnlyPyramidaJettonMasterContractCanUpdateTotalAmount = 33296
    /// Owner cannot be zero
    OwnerCannotBeZero = 38148
    /// No enough TON
    NoEnoughTON = 47154
    /// User already exists
    UserAlreadyExists = 47804
    /// Only owner can mint initial jettons
    OnlyOwnerCanMintInitialJettons = 49429
    /// Insufficient ton amount
    InsufficientTonAmount = 49755
    /// Owner jettons already minted
    OwnerJettonsAlreadyMinted = 53531
    /// Only owner can set jetton master
    OnlyOwnerCanSetJettonMaster = 53922
    /// Amount should be positive
    AmountShouldBePositive = 54379
    /// Insufficient balance
    InsufficientBalance = 54615
}

get fun getPyramidaState(): PyramidaState {
    throw 0;
}

get fun getUserByAddress(userAddress: address): PyramidaUserView {
    throw 0;
}

get fun getUsersState(): PyramidaUsers {
    throw 0;
}

get fun owner(): address {
    throw 0;
}
