import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/splash_screen/domain/splash_screen_usecases.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/reducers/splash_screen_reducer.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen/splash_screen_page.dart';

class SplashScreenModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.add<SplashScreenUsecases>(SplashScreenUsecasesImpl.new);
    i.addSingleton<SplashScreenReducer>(SplashScreenReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SplashScreenPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
