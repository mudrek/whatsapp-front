import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';

abstract class LocalStorageUsecases {
  AsyncResult<User, WhatsappException> saveUserLocalStorage(User user);
  AsyncResult<User, WhatsappException> getLoggedUser();
  AsyncResult<String, WhatsappException> getBearerToken();
  AsyncResult<String, WhatsappException> saveBearerToken(String bearerToken);
  AsyncResult<bool, WhatsappException> logout();
}

class LocalStorageUsecasesImpl implements LocalStorageUsecases {
  final LocalStorageDatasource localStorageDatasource;

  LocalStorageUsecasesImpl({required this.localStorageDatasource});

  @override
  AsyncResult<String, WhatsappException> getBearerToken() async {
    return await usecaseCore(
      task: () async {
        return localStorageDatasource.getBearerToken();
      },
    );
  }

  @override
  AsyncResult<User, WhatsappException> getLoggedUser() async {
    return await usecaseCore(
      task: () async {
        return localStorageDatasource.getLoggedUser();
      },
    );
  }

  @override
  AsyncResult<String, WhatsappException> saveBearerToken(
      String bearerToken) async {
    return await usecaseCore(
      task: () async {
        return localStorageDatasource.saveBearerToken(bearerToken);
      },
    );
  }

  @override
  AsyncResult<User, WhatsappException> saveUserLocalStorage(User user) async {
    return await usecaseCore(
      task: () async {
        return localStorageDatasource.saveUserLocalStorage(user);
      },
    );
  }

  @override
  AsyncResult<bool, WhatsappException> logout() async {
    return await usecaseCore(
      task: () async {
        return localStorageDatasource.logout();
      },
    );
  }
}
