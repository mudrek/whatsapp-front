import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/widgets/chat_message_widget.dart';

class ChatPage extends StatefulWidget {
  final Stream<List<ChatMessageEntity>> chatMessageEntity;

  const ChatPage({super.key, required this.chatMessageEntity});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController controller = ScrollController();
  final ScrollController textFieldController = ScrollController();

  bool shouldGoToEndPage = false;

  @override
  void initState() {
    super.initState();
    _configScrollList();
  }

  _configScrollList() {
    widget.chatMessageEntity.asBroadcastStream().listen((event) {
      shouldGoToEndPage = true;
      setState(() {});
    });

    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (mounted) {
        if (shouldGoToEndPage &&
            controller.position.maxScrollExtent - controller.offset <= 200) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
          shouldGoToEndPage = false;
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: widget.chatMessageEntity,
                builder: (context, snapshot) {
                  final listChatMessageEntity = snapshot.data;

                  if (listChatMessageEntity != null) {
                    return ListView.builder(
                      controller: controller,
                      itemCount: listChatMessageEntity.length,
                      cacheExtent: double.maxFinite,
                      itemBuilder: (context, index) {
                        final chatMessageEntity = listChatMessageEntity[index];

                        switch (chatMessageEntity.type) {
                          case MessageType.join:
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: Text(
                                '${chatMessageEntity.sender} acabou de Entrar',
                                textAlign: TextAlign.center,
                              ),
                            );
                          case MessageType.chat:
                            return ChatMessageWidget(
                              chatMessageEntity: chatMessageEntity,
                            );
                          case MessageType.leave:
                          case MessageType.sentMessage:
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: RawScrollbar(
                      controller: textFieldController,
                      padding: const EdgeInsets.fromLTRB(0, 16, 10, 0),
                      thickness: 3,
                      child: TextField(
                        scrollController: textFieldController,
                        maxLines: 6,
                        minLines: 1,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.send,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
