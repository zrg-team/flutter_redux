import 'package:redux/redux.dart';

import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/state.dart';

Reducer<DashboardState> dashboardReducer = combineReducers([
  new TypedReducer<DashboardState, SetHotNews>(setHotNewsReducer),
  new TypedReducer<DashboardState, SetLatestNews>(setLatestNewsReducer)
]);

DashboardState setHotNewsReducer(DashboardState dashboard, SetHotNews action) {
  return dashboard.copyWith(
    hot: action.news
  );
}

DashboardState setLatestNewsReducer(DashboardState dashboard, SetLatestNews action) {
  return dashboard.copyWith(
    news: action.news
  );
}