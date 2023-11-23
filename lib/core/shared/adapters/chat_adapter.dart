import 'package:kydrem_whatsapp/core/shared/adapters/message_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

class ChatAdapter {
  static Chat fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      fromUser: UserAdapter.fromJson(json['fromUser']),
      toUser: UserAdapter.fromJson(
        json['toUser'],
      ),
      lastMessage: json['lastMessage'] != null
          ? MessageAdapter.fromJson(
              json['lastMessage'],
            )
          : null,
    );
  }
}
