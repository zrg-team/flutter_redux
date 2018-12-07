import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:cat_dog/modules/user/components/LoginForm.dart';
import 'package:cat_dog/modules/user/styles.dart';
import 'package:cat_dog/styles/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: backgroundImage,
        ),
        child: new Padding(
          padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                  child: new Center(
                      child: new FlutterLogo(
                          colors: colorStyles['primary'],
                          size: 200.0,
                      ),
                  ),
              ),
              new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(15.0, MediaQuery.of(context).padding.top + 10.0, 15.0, 15.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)
                      ),
                      child: new LoginForm()
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}