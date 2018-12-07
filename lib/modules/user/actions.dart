import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:cat_dog/modules/user/models/user.dart';
import 'package:cat_dog/common/state.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  final User user;

  UserLoginSuccess(this.user);
}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

final Function login = (BuildContext context, String username, String password) {
  return (Store<AppState> store) {
    store.dispatch(new UserLoginRequest());
    if (username == 'asd' && password == 'asd') {
      store.dispatch(new UserLoginSuccess(new User('placeholder_token', 'placeholder_id')));
      Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
    } else {
      store.dispatch(new UserLoginFailure('Username or password were incorrect.'));
    }
  };
};

final Function logout = (BuildContext context) {
  return (Store<AppState> store) {
    store.dispatch(new UserLogout());
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  };
};