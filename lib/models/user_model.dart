class UserModel {
  final String uid;
  final String email;
  final String role;
  final String username;
  final String? parentId;
  final String? doctorId;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.username,
    this.parentId,
    this.doctorId,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      username: data['username'] ?? data['name'] ?? '',
      parentId: data['parentId'],
      doctorId: data['doctorId'],
    );
  }
}
