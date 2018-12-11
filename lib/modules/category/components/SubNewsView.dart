import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class SubNewsView extends StatefulWidget {
  final dynamic category;
  const SubNewsView({
    Key key,
    this.category
  }) : super(key: key);

  @override
  _SubNewsViewState createState() => new _SubNewsViewState();
}

class _SubNewsViewState extends State<SubNewsView> {
  bool loading = true;
  GlobalKey pageKey = new GlobalKey();
  List<Object> list = [];
  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews () async {
    try {
      List<dynamic> data = await getNewsFromUrl(widget.category['url']);
      setState(() {
        list = data;
      });
    } catch (err) {
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Container(
        // height: MediaQuery.of(context).size.height - 476,
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new NewsList(list, null, widget)
      )
    );
  }
}