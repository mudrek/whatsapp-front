import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/feed_chats/domain/usecases/feed_chats_usecases.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/do_logout_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/feed_chats_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/do_logout_state.dart';

class DoLogoutReducer extends Reducer {
  final FeedChatsUsecases feedChatsUsecases;

  DoLogoutReducer({required this.feedChatsUsecases}) {
    on(() => [doLogout.value], _doLogout);
    on(() => [setInitialStatesFeedChatsAtoms], _setInitialStatesAtoms);
  }

  void _doLogout() async {
    final response = await feedChatsUsecases.logout();
    response.fold(
      (isLogout) =>
          doLogoutState.setValue(SuccessDoLogoutState(isLogout: isLogout)),
      (failure) => doLogoutState.setValue(
        ErrorDoLogoutState(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _setInitialStatesAtoms() {
    doLogoutState.setValueWithoutReaction(InitialDoLogoutState());
  }
}
