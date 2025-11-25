import 'package:store/model/user_model.dart';

class CommentModel {
  final String id;
  final String bookId;
  final String userId;
  final UserModel user;
  final String content;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.user,
    required this.content,
    required this.createdAt,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      bookId: json['bookId'],
      userId: json['userId'],
      user: UserModel.fromJson(json['user']),
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}
