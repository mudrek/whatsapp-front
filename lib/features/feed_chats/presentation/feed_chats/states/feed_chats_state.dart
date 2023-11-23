import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

sealed class FeedChatsState {}

class InitialFeedChatsState implements FeedChatsState {}

class LoadingFeedChatsState implements FeedChatsState {}

class SuccessFeedChatsState implements FeedChatsState {
  final List<Chat> chats;

  SuccessFeedChatsState({required this.chats});
}

class ErrorFeedChatsState implements FeedChatsState {
  final WhatsappException whatsappException;

  ErrorFeedChatsState({required this.whatsappException});
}
