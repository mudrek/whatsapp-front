import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:kydrem_whatsapp/features/login/data/datasources/login_datasource.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';
import 'package:kydrem_whatsapp/features/login/domain/exceptions/login_exceptions.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoginUsecases {
  AsyncResult<User, WhatsappException> doLogin(LoginUserDTO loginUserDTO);
}

class LoginUsecasesImpl implements LoginUsecases {
  final LoginDatasource loginDatasource;
  final LocalStorageDatasource localStorageDatasource;

  LoginUsecasesImpl({
    required this.loginDatasource,
    required this.localStorageDatasource,
  });

  @override
  AsyncResult<User, WhatsappException> doLogin(
      LoginUserDTO loginUserDTO) async {
    return await usecaseCore(
      task: () async {
        final (loggedUser, bearerToken) =
            await loginDatasource.doLogin(loginUserDTO);

        localStorageDatasource.saveUserLocalStorage(loggedUser);
        localStorageDatasource.saveBearerToken(bearerToken);

        return loggedUser;
      },
      onException: (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 401) {
            return const WrongUsernameOrPasswordLoginException();
          }
        }
        return null;
      },
    );
  }
}
