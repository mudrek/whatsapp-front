import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/splash_screen/domain/splash_screen_usecases.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/atoms/splash_screen_atom.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_loading_states.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_states.dart';

class SplashScreenReducer extends Reducer {
  final SplashScreenUsecases splashScreenUsecases;

  SplashScreenReducer({required this.splashScreenUsecases}) {
    on(() => [isUserLoggedAction.value], _isUserLogged);
    on(() => [lottieLoadingFinished.value], _lottieLoadingFinished);
  }

  void _isUserLogged() async {
    splashScreenAtom.setValue(InitialSplashScreenStates());
    final response = await splashScreenUsecases.isUserLogged();
    response.fold(
      (isLoggedUser) => splashScreenAtom
          .setValue(SuccessSplashScreenStates(isLogged: isLoggedUser)),
      (failure) => splashScreenAtom.setValue(
        ErrorSplashScreenStates(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _lottieLoadingFinished() {
    lottieLoadingStates.setValue(FinishedLottieLoadingStates());
  }
}
