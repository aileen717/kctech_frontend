class UserAuth {
  final int id;
  final String username;
  final String email;
  final String password;

  UserAuth({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}
