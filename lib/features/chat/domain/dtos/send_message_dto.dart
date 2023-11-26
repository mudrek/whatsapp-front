class SendMessageDTO {
  final int chatId;
  final String text;

  SendMessageDTO({required this.chatId, required this.text});

  static SendMessageDTO empty() {
    return SendMessageDTO(chatId: 0, text: '');
  }
}
