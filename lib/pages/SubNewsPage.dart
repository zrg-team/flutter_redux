import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/category/components/SubNewsView.dart';

class SubNewsPage extends StatelessWidget {
  final category;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  SubNewsPage({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          category['title'],
          Icon(
            Icons.arrow_back,
            size: 32
          ),
          () => Navigator.of(context).pop(),
          null,
          () async {
          }
        ),
      ),
      body: new SubNewsView(key: key, category: category)
    );
  }
}