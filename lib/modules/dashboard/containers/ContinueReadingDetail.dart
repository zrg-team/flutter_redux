import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/components/ContinueReadingDetailView.dart';
import 'package:cat_dog/common/actions/common.dart';

class ContinueReadingDetail extends StatelessWidget {
  final dynamic news;
  final dynamic lastNews;
  final dynamic nextNews;
  final dynamic newsKey;
  final Function onDismissed;
  final BuildContext scaffoldContext;
  ContinueReadingDetail({
    Key key,
    Object news,
    dynamic lastNews,
    dynamic nextNews,
    dynamic newsKey,
    Function onDismissed,
    BuildContext scaffoldContext
  }) :
  news = news,
  newsKey = newsKey,
  lastNews = lastNews,
  nextNews = nextNews,
  onDismissed = onDismissed,
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
        return new ContinueReadingDetailView(
          key: key,
          news: news,
          newsKey: newsKey,
          lastNews: lastNews,
          nextNews: nextNews,
          onDismissed: onDismissed,
          scaffoldContext: scaffoldContext,
          readingCount: props['readingCount'],
          addReadingCount: props['addReadingCount'],
          clearReadingCount: props['clearReadingCount']
        );
      }
    );
  }
}