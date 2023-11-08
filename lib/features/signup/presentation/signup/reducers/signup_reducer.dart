import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/signup/domain/usecases/signup_usecases.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/atoms/signup_atom.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/states/signup_state.dart';

class SignupReducer extends Reducer {
  final SignupUsecases signupUsecases;

  SignupReducer({required this.signupUsecases}) {
    on(() => [doSignupUser.value], _doSignupUser);
    on(() => [setInitialStatesSignupAtoms], _setInitialStatesAtoms);
  }

  void _doSignupUser() async {
    signupStates.setValue(LoadingSignupState());
    final User user = doSignupUser.value;
    final response = await signupUsecases.signupUser(user);
    response.fold(
      (user) => signupStates.setValue(SuccessSignupState(user: user)),
      (failure) => signupStates.setValue(
        ErrorSignupState(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _setInitialStatesAtoms() {
    doSignupUser.setValueWithoutReaction(User.empty());
    signupStates.setValueWithoutReaction(InitialSignupState());
  }
}
