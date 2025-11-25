class CategoriesModel {
  final String id;
  final String name;
  final String createdAt;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}
