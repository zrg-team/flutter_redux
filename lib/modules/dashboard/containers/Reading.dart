import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/components/ReadingView.dart';
import 'package:cat_dog/common/actions/common.dart';

class Reading extends StatelessWidget {
  final dynamic news;
  final BuildContext scaffoldContext;
  Reading({
    Key key,
    Object news,
    BuildContext scaffoldContext
  }) :
  news = news,
  scaffoldContext = scaffoldContext,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return {
          'readingCount': store.state.common.readingCount,
          'addReadingCount': () {
            store.dispatch(addReadingCountAction());
          },
          'clearReadingCount': () {
            store.dispatch(clearReadingCountAction());
          }
        };
      },
      builder: (BuildContext context, props) {
        return new ReadingView(
          key: key,
          news: news,
          scaffoldContext: scaffoldContext,
          readingCount: props['readingCount'],
          addReadingCount: props['addReadingCount'],
          clearReadingCount: props['clearReadingCount']
        );
      }
    );
  }
}