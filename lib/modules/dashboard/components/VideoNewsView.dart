import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/components/MiniNewsList.dart';

class VideoNewsView extends StatefulWidget {
  final BuildContext scaffoldContext;
  const VideoNewsView({
    Key key,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _VideoNewsViewState createState() => new _VideoNewsViewState();
}

class _VideoNewsViewState extends State<VideoNewsView> {
  bool loading = true;
  bool onLoadMore = false;
  int page = 1;
  GlobalKey pageKey = new GlobalKey();
  List<Object> list = [];
  ScrollController controller = new ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 650), () {
      getNews(true);
    });
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
      List<dynamic> data = await getNewsFromUrl('https://m.baomoi.com/tin-video.epi', page);
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

  Future<void> handleRefresh () {
    return getNews(true);
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Container(
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new MiniNewsList(
          list: list,
          widget: widget,
          controller: controller,
          metaData: true,
          handleRefresh: handleRefresh
        )
      )
    );
  }
}