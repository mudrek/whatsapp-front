import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

sealed class SearchUserState {}

class InitialSearchUserState implements SearchUserState {}

class LoadingSearchUserState implements SearchUserState {}

class SuccessSearchUserState implements SearchUserState {
  final List<User> user;

  SuccessSearchUserState({required this.user});
}

class ErrorSearchUserState implements SearchUserState {
  final WhatsappException whatsappException;

  ErrorSearchUserState({required this.whatsappException});
}
