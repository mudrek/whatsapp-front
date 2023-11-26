import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_message_dialog.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_profile_image.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/core/utils/scroll_physics_chat.dart';
import 'package:kydrem_whatsapp/features/chat/domain/dtos/send_message_dto.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/atoms/chat_atom.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/chat_states.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/send_message_states.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/widgets/chat_message_user_widget.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/widgets/chat_message_widget.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController controller = ScrollController();
  final ScrollController textFieldController = ScrollController();

  final TextEditingController textEditingController = TextEditingController();

  bool shouldGoToEndPage = false;
  bool firstOpen = true;

  @override
  void initState() {
    super.initState();
    getAllMessagesFromChatId.setValue(widget.chat.id);
  }

  @override
  Widget build(BuildContext context) {
    final sendStates = context.select(() => sendMessageStates.value);

    if (sendStates is ErrorSendMessagesStates) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessageDialog(
          title: 'Falha ao enviar mensagem',
          message: 'Não foi possível enviar a mensagem no momento',
        ).show(context);
      });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppProfileImage(),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.chat.sender?.username ?? '',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final chatState =
                            context.select(() => chatStates.value);

                        if (chatState is LoadingChatStates) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (chatState is SuccessChatStates) {
                          // _listenChatUpdates(chatState.messages);
                          return StreamBuilder(
                            stream: chatState.messages,
                            builder: (context, snapshot) {
                              final messagesList = snapshot.data;

                              if (messagesList != null) {
                                return ListView.builder(
                                  reverse: true,
                                  controller: controller,
                                  itemCount: messagesList.length,
                                  cacheExtent: double.maxFinite,
                                  physics: const ScrollPhysicsChat(),
                                  itemBuilder: (context, index) {
                                    final reversedIndex =
                                        messagesList.length - 1 - index;

                                    final message = messagesList[reversedIndex];

                                    return message.isLoggedUserSentMessage
                                        ? ChatMessageUserWidget(
                                            message: message,
                                          )
                                        : ChatMessageWidget(message: message);
                                  },
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 4),
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
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: InkWell(
                            onTap: onClickSendMessage,
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
      ),
    );
  }

  void onClickSendMessage() {
    if (textEditingController.text.isNotEmpty) {
      sendMessage.setValue(
        SendMessageDTO(
            chatId: widget.chat.id, text: textEditingController.text),
      );

      textEditingController.clear();
    }
  }

  @override
  void dispose() {
    closeChatConnection();
    super.dispose();
  }
}
