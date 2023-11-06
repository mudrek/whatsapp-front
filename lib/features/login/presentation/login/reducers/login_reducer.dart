import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/domain/usecases/login_usecases.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/atoms/login_atom.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';

class LoginReducer extends Reducer {
  final LoginUsecases loginUsecases;

  LoginReducer({required this.loginUsecases}) {
    on(() => [doLogin.value], _doLogin);
    on(() => [setInitialStatesLoginAtoms], _setInitialStatesAtoms);
  }

  void _doLogin() async {
    loginStates.setValue(LoadingLoginState());
    final LoginUserDTO loginUserDTO = doLogin.value;
    final response = await loginUsecases.doLogin(loginUserDTO);
    response.fold(
      (user) => loginStates.setValue(SuccessLoginState(user: user)),
      (failure) => loginStates.setValue(
        ErrorLoginState(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _setInitialStatesAtoms() {
    doLogin.setValueWithoutReaction(LoginUserDTO.empty());
    loginStates.setValueWithoutReaction(InitialLoginState());
  }
}
