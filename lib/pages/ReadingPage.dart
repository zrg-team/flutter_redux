import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/modules/dashboard/containers/Reading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cat_dog/common/utils/navigation.dart';

import 'package:cat_dog/modules/user/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/styles/colors.dart';

class ReadingPage extends StatelessWidget {
  final news;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  ReadingPage({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: SHOULD NOT CONNECT REDUX HERE
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {
            return (item) async => 
              await saveNewsAction(store, item);
          },
          builder: (BuildContext context, savedNews) {
            return new GradientAppBar(
              '',
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
              },
              onPressRightButtonDownload: () {
                savedNews(news);
                Scaffold.of(context).showSnackBar(new SnackBar(
                  backgroundColor: AppColors.specicalBackgroundColor,
                  content: new Text('Đã Lưu !')
                ));
              },
              onPressRightButtonShare: () {
                String url = DEFAULT_URL + news['url'];
                Share.share(url.replaceAll('/c/', '/r/'));
              }
            );
          }
        )
      ),
      body: Builder(
        builder: (context) => new Reading(key: key, news: news, scaffoldContext: context)
      )
    );
  }
}