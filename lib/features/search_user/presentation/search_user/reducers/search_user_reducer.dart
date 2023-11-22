import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/usecases/search_user_usecases.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/atoms/search_user_atom.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/search_user_state.dart';

class SearchUserReducer extends Reducer {
  final SearchUserUsecases searchUserUsecases;

  SearchUserReducer({required this.searchUserUsecases}) {
    on(() => [searchUser.value], _searchUser);
    on(() => [setInitialStatesSearchUserAtoms], _setInitialStatesAtoms);
  }

  void _searchUser() async {
    searchUserStates.setValue(LoadingSearchUserState());
    final String username = searchUser.value;
    final response = await searchUserUsecases.searchUser(username);
    response.fold(
      (user) => searchUserStates.setValue(SuccessSearchUserState(users: user)),
      (failure) => searchUserStates.setValue(
        ErrorSearchUserState(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _setInitialStatesAtoms() {
    searchUser.setValueWithoutReaction('');
    searchUserStates.setValueWithoutReaction(InitialSearchUserState());
  }
}
