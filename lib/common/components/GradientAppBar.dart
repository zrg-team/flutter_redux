import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';

class GradientAppBar extends StatelessWidget {

  final String title;
  final dynamic iconLeftButton;
  final Function onPressLeftButton;
  final dynamic iconRighButton;
  final Function onPressRightButton;
  final double barHeight = 60.0;

  GradientAppBar(this.title, this.iconLeftButton, this.onPressLeftButton, this.iconRighButton, this.onPressRightButton);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconLeftButton != null ? Container(
            child: IconButton(
              color: AppColors.white,
              icon: iconLeftButton,
              iconSize: 32,
              onPressed: onPressLeftButton
            )
          ) : Container(width: 32, height: 32),
          Container(
            child: new Center(
              child: new Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0
                )
              )
            )
          ),
          iconRighButton != null ? Container(
            child: IconButton(
              color: AppColors.white,
              icon: iconRighButton,
              iconSize: 32,
              onPressed: onPressRightButton
            )
          ) : Container(width: 32, height: 32)
        ]
      )
    );
  }
}