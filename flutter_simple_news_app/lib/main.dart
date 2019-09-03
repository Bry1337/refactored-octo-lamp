import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_news_app/newsresponse.dart';
import 'package:http/io_client.dart';

Future<NewsResponse> fetchTopNews() async {
  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient();
  httpClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = IOClient(httpClient);
  final response = await ioClient.get(
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=174afd1d0c274c4dad5abeca023b8655',
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print(json.decode(response.body));
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
        body: Column(
          children: [
            RaisedButton(
              child: Text('Call News Api'),
              onPressed: fetchTopNews,
            )
          ],
        ),
      ),
    );
  }
}
