import 'package:asp/asp.dart';

import '../../../domain/entities/chat_message_entity.dart';

final sendMessage = Atom<ChatMessageEntity>(ChatMessageEntity.empty());

final closeConnectionAction = Atom.action();
