import 'news.dart';
import 'news_source.dart';

class NhlNewsModel {
  List<nhlLNewsList>? news;
  List<NewsSource>? newsSources;

  NhlNewsModel({this.news, this.newsSources});

  factory NhlNewsModel.fromJson(Map<String, dynamic> json) => NhlNewsModel(
        news: (json['news'] as List<dynamic>?)
            ?.map((e) => nhlLNewsList.fromJson(e as Map<String, dynamic>))
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
