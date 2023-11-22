import 'package:kydrem_whatsapp/features/search_user/domain/dto/create_chat_dto.dart';

class CreateChatDTOAdapter {
  static Map<String, dynamic> toJson(CreateChatDTO createChatDTO) {
    return {
      'toUser': {
        'id': createChatDTO.toUser,
      },
    };
  }
}
