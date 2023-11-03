import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';

final doLogin = Atom<User>(User.empty());

final loginStates = Atom<LoginState>(InitialLoginState());
