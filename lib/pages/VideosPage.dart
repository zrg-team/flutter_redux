import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/dashboard/components/VideoNewsView.dart';

class VideosPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Videos',
          Icon(
            Icons.arrow_back,
            size: 32
          ),
          () => navigationPop(context),
          null,
          () async {
          }
        ),
      ),
      body: Builder(
        builder: (context) => VideoNewsView(
          key: key,
          scaffoldContext: context
        )
      )
    );
  }
}