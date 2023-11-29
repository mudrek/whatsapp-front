import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';

sealed class SplashScreenStates {}

class InitialSplashScreenStates implements SplashScreenStates {}

class LoadingSplashScreenStates implements SplashScreenStates {}

class SuccessSplashScreenStates implements SplashScreenStates {
  final bool isLogged;

  SuccessSplashScreenStates({required this.isLogged});
}

class ErrorSplashScreenStates implements SplashScreenStates {
  final WhatsappException whatsappException;

  ErrorSplashScreenStates({required this.whatsappException});
}
