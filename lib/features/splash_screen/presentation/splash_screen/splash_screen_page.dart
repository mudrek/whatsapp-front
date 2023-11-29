import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/atoms/splash_screen_atom.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_loading_states.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/states/splash_screen_states.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late final Animation<double> controller;

  @override
  void initState() {
    super.initState();
    isUserLoggedAction();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => lottieLoadingFinished());
  }

  @override
  Widget build(BuildContext context) {
    final splashStates = context.select(() => splashScreenAtom.value);
    final lottieStates = context.select(() => lottieLoadingStates.value);

    if (lottieStates is FinishedLottieLoadingStates) {
      if (splashStates is SuccessSplashScreenStates) {
        Modular.to.navigate('/feed-chats/');
      }
      if (splashStates is ErrorSplashScreenStates) {
        Modular.to.navigate('/presenting/');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset(
          'assets/lotties/splash-lottie.json',
          repeat: false,
        ),
      ),
    );
  }
}
