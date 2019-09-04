import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_news_app/data/article.dart';
import 'package:flutter_simple_news_app/data/repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ArticleListModel extends Model {
  final Repository _repository;

  ArticleListModel(this._repository);

  bool _isLoading = false;
  List<Article> _articleList;

  List<Article> get articleList => _articleList;

  bool get isLoading => _isLoading;

  void fetchTopNews() {
    _isLoading = true;
    notifyListeners();
    _repository.fetchTopNews().then((newsresponse) {
      _articleList = newsresponse.articles;
      _isLoading = false;
      notifyListeners();
    }, onError: (error, stackTrace) {
      _isLoading = false;
      notifyListeners();
    });
  }

  static ArticleListModel of(BuildContext context) =>
      ScopedModel.of<ArticleListModel>(context);
}
