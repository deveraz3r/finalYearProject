// models/user.dart
class User {
  final String username;
  final String email;
  final String role;
  
  User({
    required this.username,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      role: map['role'],
    );
  }
}
