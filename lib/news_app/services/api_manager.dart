import 'dart:convert';

import 'package:bloc_using_stream/news_app/models/news_article_model.dart';
import 'package:http/http.dart' as http;

import '../constants/strings.dart';

class ApiManager {
  Future<NewsArticles?> getNews() async {
    var client = http.Client();
    NewsArticles? _newsArticle;
    try {
      var response = await client.get(Uri.parse(Strings.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        _newsArticle = NewsArticles.fromJson(jsonMap);
      }
    } on Exception catch (_) {
      return _newsArticle;
    }

    return _newsArticle;
  }
}
