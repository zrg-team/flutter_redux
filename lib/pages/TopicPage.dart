import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/dashboard/components/TopicView.dart';

class TopicPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  TopicPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Hero(
          tag: "app-bar-hero",
          child: new GradientAppBar(
            'Chủ Đề',
            Icon(
              Icons.dehaze,
              size: 32
            ),
            () => _mainKey.currentState.openDrawer(),
            null,
            () async {
            }
          )
        )
      ),
      body: Builder(
        builder: (context) => TopicView(
          key: key,
          scaffoldContext: context
        )
      ),
      drawer: new MainDrawer(),
    );
  }
}