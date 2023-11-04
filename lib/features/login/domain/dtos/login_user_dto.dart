class LoginUserDTO {
  final String username;
  final String password;

  LoginUserDTO({
    required this.username,
    required this.password,
  });

  static LoginUserDTO empty() {
    return LoginUserDTO(username: '', password: '');
  }
}
