import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';

final doLogin = Atom<LoginUserDTO>(LoginUserDTO.empty());

final loginStates = Atom<LoginState>(InitialLoginState());

final setInitialStatesLoginAtoms = Atom.action();
