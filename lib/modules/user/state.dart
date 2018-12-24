import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cat_dog/modules/user/models/user.dart';

@immutable
class UserState {
  // properties
  final bool isAuthenticated;
  final bool isAuthenticating;
  final User user;
  final String error;
  final List<Object> saved;

  // constructor with default
  UserState({
    this.isAuthenticated = false,
    this.isAuthenticating = false,
    this.user,
    this.error,
    this.saved = const []
  });

  // allows to modify AuthState parameters while cloning previous ones
  UserState copyWith({
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
    User user,
    List<Object> saved
  }) {
    return new UserState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
      user: user ?? this.user,
      saved: saved ?? this.saved,
    );
  }

  factory UserState.fromJSON(Map<String, dynamic> input) {
    return new UserState(
      isAuthenticated: input != null ? input['isAuthenticated'] : false,
      isAuthenticating: input != null ? input['isAuthenticating'] : false,
      error: input != null ? input['error'] : null,
      user: input != null && input['user'] != null ? new User.fromJSON(input['user']) : null,
      saved: input != null ? json.decode(input['saved']) : []
    );
  }

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'isAuthenticated': this.isAuthenticated,
    'isAuthenticating': this.isAuthenticating,
    'user': this.user == null ? null : this.user.toJSON(),
    'error': this.error,
    'saved': json.encode(this.saved)
  };

  @override
  String toString() {
    return '''{
      isAuthenticated: $isAuthenticated,
      isAuthenticating: $isAuthenticating,
      user: $user,
      error: $error,
      saved: $saved
    }''';
  }
}