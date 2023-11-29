import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';

sealed class DoLogoutState {}

class InitialDoLogoutState implements DoLogoutState {}

class LoadingDoLogoutState implements DoLogoutState {}

class SuccessDoLogoutState implements DoLogoutState {
  final bool isLogout;

  SuccessDoLogoutState({required this.isLogout});
}

class ErrorDoLogoutState implements DoLogoutState {
  final WhatsappException whatsappException;

  ErrorDoLogoutState({required this.whatsappException});
}
