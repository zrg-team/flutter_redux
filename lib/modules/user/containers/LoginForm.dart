import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/modules/user/components/LoginFormView.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return (String username, String password) => 
          store.dispatch(loginAction(username, password));
      },
      builder: (BuildContext context, login) {
        return new LoginFormView(
          key: key,
          login: login
        );
      }
    );
  }
}