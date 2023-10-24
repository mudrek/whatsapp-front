class ChatMessageEntity {
  final String? content;
  final String sender;
  final MessageType type;

  ChatMessageEntity({
    required this.content,
    required this.sender,
    required this.type,
  });

  static ChatMessageEntity empty() {
    return ChatMessageEntity(
      content: "",
      sender: "",
      type: MessageType.join,
    );
  }
}

enum MessageType { chat, leave, join, empty }

extension MessageTypeExtension on MessageType {
  String getString() {
    switch (this) {
      case MessageType.chat:
        return "CHAT";
      case MessageType.leave:
        return "LEAVE";
      case MessageType.join:
        return "JOIN";
      default:
        return "EMPTY";
    }
  }
}
