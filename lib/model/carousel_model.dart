import 'package:store/app_constant.dart';
import 'package:store/core/app_constains.dart';

class CarouselModel {
  final String image;
  final String title;
  final String autherName;
  final String publishedAt;
  final int totalRatings;

  CarouselModel({
    required this.image,
    required this.title,
    required this.autherName,
    required this.publishedAt,
    required this.totalRatings,
  });
  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      // image: "${AppConstant.imagesBase}${json['image']}",
      image: "https://book-backend-65sn.onrender.com${json['image']}",
      title: json['title'],
      autherName: json['autherName'],
      publishedAt: json['publishedAt'],
      totalRatings: json["totalRatings"],
    );
  }
}
