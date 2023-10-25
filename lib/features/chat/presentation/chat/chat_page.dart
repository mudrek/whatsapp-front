import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/features/chat/domain/arguments/chat_page_argument.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/atoms/chat_atom.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/widgets/chat_message_user_widget.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/widgets/chat_message_widget.dart';

class ChatPage extends StatefulWidget {
  final ChatPageArgument chatPageArgument;

  const ChatPage({super.key, required this.chatPageArgument});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController controller = ScrollController();
  final ScrollController textFieldController = ScrollController();

  final TextEditingController textEditingController = TextEditingController();

  Stream<List<ChatMessageEntity>> get chatMessageEntity =>
      widget.chatPageArgument.chatMessageEntity;
  String get username => widget.chatPageArgument.username;

  bool shouldGoToEndPage = false;

  @override
  void initState() {
    super.initState();
    _configScrollList();
  }

  // TODO achar outra forma
  _configScrollList() {
    chatMessageEntity.asBroadcastStream().listen((event) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.grey[800],
          elevation: 0,
          centerTitle: true,
          title: const Text('Chat público'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: chatMessageEntity,
                    builder: (context, snapshot) {
                      final listChatMessageEntity = snapshot.data;

                      if (listChatMessageEntity != null) {
                        return ListView.builder(
                          controller: controller,
                          itemCount: listChatMessageEntity.length,
                          cacheExtent: double.maxFinite,
                          itemBuilder: (context, index) {
                            final chatMessageEntity =
                                listChatMessageEntity[index];

                            switch (chatMessageEntity.type) {
                              case MessageType.join:
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: Text(
                                    '${chatMessageEntity.sender} acabou de Entrar',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              case MessageType.chat:
                                if (username == chatMessageEntity.sender) {
                                  return ChatMessageUserWidget(
                                      chatMessageEntity: chatMessageEntity);
                                }
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
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
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
                            controller: textEditingController,
                            scrollController: textFieldController,
                            maxLines: 6,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Mensagem...',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.grey[800],
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
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
                          color: Colors.blue,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              sendMessage.setValue(
                                ChatMessageEntity(
                                  content: textEditingController.text,
                                  sender: username,
                                  type: MessageType.chat,
                                ),
                              );

                              textEditingController.clear();
                            }
                          },
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          child: const Icon(
                            Icons.send,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    closeConnectionAction();
    super.dispose();
  }
}
