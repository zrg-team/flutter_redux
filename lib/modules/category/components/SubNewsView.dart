import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class SubNewsView extends StatefulWidget {
  final dynamic category;
  final Function saveNews;
  final BuildContext scaffoldContext;
  const SubNewsView({
    Key key,
    this.category,
    this.saveNews,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _SubNewsViewState createState() => new _SubNewsViewState();
}

class _SubNewsViewState extends State<SubNewsView> {
  bool loading = true;
  bool onLoadMore = false;
  int page = 1;
  GlobalKey pageKey = new GlobalKey();
  List<Object> list = [];
  ScrollController controller = new ScrollController();
  @override
  void initState() {
    super.initState();
    getNews(true);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent - 100 && !onLoadMore) {
        setState(() {
          page += 1;
          onLoadMore = true;
        });
        getNews(false);
      }
    });
  }

  getNews (bool replace) async {
    try {
      List<dynamic> data = await getNewsFromUrl(widget.category['url'], page);
      setState(() {
        if (replace) {
          list = data;
        } else {
          list.addAll(data);
        }
      });
    } catch (err) {
      print(err);
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
        onLoadMore = false;
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Container(
        height: MediaQuery.of(context).size.height - 100,
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new NewsList(
          list: list,
          widget: widget,
          controller: controller,
          features: { 'download': true, 'share': true }
        )
      )
    );
  }
}