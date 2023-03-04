import 'dart:async';

import 'package:bloc_using_stream/news_app/bloc/news_events.dart';
import 'package:bloc_using_stream/news_app/bloc/news_state.dart';
import 'package:bloc_using_stream/news_app/models/news_article_model.dart';
import 'package:bloc_using_stream/news_app/services/api_manager.dart';

class NewsBloc {
  /// Controller used to handle state stream.
  final StreamController<NewsState> _stateStreamController =
      StreamController<NewsState>();

  ///Used for input state property (Made private because user not directly interact with it)
  StreamSink<NewsState> get _newsSink => _stateStreamController.sink;

  ///Used for output state property
  Stream<NewsState> get newsStream => _stateStreamController.stream;

  /// Controller used to handle event stream.
  final StreamController<NewsArticleEvents> _eventStreamController =
      StreamController<NewsArticleEvents>();

  ///Used for input event property
  StreamSink<NewsArticleEvents> get eventSink => _eventStreamController.sink;

  ///Used for output event property
  Stream<NewsArticleEvents> get _eventStream => _eventStreamController.stream;

  ///Listen to event while creating class instance inside constructor

  NewsBloc() {
    _eventStream.listen((NewsArticleEvents event) async {
      NewsArticles? _news;
      if (event == FetchNewsEvent()) {
        try {
          _newsSink.add(NewsLoadingState());
          _news = await ApiManager().getNews();
          _newsSink.add(NewsLoadedState(newsArticles: _news));
        } catch (e) {
          _newsSink.add(NewsErrorState(message: e.toString()));
        }
      }
    });
  }

  ///CLose all stream controllers to avoid memory leak
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
