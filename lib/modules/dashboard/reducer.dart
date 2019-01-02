import 'package:redux/redux.dart';

import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/state.dart';

Reducer<DashboardState> dashboardReducer = combineReducers([
  new TypedReducer<DashboardState, SetHotNews>(setHotNewsReducer),
  new TypedReducer<DashboardState, AppendHotNews>(appendHotNewsReducer),
  new TypedReducer<DashboardState, SetLatestNews>(setLatestNewsReducer),
  new TypedReducer<DashboardState, AppendLatestNews>(appendLatestNewsReducer),
  new TypedReducer<DashboardState, SetTopicNews>(setTopicNewsReducer),
  new TypedReducer<DashboardState, AppendTopicNews>(appendTopicNewsReducer),
  new TypedReducer<DashboardState, SetVideoNews>(setVideoNewsReducer),
  new TypedReducer<DashboardState, AppendVideoNews>(appendVideoNewsReducer)
]);

DashboardState setHotNewsReducer(DashboardState dashboard, SetHotNews action) {
  return dashboard.copyWith(
    hot: action.news
  );
}

DashboardState appendHotNewsReducer(DashboardState dashboard, AppendHotNews action) {
  dashboard.hot.addAll(action.news);
  return dashboard.copyWith(
    hot: dashboard.hot
  );
}

DashboardState setLatestNewsReducer(DashboardState dashboard, SetLatestNews action) {
  return dashboard.copyWith(
    news: action.news
  );
}

DashboardState appendLatestNewsReducer(DashboardState dashboard, AppendLatestNews action) {
  dashboard.news.addAll(action.news);
  return dashboard.copyWith(
    news: dashboard.news
  );
}

DashboardState setTopicNewsReducer(DashboardState dashboard, SetTopicNews action) {
  return dashboard.copyWith(
    topicNews: action.news
  );
}

DashboardState appendTopicNewsReducer(DashboardState dashboard, AppendTopicNews action) {
  dashboard.topicNews.addAll(action.news);
  return dashboard.copyWith(
    topicNews: dashboard.topicNews
  );
}

DashboardState setVideoNewsReducer(DashboardState dashboard, SetVideoNews action) {
  return dashboard.copyWith(
    videos: action.news
  );
}

DashboardState appendVideoNewsReducer(DashboardState dashboard, AppendVideoNews action) {
  dashboard.videos.addAll(action.news);
  return dashboard.copyWith(
    videos: dashboard.videos
  );
}