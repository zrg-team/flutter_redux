import 'package:meta/meta.dart';

@immutable
class CommonState {
  // properties
  final String language;
  final String about;
  final bool first;
  final int readingCount;

  // constructor with default
  CommonState({
    this.language = 'en',
    this.first = true,
    this.about = '',
    this.readingCount = 0
  });

  // allows to modify AuthState parameters while cloning previous ones
  CommonState copyWith({
    bool first,
    String about,
    String language,
    int readingCount,
  }) {
    return new CommonState(
      first: first ?? this.first,
      about: about ?? this.about,
      language: language ?? this.language,
      readingCount: readingCount ?? this.readingCount
    );
  }

  factory CommonState.fromJSON(Map<String, dynamic> json) => new CommonState(
    first: json['first'],
    language: json['language'],
    about: json['about'],
    readingCount: json['readingCount']
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'first': this.first,
    'language': this.language,
    'about': this.about,
    'readingCount': this.readingCount
  };

  @override
  String toString() {
    return '''{
      first: $first,
      language: $language,
      about: $about,
      readingCount: $readingCount
    }''';
  }
}