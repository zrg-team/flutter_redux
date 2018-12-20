import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/user/containers/SavedNews.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class SavedNewsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  SavedNewsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Tin Đã Lưu',
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
        builder: (context) => new SavedNews(key: key, scaffoldContext: context)
      )
    );
  }
}