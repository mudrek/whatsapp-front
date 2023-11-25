import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/states/chat_states.dart';

final chatStates = Atom<ChatStates>(InitialChatStates());

final getAllMessagesFromChatId = Atom<int>(0);

final closeChatConnection = Atom.action();
