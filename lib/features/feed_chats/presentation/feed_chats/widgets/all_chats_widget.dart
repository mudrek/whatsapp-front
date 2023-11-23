import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

class AllChatWidget extends StatelessWidget {
  final List<Chat> chats;

  const AllChatWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        left: 8,
      ),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              height: 60,
              color: Colors.grey[900],
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.toUser.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    chat.lastMessage != null
                        ? chat.lastMessage!.text
                        : "Sem mensagens ainda",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
