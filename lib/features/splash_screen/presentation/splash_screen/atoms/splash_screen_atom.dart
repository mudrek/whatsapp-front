import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_loading_states.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_states.dart';

final splashScreenAtom = Atom<SplashScreenStates>(InitialSplashScreenStates());

final isUserLoggedAction = Atom.action();

final lottieLoadingStates =
    Atom<LottieLoadingStates>(LoadingLottieLoadingStates());

final lottieLoadingFinished = Atom.action();
