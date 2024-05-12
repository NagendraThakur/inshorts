import 'package:inshorts/model/category_model.dart';

class NewsModel {
  final String id;
  final String? userId;
  final String enTitle;
  final String npTitle;
  final String? slug;
  final String enContent;
  final String npContent;
  final String media;
  final String mediaType;
  final String? isPublished;
  final String? url;
  final String? categoryId;
  final CategoryModel? category;
  final bool? isLiked;
  final bool? isBookMarked;

  NewsModel({
    required this.id,
    this.userId,
    required this.enTitle,
    required this.npTitle,
    this.slug,
    required this.enContent,
    required this.npContent,
    required this.media,
    required this.mediaType,
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
      enTitle: json['en_title'],
      npTitle: json['np_title'],
      slug: json['slug'].toString(),
      enContent: json['en_content'],
      npContent: json['np_content'],
      media: json['media'],
      mediaType: json['media_type'],
      isPublished: json['is_published'].toString(),
      url: json['url'],
      categoryId: json['category_id'],
      category: CategoryModel.fromJson(json['category']),
      isLiked: json['isLiked'].toString() == "1" ? true : false,
      isBookMarked: json['isBookmarked'].toString() == "1" ? true : false,
    );
  }

  NewsModel copyWith({
    String? id,
    String? userId,
    String? enTitle,
    String? npTitle,
    String? slug,
    String? enContent,
    String? npContent,
    String? media,
    String? mediaType,
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
      enTitle: enTitle ?? this.enTitle,
      npTitle: npTitle ?? this.npTitle,
      slug: slug ?? this.slug,
      enContent: enContent ?? this.enContent,
      npContent: npContent ?? this.npContent,
      media: media ?? this.media,
      mediaType: mediaType ?? this.mediaType,
      isPublished: isPublished ?? this.isPublished,
      url: url ?? this.url,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      isLiked: isLiked ?? this.isLiked,
      isBookMarked: isBookMarked ?? this.isBookMarked,
    );
  }
}
