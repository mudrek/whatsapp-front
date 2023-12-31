import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/feed_chats/domain/usecases/feed_chats_usecases.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/do_logout_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/feed_chats_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/do_logout_state.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/feed_chats_state.dart';

class FeedChatsReducer extends Reducer {
  final FeedChatsUsecases feedChatsUsecases;

  FeedChatsReducer({required this.feedChatsUsecases}) {
    on(() => [getAllChatList.value], _getAllChatList);
    on(() => [setInitialStatesFeedChatsAtoms], _setInitialStatesAtoms);
    on(() => [closeConnectionFeedChat], _closeConnection);
  }

  void _getAllChatList() async {
    feedChatsState.setValue(LoadingFeedChatsState());
    final response = await feedChatsUsecases.getAllChatsFromUser();
    response.fold(
      (chats) => feedChatsState.setValue(SuccessFeedChatsState(chats: chats)),
      (failure) => feedChatsState.setValue(
        ErrorFeedChatsState(
          whatsappException: failure,
        ),
      ),
    );
  }

  void _setInitialStatesAtoms() {
    feedChatsState.setValueWithoutReaction(InitialFeedChatsState());
    doLogoutState.setValueWithoutReaction(InitialDoLogoutState());
  }

  void _closeConnection() {
    feedChatsUsecases.closeConnection();
  }
}
