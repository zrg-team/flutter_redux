import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class DashboardState {
  // properties
  final List<Object> news;
  final List<Object> hot;

  // constructor with default
  DashboardState({
    this.news,
    this.hot
  });

  // allows to modify AuthState parameters while cloning previous ones
  DashboardState copyWith({
    List<Object> news,
    List<Object> hot
  }) {
    return new DashboardState(
      news: news ?? this.news,
      hot: hot ?? this.hot
    );
  }

  factory DashboardState.fromJSON(Map<String, dynamic> input) => new DashboardState(
    news: json != null ? json.decode(input['news']) : [],
    hot: json != null ? json.decode(input['hot']) : []
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'news': json.encode(this.news),
    'hot': json.encode(this.hot)
  };

  @override
  String toString() {
    return '''{
      news: $news
      hot: $hot
    }''';
  }
}