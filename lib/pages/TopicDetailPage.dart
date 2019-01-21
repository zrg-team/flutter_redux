import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/category/components/NewDetailTopicView.dart';

class TopicDetailPage extends StatelessWidget {
  final dynamic topic;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  TopicDetailPage({Key key, dynamic topic}) :
    topic = topic,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Nội Dung',
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
        builder: (context) => NewDetailTopicView(
          key: key,
          topic: topic,
          scaffoldContext: context
        )
      )
    );
  }
}