import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/dto/create_chat_dto.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/create_chat_state.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/search_user_state.dart';

final searchUser = Atom<String>('');

final createChatUser = Atom<CreateChatDTO>(CreateChatDTO.empty());

final searchUserStates = Atom<SearchUserState>(InitialSearchUserState());

final createChatUserStates = Atom<CreateChatState>(InitialCreateChatState());

final setInitialStatesSearchUserAtoms = Atom.action();
