import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

import 'newsresponse.dart';

class Repository {
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
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}
