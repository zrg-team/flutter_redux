import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:cat_dog/presentation/platform_adaptive.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/common/components/InputFields.dart';
import 'package:cat_dog/modules/user/components/SignInButton.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = new GlobalKey<FormState>();

  String _username;
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return (BuildContext context, String username, String password) => 
          store.dispatch(login(context, username, password));
      },
      builder: (BuildContext context, loginAction) {
        return new Form(
            key: formKey,
            child: new Column(
              children: [
                new InputFieldArea(
                  hint: "Username",
                  obscureText: false,
                  icon: Icons.person_outline,
                  validator: (val) =>
                    val.isEmpty ? 'Please enter your username.' : null,
                  onSaved: (val) => _username = val,
                ),
                new InputFieldArea(
                  hint: "Password",
                  icon: Icons.lock_outline,
                  validator: (val) =>
                    val.isEmpty ? 'Please enter your password.' : null,
                  onSaved: (val) => _password = val,
                  obscureText: true,
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new PlatformAdaptiveButton(
                    onPressed:() {
                      _submit();
                      loginAction(context, _username, _password);
                    },
                    icon: new Icon(Icons.done),
                    child: new SignInButton(),
                  ),
                )
              ],
            ),
        );
      }
    );
  }
}