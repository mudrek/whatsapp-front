import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

sealed class SignupState {}

class InitialSignupState implements SignupState {}

class LoadingSignupState implements SignupState {}

class SuccessSignupState implements SignupState {
  final User user;

  SuccessSignupState({required this.user});
}

class ErrorSignupState implements SignupState {
  final WhatsappException whatsappException;

  ErrorSignupState({required this.whatsappException});
}
