import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/components/MiniNewsList.dart';

class TopicView extends StatefulWidget {
  final BuildContext scaffoldContext;
  const TopicView({
    Key key,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _TopicViewState createState() => new _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  bool loading = true;
  bool onLoadMore = false;
  int page = 1;
  GlobalKey pageKey = new GlobalKey();
  List<dynamic> list = [];
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
      var data = await getTopics(page);
      setState(() {
        if (replace) {
          list = data['data'];
        } else {
          list.addAll(data['data']);
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
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new MiniNewsList(
          list: list,
          widget: widget,
          controller: controller,
          handleRefresh: handleRefresh,
          onTap: (seleted) {
            pushByName('/topic-detail', context, { 'topic': seleted });
          },
        )
      )
    );
  }
}