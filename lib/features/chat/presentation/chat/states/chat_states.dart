import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/message.dart';

sealed class ChatStates {}

class InitialChatStates implements ChatStates {}

class LoadingChatStates implements ChatStates {}

class SuccessChatStates implements ChatStates {
  final Stream<List<Message>> messages;

  SuccessChatStates({required this.messages});
}

class ErrorChatStates implements ChatStates {
  final WhatsappException whatsappException;

  ErrorChatStates({required this.whatsappException});
}
