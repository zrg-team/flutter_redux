import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';


class SetUserLanguage {
  final String language;
  SetUserLanguage(this.language);
}

final Function actionSetUserLanguage = (BuildContext context, String language) {
  return (Store<AppState> store) {
    if (language != '') {
      store.dispatch(new SetUserLanguage(language));
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
    }
  };
};