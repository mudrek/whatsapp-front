import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';

class ChatPageArgument {
  final Stream<List<ChatMessageEntity>> chatMessageEntity;
  final String username;

  ChatPageArgument({required this.chatMessageEntity, required this.username});
}
