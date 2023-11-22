import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/search_user_state.dart';

final searchUser = Atom<String>('');

final searchUserStates = Atom<SearchUserState>(InitialSearchUserState());

final setInitialStatesSearchUserAtoms = Atom.action();
