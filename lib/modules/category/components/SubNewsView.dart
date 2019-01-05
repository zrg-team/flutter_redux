import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/ContentLoadingPage.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class SubNewsView extends StatefulWidget {
  final dynamic view;
  final Function saveNews;
  final BuildContext scaffoldContext;
  const SubNewsView({
    Key key,
    this.view,
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
  // ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 180), () {
      getNews(true);
    });
    // controller.addListener(() {
    //   if (controller.offset >= controller.position.maxScrollExtent - 100 && !onLoadMore) {
    //     setState(() {
    //       page += 1;
    //       onLoadMore = true;
    //     });
    //     getNews(false);
    //   }
    // });
  }

  getNews (bool replace) async {
    try {
      List<dynamic> data = await getNewsFromUrl(widget.view['url'], page);
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
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        loading = false;
        onLoadMore = false;
      });
    });
  }

  @override
  void dispose() {
    // controller.removeListener(() {});
    // controller.dispose();
    super.dispose();
  }

  void handleRefresh (dynamic refreshController, bool isUp) {
    try {
      if (isUp) {
        Future.delayed(Duration(microseconds: 320), () {
          getNews(true);
        });
      } else {
        setState(() {
          page += 1;
          onLoadMore = true;
        });
        getNews(false);
      }
    } catch (err) {
    }
    refreshController.sendBack(isUp, 3); // Status completed
  }

  @override
  Widget build(BuildContext context) {
    return ContentLoadingPage(
      key: pageKey,
      loading: loading,
      component: Container(
        decoration: BoxDecoration(color: AppColors.commonBackgroundColor),
        child: NewsList(
          list: list,
          widget: widget,
          // controller: controller,
          handleRefresh: handleRefresh,
          features: { 'download': true, 'share': true }
        )
      )
    );
  }
}