import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/domain/dtos/send_message_dto.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/chat_states.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/send_message_states.dart';

final chatStates = Atom<ChatStates>(InitialChatStates());

final getAllMessagesFromChatId = Atom<int>(0);

final sendMessage = Atom<SendMessageDTO>(SendMessageDTO.empty());

final sendMessageStates = Atom<SendMessagesStates>(InitialSendMessagesStates());

final closeChatConnection = Atom.action();
