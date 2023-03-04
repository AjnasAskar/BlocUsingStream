import '../models/news_article_model.dart';

abstract class NewsState {}

class NewsLoadedState extends NewsState {
  NewsArticles? newsArticles;

  NewsLoadedState({this.newsArticles});
}

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {
  String? message;

  NewsErrorState({this.message});
}
