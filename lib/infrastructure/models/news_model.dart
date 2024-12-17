// models/news_model.dart
class NewsModel {
  final String uuid;
  final bool isActive;
  final bool isDeleted;
  final DateTime publicationDate;
  final String summary;
  final String title;
  final String? image;
  final String? newsUrl;
  final String? author;
  final bool isPrincipal;
  final String? imageUrl;

  NewsModel({
    required this.uuid,
    required this.isActive,
    required this.isDeleted,
    required this.publicationDate,
    required this.summary,
    required this.title,
    this.image,
    this.newsUrl,
    this.author,
    required this.isPrincipal,
    this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      uuid: json['uuid'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      publicationDate: DateTime.parse(json['publicationDate'] ?? ''),
      summary: json['summary'] ?? '',
      title: json['title'] ?? '',
      image: json['image'],
      newsUrl: json['newsUrl'],
      author: json['author'],
      isPrincipal: json['isPrincipal'] ?? false,
      imageUrl: json['imageUrl'],
    );
  }
}
