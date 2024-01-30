class NewsModel {
  final String id;
  final String? userId;
  final String title;
  final String? slug;
  final String content;
  final String image;
  final String? isPublished;
  final String? url;
  final String? urlTitle;

  NewsModel({
    required this.id,
    this.userId,
    required this.title,
    this.slug,
    required this.content,
    required this.image,
    this.isPublished,
    this.url,
    this.urlTitle,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      title: json['title'],
      slug: json['slug'],
      content: json['content'],
      image: json['image'],
      isPublished: json['is_published'].toString(),
      url: json['url'],
      urlTitle: json['url_title'],
    );
  }
}
