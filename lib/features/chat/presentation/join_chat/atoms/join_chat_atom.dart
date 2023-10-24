import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/states/join_chat_states.dart';

final chatState = Atom<JoinChatStates>(InitialJoinChatState());

final connectToChat = Atom<ChatMessageEntity>(ChatMessageEntity.empty());
