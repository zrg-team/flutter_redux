import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/dashboard/components/NewsTabView.dart';
import 'package:cat_dog/modules/user/actions.dart';

class NewsTab extends StatelessWidget {
  final Function refreshCallback;
  final BuildContext scaffoldContext;
  NewsTab({Key key, refreshCallback, scaffoldContext}) :
  refreshCallback = refreshCallback,
  scaffoldContext = scaffoldContext,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return {
          'getHotNews': () async => 
            await getHotNewsAction(store),
          'getLatestNews': () async => 
            await getLatestNewsAction(store),
          'saveNews': (item) async => 
            await saveNewsAction(store, item)
        };
      },
      builder: (BuildContext context, props) {
        return new NewsTabView(
          key: key,
          refreshCallback: refreshCallback,
          getHotNews: props['getHotNews'],
          getLatestNews: props['getLatestNews'],
          saveNews: props['saveNews'],
          scaffoldContext: scaffoldContext
        );
      }
    );
  }
}