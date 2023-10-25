import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/domain/usecases/chat_usecases.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/states/join_chat_states.dart';
import 'package:result_dart/result_dart.dart';

import '../atoms/join_chat_atom.dart';

class JoinChatReducer extends Reducer {
  final ChatUsecases chatUsecases;

  JoinChatReducer({required this.chatUsecases}) {
    on(() => [connectToChat.value], _doLogin);
  }

  _doLogin() async {
    chatState.setValue(LoadingJoinChatState());
    final chatMessageEntity = connectToChat.value;
    await chatUsecases.connectToChat(chatMessageEntity).fold(
          (chatMessageEntity) => chatState.setValue(
              SuccessJoinChatState(chatMessageEntity: chatMessageEntity)),
          (error) => chatState.setValue(
            ErrorJoinChatState(niweException: error),
          ),
        );
  }
}
