class UserModel {
  final String id;
  final String userName;
  final String email;
  final int role;
  final String createdAt;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }
}
