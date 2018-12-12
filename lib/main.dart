import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/store.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/presentation/platform_adaptive.dart';
// PAGES
import 'package:cat_dog/pages/LoginPage.dart';
import 'package:cat_dog/pages/HomePage.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/pages/CategoriesPage.dart';
import 'package:cat_dog/pages/TestAnimationPage.dart';
import 'package:cat_dog/pages/SavedNewsPage.dart';
import 'package:cat_dog/pages/NewsSourcePage.dart';
import 'package:cat_dog/pages/AboutPage.dart';

void main() async {
  final store = await createStore();
  runApp(new App(
    store: store
  ));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Tin Mới',
        theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
        routes: <String, WidgetBuilder> {
          // Login feature comming soon
          // '/': (BuildContext context) => new StoreConnector<AppState, dynamic>( 
          //     converter: (store) => store.state.user.isAuthenticated, 
          //     builder: (BuildContext context, isAuthenticated) => isAuthenticated ? new HomePage() : new LoginPage()
          // ),
          '/': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
          '/home': (BuildContext context) => new HomePage(),
          '/view': (BuildContext context) => new ReadingPage(),
          '/categories': (BuildContext context) => new CategoriesPage(),
          '/test': (BuildContext context) => new LogoApp(),
          '/saved': (BuildContext context) => new SavedNewsPage(),
          '/source': (BuildContext context) => new NewsSourcePage(),
          '/about': (BuildContext context) => new AboutPage()
        }
      )
    );
  }
}