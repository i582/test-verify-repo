import "@stdlib/strings"

const MAX_MESSAGE_BYTES = 240

enum Errors {
    NotParticipant = 100
    EmptyMessage = 0x1001
    MessageTooLong = 0x1002
    RoomClosed = 0x1003
    InvalidMessage = 0xFFFF
}

struct Storage {
    roomId: uint32
    participantA: address
    participantB: address
    messageCount: uint32
    closed: bool
}

fun Storage.load(): Storage {
    return Storage.fromCell(contract.getData());
}

fun Storage.save(self) {
    contract.setData(self.toCell());
}

fun Storage.isParticipant(self, candidate: address): bool {
    return self.participantA == candidate || self.participantB == candidate;
}

struct RoomInfo {
    roomId: uint32
    participantA: address
    participantB: address
    messageCount: uint32
    closed: bool
}

fun addressLess(left: address, right: address): bool {
    val (leftWorkchain, leftHash) = left.getWorkchainAndHash();
    val (rightWorkchain, rightHash) = right.getWorkchainAndHash();

    if (leftWorkchain != rightWorkchain) {
        return leftWorkchain < rightWorkchain;
    }

    return leftHash < rightHash;
}

fun sortParticipants(left: address, right: address): (address, address) {
    if (addressLess(right, left)) {
        return (right, left);
    }

    return (left, right);
}

struct (0x6d736701) SendMessage {
    text: string
}

struct (0x636c7301) CloseRoom {}
