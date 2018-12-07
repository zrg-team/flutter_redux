import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:cat_dog/presentation/platform_adaptive.dart';
// PAGES
import 'package:cat_dog/pages/LoginPage.dart';
import 'package:cat_dog/pages/MainPage.dart';
import 'package:cat_dog/common/store.dart';
import 'package:cat_dog/common/state.dart';

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
        title: 'App',
        theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => new StoreConnector<AppState, dynamic>( 
              converter: (store) => store.state.auth.isAuthenticated, 
              builder: (BuildContext context, isAuthenticated) => isAuthenticated ? new MainPage() : new LoginPage()
          ),
          '/login': (BuildContext context) => new LoginPage(),
          '/main': (BuildContext context) => new MainPage()
        }
      )
    );
  }
}