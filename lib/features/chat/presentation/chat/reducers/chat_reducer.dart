import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/domain/usecases/chat_usecases.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/atoms/chat_atom.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/chat_states.dart';

class ChatReducer extends Reducer {
  final ChatUsecases chatUsecases;

  ChatReducer({required this.chatUsecases}) {
    on(() => [getAllMessagesFromChatId.value], _getAllMessagesFromChatId);
    on(() => [closeChatConnection.value], _closeConnection);
  }

  void _getAllMessagesFromChatId() async {
    chatStates.setValue(LoadingChatStates());
    final chatId = getAllMessagesFromChatId.value;

    final response = await chatUsecases.getAllMessagesFromChat(chatId);

    response.fold(
      (messages) => chatStates.setValue(SuccessChatStates(messages: messages)),
      (failure) => chatStates.setValue(
        ErrorChatStates(
          whatsappException: failure,
        ),
      ),
    );
  }

  _closeConnection() async {
    chatStates.setValueWithoutReaction(InitialChatStates());
    await chatUsecases.closeConnection();
  }
}
