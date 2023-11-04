import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';

class LoginUserDTOAdapter {
  static Map<String, dynamic> toJson(LoginUserDTO loginUserDTO) {
    return {
      'username': loginUserDTO.username,
      'password': loginUserDTO.password,
    };
  }
}
