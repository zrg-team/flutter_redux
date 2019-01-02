import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class DashboardState {
  // properties
  final List<Object> news;
  final List<Object> hot;
  final List<Object> topicNews;
  final List<Object> videos;

  // constructor with default
  DashboardState({
    this.news,
    this.hot,
    this.topicNews,
    this.videos
  });

  // allows to modify AuthState parameters while cloning previous ones
  DashboardState copyWith({
    List<Object> news,
    List<Object> hot,
    List<Object> topicNews,
    List<Object> videos
  }) {
    return new DashboardState(
      news: news ?? this.news,
      hot: hot ?? this.hot,
      topicNews: topicNews ?? this.topicNews,
      videos: videos ?? this.videos
    );
  }

  factory DashboardState.fromJSON(Map<String, dynamic> input) => new DashboardState(
    news: json != null ? json.decode(input['news']) : [],
    hot: json != null ? json.decode(input['hot']) : [],
    topicNews: json != null ? json.decode(input['topicNews']) : [],
    videos: json != null ? json.decode(input['videos']) : []
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'news': json.encode(this.news),
    'hot': json.encode(this.hot),
    'topicNews': json.encode(this.topicNews),
    'videos': json.encode(this.videos)
  };

  @override
  String toString() {
    return '''{
      news: $news
      hot: $hot
      topicNews: $topicNews
      videos: $videos
    }''';
  }
}