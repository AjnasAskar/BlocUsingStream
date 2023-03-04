import 'package:bloc_using_stream/news_app/bloc/news_bloc.dart';
import 'package:bloc_using_stream/news_app/bloc/news_events.dart';
import 'package:bloc_using_stream/news_app/bloc/news_state.dart';
import 'package:bloc_using_stream/news_app/models/news_article_model.dart';
import 'package:bloc_using_stream/news_app/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsMainPage extends StatefulWidget {
  const NewsMainPage({Key? key}) : super(key: key);

  @override
  _NewsMainPageState createState() => _NewsMainPageState();
}

class _NewsMainPageState extends State<NewsMainPage> {
  late NewsBloc newsBloc;

  @override
  void initState() {
    newsBloc = NewsBloc();
    newsBloc.eventSink.add(FetchNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: StreamBuilder<NewsState>(
        stream: newsBloc.newsStream,
        builder: (context, snapshot) {
          if (snapshot.data is NewsLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ));
          }
          if (snapshot.data is NewsLoadedState) {
            NewsLoadedState? loadedState = snapshot.data as NewsLoadedState;
            return ListView.builder(
                itemCount: loadedState.newsArticles?.news?.length ?? 0,
                itemBuilder: (context, index) {
                  News? article = loadedState.newsArticles?.news?[index];
                  var formattedTime =
                      DateFormat('dd MMM - HH:mm').format(DateTime.now());
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                color: Colors.grey,
                              )),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(formattedTime),
                              Text(
                                article?.headline ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                article?.body ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }
}
