import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_profile_image.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

class AllChatWidget extends StatelessWidget {
  final Stream<List<Chat>> chatsStream;

  const AllChatWidget({super.key, required this.chatsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatsStream,
      builder: (context, snapshot) {
        final chats = snapshot.data;

        if (chats == null) {
          return const Text('Chats NULL');
        }

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
                child: InkWell(
                  onTap: () {
                    Modular.to.pushNamed('/chat/', arguments: chat);
                  },
                  child: Container(
                    height: 60,
                    color: Colors.grey[900],
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const AppProfileImage(),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.sender?.username ??
                                  "Não foi possível recuperar o usuário",
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
