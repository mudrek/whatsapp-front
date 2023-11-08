import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/signup/data/signup_datasource.dart';
import 'package:kydrem_whatsapp/features/signup/domain/usecases/signup_usecases.dart';
import 'package:kydrem_whatsapp/features/signup/domain/validators/signup_validators_impl.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/reducers/signup_reducer.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/signup_page.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/validators/signup_validators.dart';

class SignupModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<SignupValidators>(SignupValidatorsImpl.new);
    i.addSingleton<SignupDatasource>(SignupDatasourceImpl.new);
    i.addSingleton<SignupUsecases>(SignupUsecasesImpl.new);
    i.addSingleton<SignupReducer>(SignupReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SignupPage(),
      transition: TransitionType.rightToLeft,
    );
  }
}
