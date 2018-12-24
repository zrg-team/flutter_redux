import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/common/actions/common.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';

class AboutView extends StatefulWidget {
  final Function getAbout;
  const AboutView({
    Key key,
    Function getAbout,
  }) :
  getAbout = getAbout,
  super(key: key);

  @override
  _AboutViewState createState() => new _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  void initState() {
    super.initState();
    this.getAbout();
  }
  getAbout () async {
    try {
      await widget.getAbout();
    } catch (err) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {
            return store.state.common.about;
          },
          builder: (BuildContext context, html) {
            return new Markdown(
              data: html ?? ''
            );
          }
        )
      )
    );
  }
}

class AboutPage extends StatelessWidget {
  AboutPage({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Trang Chủ',
          Icon(
            Icons.dehaze,
            size: 32
          ),
          () => _mainKey.currentState.openDrawer(),
          null,
          () async {
          }
        ),
      ),
      body: Builder(
        builder: (context) => new StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {
            return () => 
              store.dispatch(getAboutAction());
          },
          builder: (BuildContext context, getAbout) {
            return new AboutView(
              key: key,
              getAbout: getAbout
            );
          }
        )
      ),
      drawer: new MainDrawer(),
    );
  }
}