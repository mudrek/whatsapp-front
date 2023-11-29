import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/foundation/exceptions.dart';
import '../../../core/foundation/usecase_core.dart';

abstract class SplashScreenUsecases {
  AsyncResult<bool, WhatsappException> isUserLogged();
}

class SplashScreenUsecasesImpl implements SplashScreenUsecases {
  final LocalStorageDatasource localStorageDatasource;

  SplashScreenUsecasesImpl({required this.localStorageDatasource});

  @override
  AsyncResult<bool, WhatsappException> isUserLogged() async {
    return await usecaseCore(
      task: () async {
        await localStorageDatasource.getLoggedUser();

        return true;
      },
    );
  }
}
