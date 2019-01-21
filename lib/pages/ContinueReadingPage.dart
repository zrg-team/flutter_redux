import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/modules/dashboard/containers/ContinueReading.dart';

class ContinueReadingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  ContinueReadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: new Container(
          padding: new EdgeInsets.only(top: statusBarHeight),
          height: statusBarHeight,
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
            )
          )
        )
      ),
      body: Builder(
        builder: (context) => new ContinueReading(key: key, scaffoldContext: context)
      )
    );
  }
}