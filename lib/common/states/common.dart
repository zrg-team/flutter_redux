import 'package:meta/meta.dart';

@immutable
class CommonState {
  // properties
  final String language;
  final String about;
  final bool first;

  // constructor with default
  CommonState({
    this.language = 'en',
    this.first = false,
    this.about = ''
  });

  // allows to modify AuthState parameters while cloning previous ones
  CommonState copyWith({
    bool first,
    String about,
    String language
  }) {
    return new CommonState(
      first: first ?? this.first,
      about: about ?? this.about,
      language: language ?? this.language
    );
  }

  factory CommonState.fromJSON(Map<String, dynamic> json) => new CommonState(
    first: json['first'],
    language: json['language'],
    about: json['about']
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'first': this.first,
    'language': this.language,
    'about': this.about
  };

  @override
  String toString() {
    return '''{
      first: $first,
      language: $language,
      about: $about,
    }''';
  }
}