import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/components/SavedNewsView.dart';
import 'package:cat_dog/modules/user/actions.dart';

class SavedNews extends StatelessWidget {
  final BuildContext scaffoldContext;
  SavedNews({Key key, BuildContext scaffoldContext}) :
  scaffoldContext = scaffoldContext,
  super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return (item) => store.dispatch(removeSavedNewsAction(item));
      },
      builder: (BuildContext context, removeSavedNews) {
        return new SavedNewsView(
          key: key,
          scaffoldContext: scaffoldContext,
          removeSavedNews: removeSavedNews
        );
      }
    );
  }
}