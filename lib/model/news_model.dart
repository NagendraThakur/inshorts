// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:inshorts/model/category_model.dart';

class NewsModel {
  final String id;
  final String? userId;
  final String title;
  final String? slug;
  final String enContent;
  final String npContent;
  final String image;
  final String? isPublished;
  final String? url;
  final String? categoryId;
  final CategoryModel? category;
  final bool? isLiked;
  final bool? isBookMarked;

  NewsModel({
    required this.id,
    this.userId,
    required this.title,
    this.slug,
    required this.enContent,
    required this.npContent,
    required this.image,
    this.isPublished,
    this.url,
    this.categoryId,
    this.category,
    this.isLiked = false,
    this.isBookMarked = false,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      title: json['title'],
      slug: json['slug'].toString(),
      enContent: json['en_content'],
      npContent: json['np_content'],
      image: json['image'],
      isPublished: json['is_published'].toString(),
      url: json['url'],
      categoryId: json['category_id'],
      category: CategoryModel.fromJson(json['category']),
    );
  }

  NewsModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? slug,
    String? enContent,
    String? npContent,
    String? image,
    String? isPublished,
    String? url,
    String? categoryId,
    CategoryModel? category,
    bool? isLiked,
    bool? isBookMarked,
  }) {
    return NewsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      enContent: enContent ?? this.enContent,
      npContent: npContent ?? this.npContent,
      image: image ?? this.image,
      isPublished: isPublished ?? this.isPublished,
      url: url ?? this.url,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      isLiked: isLiked ?? this.isLiked,
      isBookMarked: isBookMarked ?? this.isBookMarked,
    );
  }
}
