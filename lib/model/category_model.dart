// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? categoryColor;
  final int? status;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.categoryColor,
    this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      categoryColor: json['category_color'],
      status: json['status'],
    );
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? categoryColor,
    int? status,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      categoryColor: categoryColor ?? this.categoryColor,
      status: status ?? this.status,
    );
  }
}
