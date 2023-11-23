import 'package:kydrem_whatsapp/core/shared/entities/message.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

class Chat {
  final int id;
  final User fromUser;
  final User toUser;
  final Message? lastMessage;
  User? sender;

  Chat({
    required this.id,
    required this.fromUser,
    required this.toUser,
    this.lastMessage,
    this.sender,
  });
}
