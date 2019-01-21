import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class SoccerState {
  // properties
  final List<dynamic> games;
  final List<dynamic> matchs;
  final List<dynamic> days;

  // constructor with default
  SoccerState({
    this.games,
    this.matchs,
    this.days
  });

  // allows to modify AuthState parameters while cloning previous ones
  SoccerState copyWith({
    List<dynamic> games,
    List<dynamic> matchs,
    List<dynamic> days
  }) {
    return new SoccerState(
      games: games ?? this.games,
      matchs: matchs ?? this.matchs,
      days: days ?? this.days
    );
  }

  factory SoccerState.fromJSON(Map<String, dynamic> input) => new SoccerState(
    games: json != null ? json.decode(input['games']) : [],
    matchs: json != null ? json.decode(input['matchs']) : [],
    days: json != null ? json.decode(input['days']) : []
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'games': json.encode(this.games),
    'matchs': json.encode(this.matchs),
    'days': json.encode(this.days)
  };

  @override
  String toString() {
    return '''{
      games: $games
      matchs: $matchs
      days: $days
    }''';
  }
}