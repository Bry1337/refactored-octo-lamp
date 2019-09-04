import 'dart:convert';

import 'package:flutter_simple_news_app/data/article.dart';

class NewsResponse {
  final List<Article> articles;

  NewsResponse(this.articles);

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var articleList = json['articles'] as List;
    List<Article> articles =
        articleList.map((i) => Article.fromJson(i)).toList();
    return NewsResponse(articles);
  }
}
