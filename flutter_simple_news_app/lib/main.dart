import 'package:flutter/material.dart';
import 'package:flutter_simple_news_app/data/repository.dart';
import 'package:scoped_model/scoped_model.dart';

import 'article_list_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple News App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ArticleListModelScreen(Repository()),
    );
  }
}

class ArticleListModelScreen extends StatefulWidget {
  final Repository _repository;

  ArticleListModelScreen(this._repository);

  @override
  State<StatefulWidget> createState() {
    return _ArticleListModelScreenState();
  }
}

class _ArticleListModelScreenState extends State<ArticleListModelScreen> {
  ArticleListModel _articleListModel;

  @override
  void initState() {
    _articleListModel = ArticleListModel(widget._repository);
    super.initState();
    _articleListModel.fetchTopNews();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _articleListModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Simple News App'),
          ),
          body: SafeArea(
            child: ScopedModelDescendant<ArticleListModel>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return _buildLoading();
                } else {
                  if (model.articleList != null) {
                    return _buildContent(model);
                  } else {
                    return _buildInit(model);
                  }
                }
              },
            ),
          ),
        ));
  }
}

Widget _buildInit(ArticleListModel articleListModel) {
  return Center(
    child: RaisedButton(
      child: Text('Fetch Top News'),
      onPressed: () {
        articleListModel.fetchTopNews();
      },
    ),
  );
}

Widget _buildContent(ArticleListModel articleListModel) {
  return Container(
    margin: EdgeInsets.all(2.0),
    child: ListView.builder(
      itemCount: articleListModel.articleList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 6.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Center(
              child: ListTile(
                leading: Image.network(
                  articleListModel.articleList[index].urlToImage,
                  width: 150,
                  height: 150,
                ),
                subtitle: Text(
                  articleListModel.articleList[index].title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
