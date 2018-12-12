import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/common/actions/common.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    Key key
  }) : super(key: key);

  @override
  _AboutPageState createState() => new _AboutPageState();
}
class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    this.getAbout();
  }
  getAbout () async {
    try {
      await getAboutAction();
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
              data: html
            );
          }
        )
      )
    );
  }
}