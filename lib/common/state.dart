import 'package:meta/meta.dart';

import 'package:cat_dog/common/states/common.dart';
import 'package:cat_dog/modules/user/state.dart';

@immutable
class AppState {
  final AuthState auth;
  final CommonState common;

  AppState({ AuthState auth, CommonState common }):
    auth = auth ?? new AuthState(),
    common = common ?? new CommonState();

  static AppState rehydrationJSON(dynamic json) {
    return new AppState(
      auth: json != null ? new AuthState.fromJSON(json['auth']) : new AuthState(),
      common: json != null ? new CommonState.fromJSON(json['common']) : new CommonState()
    );
  }

  Map<String, dynamic> toJson() => {
    'auth': auth.toJSON(),
    'common': common.toJSON()
  };

  AppState copyWith({
    bool rehydrated,
    AuthState auth,
    CommonState common
  }) {
    return new AppState(
      auth: auth ?? this.auth,
      common: common ?? this.common
    );
  }
}