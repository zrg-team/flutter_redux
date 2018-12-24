import 'package:meta/meta.dart';
import 'package:cat_dog/common/states/common.dart';
import 'package:cat_dog/modules/user/state.dart';
import 'package:cat_dog/modules/dashboard/state.dart';

@immutable
class AppState {
  final UserState user;
  final CommonState common;
  final DashboardState dashboard;

  AppState({ UserState user, CommonState common, DashboardState dashboard }):
    user = user ?? new UserState(),
    dashboard = dashboard ?? new DashboardState(),
    common = common ?? new CommonState();

  static AppState rehydrationJSON(dynamic json) {
    return new AppState(
      user: json != null ? new UserState.fromJSON(json['user']) : new UserState(),
      common: json != null ? new CommonState.fromJSON(json['common']) : new CommonState(),
      dashboard: json != null ? new DashboardState.fromJSON(json['dashboard']) : new DashboardState()
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJSON(),
    'common': common.toJSON(),
    'dashboard': dashboard.toJSON()
  };

  AppState copyWith({
    bool rehydrated,
    UserState user,
    CommonState common,
    DashboardState dashboard
  }) {
    return new AppState(
      user: user ?? this.user,
      common: common ?? this.common,
      dashboard: dashboard ?? this.dashboard
    );
  }
}