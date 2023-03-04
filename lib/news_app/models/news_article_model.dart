class NewsArticles {
  List<News>? news;
  int? count;
  int? next;
  bool? eof;

  NewsArticles({this.news, this.count, this.next, this.eof});

  NewsArticles.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
    count = json['count'];
    next = json['next'];
    eof = json['eof'];
  }
}

class News {
  int? id;
  String? headline;
  String? abstract;
  String? body;
  String? author;
  String? section;
  String? date;
  String? articleUri;
  String? pfdUri;

  News(
      {this.id,
      this.headline,
      this.abstract,
      this.body,
      this.author,
      this.section,
      this.date,
      this.articleUri,
      this.pfdUri});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    abstract = json['abstract'];
    body = json['body'];
    author = json['author'];
    section = json['section'];
    date = json['date'];
    articleUri = json['article_uri'];
    pfdUri = json['pfd_uri'];
  }
}
