import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_simple_news_app/newsresponse.dart';
import 'package:http/http.dart' as http;

Future<NewsResponse> fetchTopNews() async {
  final response = await http.get(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=174afd1d0c274c4dad5abeca023b8655');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return NewsResponse.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple News App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple News App'),
        ),
      ),
    );
  }
}
