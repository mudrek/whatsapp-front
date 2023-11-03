import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/join_chat_page.dart';
import 'package:kydrem_whatsapp/features/login/data/datasources/login_datasource.dart';
import 'package:kydrem_whatsapp/features/login/domain/usecases/login_usecases.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/reducers/login_reducer.dart';

class LoginModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<LoginDatasource>(LoginDatasourceImpl.new);
    i.add<LoginUsecases>(LoginUsecasesImpl.new);
    i.addSingleton<LoginReducer>(LoginReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const JoinChatPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
