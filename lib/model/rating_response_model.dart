import 'package:store/model/user_model.dart';

class RatingResponseModel {
  final String id;
  final String bookId;
  final String userId;
  final int rate;
  final String createdAt;

  RatingResponseModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rate,
    required this.createdAt,
  });
  factory RatingResponseModel.fromJson(Map<String, dynamic> json) {
    return RatingResponseModel(
      id: json['id'],
      bookId: json['bookId'],
      userId: json['userId'],
      rate: json['rate'],
      createdAt: json['createdAt'],
    );
  }
}
