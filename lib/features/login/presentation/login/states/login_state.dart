import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';

sealed class LoginState {}

class InitialLoginState implements LoginState {}

class LoadingLoginState implements LoginState {}

class SuccessLoginState implements LoginState {
  final User user;

  SuccessLoginState({required this.user});
}

class ErrorLoginState implements LoginState {
  final WhatsappException niweException;

  ErrorLoginState({required this.niweException});
}
