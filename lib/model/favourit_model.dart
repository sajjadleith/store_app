import 'package:store/app_constant.dart';
import 'package:store/model/book_model.dart';

class FavouriteModel {
  final String id;
  final String userId;
  final String bookId;
  final BookModel book;
  final String createdAt;

  FavouriteModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.book,
    required this.createdAt,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      userId: json['userId'],
      bookId: json['bookId'],
      book: BookModel.fromJson(json['book']),
      createdAt: json['createdAt'],
    );
  }
}
