import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';

import '../../../../../core/shared/entities/message.dart';

sealed class SendMessagesStates {}

class InitialSendMessagesStates implements SendMessagesStates {}

class LoadingSendMessagesStates implements SendMessagesStates {}

class SuccessSendMessagesStates implements SendMessagesStates {
  final Message messages;

  SuccessSendMessagesStates({required this.messages});
}

class ErrorSendMessagesStates implements SendMessagesStates {
  final WhatsappException whatsappException;

  ErrorSendMessagesStates({required this.whatsappException});
}
