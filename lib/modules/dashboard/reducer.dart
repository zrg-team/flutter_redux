import 'package:redux/redux.dart';

import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/state.dart';

Reducer<DashboardState> dashboardReducer = combineReducers([
  new TypedReducer<DashboardState, SetHotNews>(setHotNewsReducer),
  new TypedReducer<DashboardState, SetLatestNews>(setLatestNewsReducer),
  new TypedReducer<DashboardState, AppendHotNews>(appendHotNewsReducer),
  new TypedReducer<DashboardState, AppendLatestNews>(appendLatestNewsReducer)
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

DashboardState appendHotNewsReducer(DashboardState dashboard, AppendHotNews action) {
  dashboard.hot.addAll(action.news);
  return dashboard.copyWith(
    hot: dashboard.hot
  );
}

DashboardState appendLatestNewsReducer(DashboardState dashboard, AppendLatestNews action) {
  dashboard.news.addAll(action.news);
  return dashboard.copyWith(
    news: dashboard.news
  );
}