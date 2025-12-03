class RatingModel {
  final String bookId;
  final int rate;

  RatingModel({required this.bookId, required this.rate});
  Map<String, dynamic> toJson() => {"rate": rate};
}
