import 'news.dart';
import 'news_source.dart';

class NewsNba {
  List<News>? news;
  List<NewsSource>? newsSources;

  NewsNba({this.news, this.newsSources});

  factory NewsNba.fromJson(Map<String, dynamic> json) => NewsNba(
        news: (json['news'] as List<dynamic>?)
            ?.map((e) => News.fromJson(e as Map<String, dynamic>))
            .toList(),
        newsSources: (json['newsSources'] as List<dynamic>?)
            ?.map((e) => NewsSource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'news': news?.map((e) => e.toJson()).toList(),
        'newsSources': newsSources?.map((e) => e.toJson()).toList(),
      };
}
