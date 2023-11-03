import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';
import 'package:kydrem_whatsapp/features/login/domain/usecases/login_usecases.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/atoms/login_atom.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';

class LoginReducer extends Reducer {
  final LoginUsecases loginUsecases;

  LoginReducer({required this.loginUsecases}) {
    on(() => [doLogin.value], _doLogin);
  }

  void _doLogin() async {
    loginStates.setValue(LoadingLoginState());
    final User user = doLogin.value;
    final response = await loginUsecases.doLogin(user);
    response.fold(
      (success) => loginStates.setValue(SuccessLoginState(user: user)),
      (failure) => loginStates.setValue(
        ErrorLoginState(
          niweException: failure,
        ),
      ),
    );
  }
}
