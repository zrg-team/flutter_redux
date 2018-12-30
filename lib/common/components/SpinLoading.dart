import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cat_dog/styles/colors.dart';

class SpinLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        color: AppColors.commonBackgroundColor
      ),
      child: new Center(
        child: SpinKitDoubleBounce(
          color: AppColors.white,
          size: 100
        )
      )
    ));
  }
}