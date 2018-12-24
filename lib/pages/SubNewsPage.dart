import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/category/containers/SubNews.dart';

class SubNewsPage extends StatelessWidget {
  final view;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  SubNewsPage({Key key, this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          view['title'],
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
        builder: (context) => SubNews(
          key: key,
          view: view,
          scaffoldContext: context
        )
      )
    );
  }
}