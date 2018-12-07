import 'package:meta/meta.dart';

@immutable
class CommonState {
  // properties
  final String language;
  final bool first;

  // constructor with default
  CommonState({
    this.language = 'en',
    this.first = false
  });

  // allows to modify AuthState parameters while cloning previous ones
  CommonState copyWith({
    bool first,
    String language
  }) {
    return new CommonState(
      first: first ?? this.first,
      language: language ?? this.language
    );
  }

  factory CommonState.fromJSON(Map<String, dynamic> json) => new CommonState(
    first: json['first'],
    language: json['language']
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'first': this.first,
    'language': this.language
  };

  @override
  String toString() {
    return '''{
      first: $first,
      language: $language
    }''';
  }
}