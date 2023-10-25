import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/chat/domain/arguments/chat_page_argument.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/atoms/join_chat_atom.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/states/join_chat_states.dart';

class JoinChatPage extends StatefulWidget {
  const JoinChatPage({super.key});

  @override
  State<JoinChatPage> createState() => _JoinChatPageState();
}

class _JoinChatPageState extends State<JoinChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  ChatMessageEntity? chatMessageEntity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [chatState, connectToChat]);

    if (chatState.value is SuccessJoinChatState && chatMessageEntity != null) {
      final state = chatState.value as SuccessJoinChatState;

      Modular.to.pushNamed('./text-chat',
          arguments: ChatPageArgument(
            chatMessageEntity: state.chatMessageEntity,
            username: chatMessageEntity!.sender,
          ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Digite seu nome para entrar no chat!'),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: textEditingController,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  chatMessageEntity = ChatMessageEntity(
                    content: '',
                    sender: textEditingController.text,
                    type: MessageType.join,
                  );
                  connectToChat.setValue(
                    chatMessageEntity!,
                  );
                }
              },
              child: const Text(
                'Entrar na conversa!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
