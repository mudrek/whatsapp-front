import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/features/login/data/datasources/login_datasource.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoginUsecases {
  AsyncResult<User, WhatsappException> doLogin(User user);
}

class LoginUsecasesImpl implements LoginUsecases {
  final LoginDatasource loginDatasource;

  LoginUsecasesImpl({required this.loginDatasource});

  @override
  AsyncResult<User, WhatsappException> doLogin(User user) async {
    return await usecaseCore(
      task: () async {
        return loginDatasource.doLogin(user);
      },
    );
  }
}
