class CreateChatDTO {
  final int toUser;

  CreateChatDTO({required this.toUser});

  static CreateChatDTO empty() {
    return CreateChatDTO(
      toUser: 0,
    );
  }
}
