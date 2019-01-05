import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/components/NewsTabView.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/modules/soccer/actions.dart';
import 'package:cat_dog/common/actions/common.dart';

class NewsTab extends StatelessWidget {
  // final Function refreshCallback;
  final Function hideCallback;
  final BuildContext scaffoldContext;
  NewsTab({Key key, hideCallback, scaffoldContext}) :
  hideCallback = hideCallback,
  scaffoldContext = scaffoldContext,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return {
          'checkFirstOpen': () {
            if (store.state.common.first) {
              store.dispatch(setFirstOpenAction());
            }
          },
          'getHotNews': (page) async => 
            await getHotNewsAction(store, page),
          'getLatestNews': (page) async => 
            await getLatestNewsAction(store, page),
          'getTopicNews': (page) async => 
            await getTopicNewsAction(store, page),
          'getVideoNews': (page) async => 
            await getVideoNewsAction(store, page),
          'getMoreHotNews': (page) async => 
            await getMoreHotNewsAction(store, page),
          'getMoreLatestNews': (page) async => 
            await getMoreLatestNewsAction(store, page),
          'getMoreTopicNews': (page) async => 
            await getMoreTopicNewsAction(store, page),
          'getMoreVideoNews': (page) async => 
            await getMoreVideoNewsAction(store, page),
          'getSoccerCalendar': () => 
            getSoccerCalendarAction(store),
          'saveNews': (item) async => 
            await saveNewsAction(store, item),
          'shouldLoading': store.state.dashboard.hot == null || store.state.dashboard.hot.length == 0
        };
      },
      builder: (BuildContext context, props) {
        return new NewsTabView(
          key: key,
          hideCallback: hideCallback,
          getHotNews: props['getHotNews'],
          getLatestNews: props['getLatestNews'],
          getMoreHotNews: props['getMoreHotNews'],
          getTopicNews: props['getTopicNews'],
          getVideoNews: props['getVideoNews'],
          getMoreTopicNews: props['getMoreTopicNews'],
          getMoreVideoNews: props['getMoreVideoNews'],
          getMoreLatestNews: props['getMoreLatestNews'],
          checkFirstOpen: props['checkFirstOpen'],
          shouldLoading: props['shouldLoading'],
          saveNews: props['saveNews'],
          getSoccerCalendar: props['getSoccerCalendar'],
          scaffoldContext: scaffoldContext,
        );
      }
    );
  }
}