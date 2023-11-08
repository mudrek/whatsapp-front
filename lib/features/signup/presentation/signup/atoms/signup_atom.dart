import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/states/signup_state.dart';

final doSignupUser = Atom<User>(User.empty());

final signupStates = Atom<SignupState>(InitialSignupState());

final setInitialStatesSignupAtoms = Atom.action();
