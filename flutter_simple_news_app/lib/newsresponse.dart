import 'package:flutter_simple_news_app/article.dart';

class NewsResponse {
  final List<Article> articles;

  NewsResponse({this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      articles: json['articles'].cast<Article>(),
    );
  }
}
