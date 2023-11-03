import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/http/http_client.dart';
import 'package:kydrem_whatsapp/features/chat/chat_module.dart';
import 'package:kydrem_whatsapp/features/login/login_module.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen_page.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashScreenPage());
    r.module('/chat', module: ChatModule());
    r.module('/login', module: LoginModule());
  }
}

class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<HttpClient>(() => HttpClient(request: Dio()));
  }
}
