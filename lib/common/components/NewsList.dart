import 'package:flutter/material.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/common/components/Newsfeed.dart';
import 'package:share/share.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/styles/colors.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.list, this.controller, this.widget, this.features);
  final List<Object> list;
  final ScrollController controller;
  final widget;
  final dynamic features;

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
      onDownload: features != null && features['download'] ? (item) async {
        if (widget.saveNews != null) {
          widget.saveNews(item);
          Scaffold.of(widget.scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: AppColors.itemDefaultColor,
            content: new Text('Đã Lưu !')
          ));
        }
      } : null,
      onShare: features != null && features['share'] ? (item) {
        String url = DEFAULT_URL + item['url'];
        Share.share(url.replaceAll('/c/', '/r/'));
      } : null
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