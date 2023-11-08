import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/signup/data/signup_datasource.dart';
import 'package:result_dart/result_dart.dart';

abstract class SignupUsecases {
  AsyncResult<User, WhatsappException> signupUser(User user);
}

class SignupUsecasesImpl implements SignupUsecases {
  final SignupDatasource signupDatasource;

  SignupUsecasesImpl({required this.signupDatasource});

  @override
  AsyncResult<User, WhatsappException> signupUser(User user) async {
    return await usecaseCore(
      task: () async {
        return await signupDatasource.signupUser(user);
      },
    );
  }
}
