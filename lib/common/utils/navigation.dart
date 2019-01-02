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


const int DEFAULT_TIME = 200;
class NoTransmissionRoute<T> extends MaterialPageRoute<T> {
  NoTransmissionRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation, 
    // just return child.)
    return child;
  }
}
final Function getNavigationData = (
  Function navigationFunction,
  String url,
  BuildContext context,
  dynamic params
) {
  switch (url) {
    case '':
      case '/home':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            alignment: Alignment.centerLeft,
            child: HomePage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/categories':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: CategoriesPage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/saved':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: SavedNewsPage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/source':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: NewsSourcePage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/videos':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: VideosPage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/about':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: AboutPage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/reading':
        navigationFunction(
          context,
          NoTransmissionRoute(
            builder: (BuildContext context) => ReadingPage(news: params['news'])
          )
        );
        break;
      case '/subview':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: SubNewsPage(view: params['view']),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/topics':
        navigationFunction(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: TopicPage(),
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          )
        );
        break;
      case '/topic-detail':
        navigationFunction(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TopicDetailPage(topic: params['topic'])
          )
        );
        break;
      default:
        return null;
  }
};

final Function pushByName = (String url, BuildContext context, dynamic params) {
  getNavigationData(Navigator.push, url, context, params);
};

final Function pushAndReplaceByName = (String url, BuildContext context, dynamic params) {
  getNavigationData(Navigator.pushReplacement, url, context, params);
};

final Function pushAndRemoveByName = (String url, BuildContext context, dynamic params) {
  switch (url) {
    case '':
      case '/home':
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            alignment: Alignment.bottomCenter,
            child: HomePage(),
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: DEFAULT_TIME)
          ),
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