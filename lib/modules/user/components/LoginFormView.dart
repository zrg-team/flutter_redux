import 'package:flutter/material.dart';

import 'package:cat_dog/presentation/platform_adaptive.dart';
import 'package:cat_dog/common/components/InputFields.dart';
import 'package:cat_dog/modules/user/components/SignInButton.dart';

class LoginFormView extends StatefulWidget {
  final Function login;

  const LoginFormView({
    Key key,
    this.login
  }) : super(key: key);
  @override
  _LoginFormViewState createState() => new _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
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
                var result = widget.login(_username, _password);
                if (result) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
                }
              },
              icon: new Icon(Icons.done),
              child: new SignInButton(),
            ),
          )
        ],
      ),
    );
  }
}