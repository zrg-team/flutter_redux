import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// PAGES
import 'package:cat_dog/pages/HomePage.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/pages/CategoriesPage.dart';
import 'package:cat_dog/pages/SavedNewsPage.dart';
import 'package:cat_dog/pages/NewsSourcePage.dart';
import 'package:cat_dog/pages/AboutPage.dart';
import 'package:cat_dog/pages/SubNewsPage.dart';
import 'package:cat_dog/pages/VideosPage.dart';
import 'package:cat_dog/pages/TopicPage.dart';
import 'package:cat_dog/pages/TopicDetailPage.dart';

final Function pushByName = (String url, BuildContext context, dynamic params) {
  switch (url) {
    case '':
      case '/home':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: HomePage())
        );
        break;
      case '/categories':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.downToUp, alignment: Alignment.bottomCenter, child: CategoriesPage())
        );
        break;
      case '/saved':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.downToUp, alignment: Alignment.bottomCenter, child: SavedNewsPage())
        );
        break;
      case '/source':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.downToUp, alignment: Alignment.bottomCenter, child: NewsSourcePage())
        );
        break;
      case '/videos':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: VideosPage())
        );
        break;
      case '/about':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.downToUp, alignment: Alignment.bottomCenter, child: AboutPage())
        );
        break;
      case '/reading':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: ReadingPage(news: params['news']))
        );
        break;
      case '/subview':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: SubNewsPage(view: params['view']))
        );
        break;
      case '/topics':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: TopicPage())
        );
        break;
      case '/topic-detail':
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.centerLeft, child: TopicDetailPage(topic: params['topic']))
        );
        break;
      default:
        return null;
  }
};

final Function pushAndRemoveByName = (String url, BuildContext context, dynamic params) {
  switch (url) {
    case '':
      case '/home':
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(type: PageTransitionType.leftToRight, alignment: Alignment.bottomCenter, child: HomePage()),
          (_) => false
        );
        break;
      default:
        return null;
  }
};

final Function navigationPop = (BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
    return true;
  }
  return false;
};

final Function navigationCanPop = (BuildContext context) {
  return Navigator.of(context).canPop();
};