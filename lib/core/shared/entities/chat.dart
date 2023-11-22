import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

class Chat {
  final int id;
  final User fromUser;
  final User toUser;

  Chat({required this.id, required this.fromUser, required this.toUser});
}
