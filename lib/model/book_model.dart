import 'package:store/model/categories_model.dart';
import 'package:store/model/comment_model.dart';
import 'package:store/model/user_model.dart';

class BookModel {
  final String id;
  final String userId;
  final UserModel user;
  final String title;
  final String description;
  final String image;
  final String autherName;
  final String publishedAt;
  final int pageNumbers;
  num totalRatings;
  final List<CategoriesModel> categories;
  final List<CommentModel> comments;

  BookModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.title,
    required this.description,
    required this.image,
    required this.autherName,
    required this.publishedAt,
    required this.pageNumbers,
    required this.totalRatings,
    required this.categories,
    required this.comments,
  });
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      userId: json['userId'],
      user: UserModel.fromJson(json['user']),
      title: json['title'],
      description: json['description'],
      image: json['image'],
      autherName: json['autherName'],
      publishedAt: json['publishedAt'],
      pageNumbers: json['pageNumbers'],
      totalRatings: json['totalRatings'],
      categories: (json['categories'] as List)
          .map((cat) => CategoriesModel.fromJson(cat))
          .toList(),
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
    );
  }
}
