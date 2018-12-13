import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/category/components/SubNewsView.dart';
import 'package:cat_dog/modules/user/actions.dart';

class SubNews extends StatelessWidget {
  final dynamic category;
  final BuildContext scaffoldContext;
  SubNews({Key key, scaffoldContext, category}) :
  category = category,
  scaffoldContext = scaffoldContext,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return {
          'saveNews': (item) async => 
            await saveNewsAction(store, item)
        };
      },
      builder: (BuildContext context, props) {
        return new SubNewsView(
          key: key,
          category: category,
          saveNews: props['saveNews'],
          scaffoldContext: scaffoldContext
        );
      }
    );
  }
}