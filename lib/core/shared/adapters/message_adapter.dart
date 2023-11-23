import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/message.dart';

class MessageAdapter {
  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: UserAdapter.fromJson(
        json['sender'],
      ),
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
