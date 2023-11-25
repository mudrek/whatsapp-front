import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

class Message {
  final int id;
  final String text;
  final User sender;
  final DateTime createdAt;
  bool isLoggedUserSentMessage;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
    this.isLoggedUserSentMessage = false,
  });
}
