import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/login/data/datasources/login_datasource.dart';
import 'package:kydrem_whatsapp/features/login/domain/usecases/login_usecases.dart';
import 'package:kydrem_whatsapp/features/login/domain/validators/login_validators_impl.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/login_page.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/reducers/login_reducer.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/validators/login_validators.dart';

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
    i.addSingleton<LoginValidators>(LoginValidatorsImpl.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const LoginPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
