class CommentParamModel {
  final String bookId;
  final String content;

  CommentParamModel({required this.bookId, required this.content});
  Map<String, dynamic> toJson() => {"content": content};
}
