import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/SpinLoading.dart';
import 'package:cat_dog/styles/colors.dart';

class OverlayLoadingPage extends StatefulWidget {
  final Widget component;
  final bool loading;
  const OverlayLoadingPage({
    Key key,
    this.component,
    this.loading
  }) : super(key: key);

  @override
  _OverlayLoadingPageState createState() => new _OverlayLoadingPageState();
}

class _OverlayLoadingPageState extends State<OverlayLoadingPage> {
  _OverlayLoadingPageState({Key key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.component,
        widget.loading
          ? Positioned(
            left: 0.0,
            right: 0.0,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                // border: new Border.all(color: AppColors.readingNewsBackgroundColor),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.readingNewsBackgroundColor.withOpacity(0),
                    AppColors.readingNewsBackgroundColor.withOpacity(1)
                  ],
                  stops: [0.0, 100.0],
                  tileMode: TileMode.clamp
                )
              ),
              child: Center(
                child: SpinLoading(overlay: true, iconColor: AppColors.commonBackgroundColor)
              )
            )
          )
          : new Container()
      ],
    );
  }
}