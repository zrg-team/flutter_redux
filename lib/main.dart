import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/store.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/presentation/platform_adaptive.dart';
// PAGES
import 'package:cat_dog/pages/HomePage.dart';
import 'package:cat_dog/pages/BoardingPage.dart';

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
        color: AppColors.commonBackgroundColor,
        debugShowCheckedModeBanner: false,
        theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
        routes: <String, WidgetBuilder> {
          // Login feature comming soon
          '/': (BuildContext context) => new StoreConnector<AppState, dynamic>( 
              converter: (store) {
                return store.state.common.first;
              }, 
              builder: (BuildContext context, first) => !first ? new HomePage() : new BoardingPage()
          )
        }
      )
    );
  }
}