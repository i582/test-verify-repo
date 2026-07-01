import "@stdlib/strings"
import "types"

contract MessengerRoom {
    author: "Petr Makhnev"
    version: "1.0.0"
    description: "Plaintext two-party messenger room with message history in transaction bodies"
    storage: Storage
    incomingMessages: AllowedMessage
}

type AllowedMessage = SendMessage | CloseRoom

fun onInternalMessage(in: InMessage) {
    val msg = lazy AllowedMessage.fromSlice(in.body);

    match (msg) {
        SendMessage => {
            var storage = lazy Storage.load();

            assert (storage.isParticipant(in.senderAddress)) throw Errors.NotParticipant;
            assert (!storage.closed) throw Errors.RoomClosed;

            val textLength = msg.text.calculateLength();
            assert (textLength > 0) throw Errors.EmptyMessage;
            assert (textLength <= MAX_MESSAGE_BYTES) throw Errors.MessageTooLong;

            storage.messageCount += 1;
            storage.save();
        }
        CloseRoom => {
            var storage = lazy Storage.load();

            assert (storage.isParticipant(in.senderAddress)) throw Errors.NotParticipant;
            assert (!storage.closed) throw Errors.RoomClosed;

            storage.closed = true;
            storage.save();

            val refund = createMessage({
                bounce: BounceMode.NoBounce,
                value: grams("0"),
                dest: in.senderAddress,
            });
            refund.send(SEND_MODE_CARRY_ALL_BALANCE);
        }
        else => {
            assert (in.body.isEmpty()) throw Errors.InvalidMessage;
        }
    }
}

fun onBouncedMessage(_in: InMessageBounced) {}

get fun roomInfo(): RoomInfo {
    val storage = lazy Storage.load();

    return {
        roomId: storage.roomId,
        participantA: storage.participantA,
        participantB: storage.participantB,
        messageCount: storage.messageCount,
        closed: storage.closed,
    };
}

get fun isParticipant(addressToCheck: address): bool {
    val storage = lazy Storage.load();

    return storage.isParticipant(addressToCheck);
}
