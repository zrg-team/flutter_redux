import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cat_dog/styles/colors.dart';

class SpinLoading extends StatelessWidget {
  final bool overlay;
  final Color iconColor;
  SpinLoading({ Key key, dynamic overlay, dynamic iconColor }) :
    overlay = overlay == null ? false : overlay,
    iconColor = iconColor == null ? AppColors.specicalBackgroundColor : iconColor,
    super(key: key);
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        color: overlay ? Colors.transparent : AppColors.commonBackgroundColor
      ),
      child: new Center(
        child: SpinKitDoubleBounce(
          color: iconColor,
          size: 100
        )
      )
    ));
  }
}