import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageEntityAdapter {
  static ChatMessageEntity fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
        content: json['content'],
        sender: json['sender'],
        type: getMessageTypeFromString(json['type']));
  }

  static Map<String, dynamic> toJson(ChatMessageEntity loginUserRequest) {
    return {
      'content': loginUserRequest.content,
      'sender': loginUserRequest.sender,
      'type': loginUserRequest.type.getString(),
    };
  }

  static MessageType getMessageTypeFromString(String messageType) {
    switch (messageType) {
      case "JOIN":
        return MessageType.join;
      case "CHAT":
        return MessageType.chat;
      case "LEAVE":
        return MessageType.leave;
      default:
        return MessageType.empty;
    }
  }
}
