import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/components/SavedNewsView.dart';

class SavedNews extends StatelessWidget {
  SavedNews({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return [];
      },
      builder: (BuildContext context, login) {
        return new SavedNewsView(
          key: key
        );
      }
    );
  }
}