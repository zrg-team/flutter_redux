import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/dashboard/containers/Reading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class ReadingPage extends StatelessWidget {
  final news;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  ReadingPage({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Đọc Tin',
          Icon(
            Icons.arrow_back,
            size: 32
          ),
          () {
            return navigationPop(context);
          },
          Icon(
            Icons.open_in_browser,
            size: 32
          ),
          () async {
            String url = news['url'];
            url = DEFAULT_URL + url.replaceAll('/c/', '/r/');
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              print('Could not launch $url');
            }
          }
        ),
      ),
      body: Builder(
        builder: (context) => new Reading(key: key, news: news, scaffoldContext: context)
      )
    );
  }
}