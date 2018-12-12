import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class SavedNewsView extends StatefulWidget {
  final Function removeSavedNews;
  final BuildContext scaffoldContext;
  const SavedNewsView({
    Key key,
    this.removeSavedNews,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _SavedNewsViewState createState() => new _SavedNewsViewState();
}

class _SavedNewsViewState extends State<SavedNewsView> {
  bool loading = false;
  GlobalKey pageKey = new GlobalKey();
  final ScrollController scrollController = new ScrollController();
  List<Object> list = [];
  @override
  void initState() {
    super.initState();
  }

  void callbackStart (type, item) {
    if (type == 'remove') {
      setState(() {
        loading = true;
      });
    }
  }

  void callbackEnd (type, item) {
    if (type == 'remove') {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Container(
        // height: MediaQuery.of(context).size.height - 476,
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {
            return store.state.user.saved;
          },
          builder: (BuildContext context, news) {
            return new NewsList(
              news ?? [], scrollController,
              widget,
              { 'share': true, 'remove': true },
              callbackStart,
              callbackEnd
            );
          }
        )
      )
    );
  }
}