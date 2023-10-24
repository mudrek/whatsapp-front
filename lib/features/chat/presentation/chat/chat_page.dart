import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';

class ChatPage extends StatefulWidget {
  final Stream<List<ChatMessageEntity>> chatMessageEntity;

  const ChatPage({super.key, required this.chatMessageEntity});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.chatMessageEntity,
        builder: (context, snapshot) {
          final listChatMessageEntity = snapshot.data;

          if (listChatMessageEntity != null) {
            return ListView.builder(
              itemCount: listChatMessageEntity.length,
              itemBuilder: (context, index) {
                final chatMessageEntity = listChatMessageEntity[index];

                switch (chatMessageEntity.type) {
                  case MessageType.join:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${chatMessageEntity.sender} acabou de Entrar',
                        textAlign: TextAlign.center,
                      ),
                    );
                  case MessageType.chat:
                    return Row(
                      children: [
                        Text(chatMessageEntity.sender),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(chatMessageEntity.content ?? '')
                      ],
                    );
                  case MessageType.leave:
                  case MessageType.empty:
                  default:
                    return const SizedBox.shrink();
                }
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
