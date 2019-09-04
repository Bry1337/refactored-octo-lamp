import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_news_app/data/article.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArticleDetailScreen(article),
    );
  }
}

class ArticleDetailScreen extends StatefulWidget {
  final Article _article;

  ArticleDetailScreen(this._article);

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailScreenState();
  }
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Article _article;

  @override
  void initState() {
    this._article = widget._article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _article.title,
          maxLines: 1,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Image.network(
                _article.urlToImage,
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  _article.title,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
