import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/chat/chat_module.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashScreenPage());
    r.module('/chat', module: ChatModule());
  }
}
