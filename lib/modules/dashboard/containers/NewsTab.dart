import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/components/NewsTabView.dart';
import 'package:cat_dog/modules/user/actions.dart';
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
          'getMoreHotNews': (page) async => 
            await getMoreHotNewsAction(store, page),
          'getMoreLatestNews': (page) async => 
            await getMoreLatestNewsAction(store, page),
          'saveNews': (item) async => 
            await saveNewsAction(store, item)
        };
      },
      builder: (BuildContext context, props) {
        return new NewsTabView(
          key: key,
          hideCallback: hideCallback,
          getHotNews: props['getHotNews'],
          getLatestNews: props['getLatestNews'],
          saveNews: props['saveNews'],
          scaffoldContext: scaffoldContext,
          getMoreHotNews: props['getMoreHotNews'],
          getMoreLatestNews: props['getMoreLatestNews'],
          checkFirstOpen: props['checkFirstOpen']
        );
      }
    );
  }
}