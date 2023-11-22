import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

sealed class CreateChatState {}

class InitialCreateChatState implements CreateChatState {}

class LoadingCreateChatState implements CreateChatState {}

class SuccessCreateChatState implements CreateChatState {
  final Chat chat;

  SuccessCreateChatState({required this.chat});
}

class ErrorCreateChatState implements CreateChatState {
  final WhatsappException whatsappException;

  ErrorCreateChatState({required this.whatsappException});
}
