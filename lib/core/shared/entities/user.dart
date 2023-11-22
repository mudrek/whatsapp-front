class User {
  final int? id;
  final String name;
  final String username;
  final String? email;
  final String? password;

  User({
    required this.name,
    required this.username,
    required this.email,
    this.password,
    this.id,
  });

  static User empty() {
    return User(
      name: '',
      username: '',
      email: '',
    );
  }
}
