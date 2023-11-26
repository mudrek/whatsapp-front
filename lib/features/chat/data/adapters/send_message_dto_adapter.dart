import 'package:kydrem_whatsapp/features/chat/domain/dtos/send_message_dto.dart';

class SendMessageDTOAdapter {
  static Map<String, dynamic> toJson(SendMessageDTO sendMessageDTO) {
    return {
      'chat': {
        'id': sendMessageDTO.chatId,
      },
      'text': sendMessageDTO.text,
    };
  }
}
