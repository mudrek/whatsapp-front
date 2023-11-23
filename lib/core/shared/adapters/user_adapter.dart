import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

class UserAdapter {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'password': user.password,
    };
  }
}
