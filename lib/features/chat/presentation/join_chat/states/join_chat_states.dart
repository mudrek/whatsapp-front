import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';

sealed class JoinChatStates {}

class InitialJoinChatState implements JoinChatStates {}

class LoadingJoinChatState implements JoinChatStates {}

class SuccessJoinChatState implements JoinChatStates {
  final Stream<List<ChatMessageEntity>> chatMessageEntity;

  SuccessJoinChatState({required this.chatMessageEntity});
}

class ErrorJoinChatState implements JoinChatStates {
  final WhatsappException niweException;

  ErrorJoinChatState({required this.niweException});
}
