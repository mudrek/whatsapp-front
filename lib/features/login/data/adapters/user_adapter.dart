import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';

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
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'password': user.password,
    };
  }
}
