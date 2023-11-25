import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kydrem_whatsapp/core/foundation/dio_interceptor.dart';
import 'package:kydrem_whatsapp/core/foundation/secure_storage.dart';
import 'package:kydrem_whatsapp/core/http/http_client.dart';
import 'package:kydrem_whatsapp/core/services/websocket_service.dart';
import 'package:kydrem_whatsapp/features/chat/chat_module.dart';
import 'package:kydrem_whatsapp/features/feed_chats/feed_chats_module.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:kydrem_whatsapp/features/local_storage/domain/usecases/local_storage_usecases.dart';
import 'package:kydrem_whatsapp/features/login/login_module.dart';
import 'package:kydrem_whatsapp/features/presenting/presenting_module.dart';
import 'package:kydrem_whatsapp/features/search_user/search_user_module.dart';
import 'package:kydrem_whatsapp/features/signup/signup_module.dart';
import 'package:kydrem_whatsapp/features/splash_screen/presentation/splash_screen_page.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashScreenPage());
    r.module('/chat', module: ChatModule());
    r.module('/login', module: LoginModule());
    r.module('/presenting', module: PresentingModule());
    r.module('/feed-chats', module: FeedChatsModule());
    r.module('/signup', module: SignupModule());
    r.module('/search-user', module: SearchUserModule());
  }
}

class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<Dio>(() => Dio());
    i.addSingleton<DioInterceptor>(DioInterceptor.new);
    i.addSingleton<HttpClient>(HttpClient.new);
    // Core LocalStorage
    i.addSingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    );
    i.addSingleton<SecureStorage>(SecureStorageImpl.new);
    i.add<LocalStorageDatasource>(LocalStorageDatasourceImpl.new);
    i.add<LocalStorageUsecases>(LocalStorageUsecasesImpl.new);
    i.add<WebsocketService>(WebsocketService.new);
  }
}
