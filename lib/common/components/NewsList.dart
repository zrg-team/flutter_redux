import 'package:flutter/material.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/common/components/Newsfeed.dart';
import 'package:share/share.dart';
import 'package:cat_dog/common/configs.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.list, this.controller, this.widget);
  final List<Object> list;
  final ScrollController controller;
  final widget;

  Widget _buildItem(
    BuildContext context, int index, Animation<double> animation) {
    return Newsfeed(
      animation: animation,
      item: list[index],
      onTap: (seleted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReadingPage(news: seleted),
          ),
        );
      },
      onDownload: (item) {
        if (widget.saveNews != null) {
          widget.saveNews(item);
        }
      },
      onShare: (item) {
        String url = DEFAULT_URL + item['url'];
        Share.share(url.replaceAll('/c/', '/r/'));
      },
      onStart: () {},
    );
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      controller: controller,
      initialItemCount: list.length,
      itemBuilder: _buildItem,
    );
  }
}