import 'package:asp/asp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/atoms/join_chat_atom.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/states/join_chat_states.dart';

class JoinChatPage extends StatefulWidget {
  const JoinChatPage({super.key});

  @override
  State<JoinChatPage> createState() => _JoinChatPageState();
}

class _JoinChatPageState extends State<JoinChatPage> {
  @override
  void initState() {
    super.initState();
    connectToChat.setValue(
      ChatMessageEntity(
        content: '',
        sender: 'Usuário digitado',
        type: MessageType.join,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [chatState, connectToChat]);

    if (chatState.value is SuccessJoinChatState) {
      final state = chatState.value as SuccessJoinChatState;

      Modular.to.navigate('./text-chat', arguments: state.chatMessageEntity);
      // debugPrint('entrou>>>>');
      // final state = chatState.value as SuccessJoinChatState;
      // state.chatMessageEntity.listen((event) {
      //   debugPrint("CHAT >>>>");
      //   for (var element in event) {
      //     debugPrint(
      //         "Pessoa: ${element.sender}, Tipo: ${element.type.getString()}, Mensagem: ${element.content}");
      //   }
      // });
    }

    return const Placeholder();
  }
}
