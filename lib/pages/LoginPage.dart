import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/modules/user/containers/LoginForm.dart';
import 'package:cat_dog/styles/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              AppColors.appBarGradientStart,
              AppColors.appBarGradientEnd
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp
          ),
        ),
        child: new Padding(
          padding: new EdgeInsets.fromLTRB(15.0, MediaQuery.of(context).padding.top + 15.0, 15.0, 15.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                  child: new Center(
                      child: new FlutterLogo(
                          colors: AppColors.primary,
                          size: 200.0,
                      ),
                  ),
              ),
              new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(15.0, MediaQuery.of(context).padding.top + 5.0, 15.0, 5.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(40)
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