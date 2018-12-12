import 'package:flutter/material.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/common/components/Newsfeed.dart';
import 'package:share/share.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/styles/colors.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.list, this.controller, this.widget, this.features, this.callbackStart, this.callbackEnd);
  final List<Object> list;
  final ScrollController controller;
  final Function callbackStart;
  final Function callbackEnd;
  final widget;
  final dynamic features;

  void handler (type, item) async {
    if (callbackStart != null) {
      callbackStart(type, item);
    }
    switch (type) {
      case 'download':
        if (widget.saveNews != null) {
          await widget.saveNews(item);
          Scaffold.of(widget.scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: AppColors.itemDefaultColor,
            content: new Text('Đã Lưu !')
          ));
        }
        break;
      case 'share':
        String url = DEFAULT_URL + item['url'];
        Share.share(url.replaceAll('/c/', '/r/'));
        break;
      case 'remove':
        if (widget.removeSavedNews != null) {
          await widget.removeSavedNews(item);
          Scaffold.of(widget.scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: AppColors.itemDefaultColor,
            content: new Text('Đã Xóa Tin !')
          ));
        }
        break;
    }
    if (callbackEnd != null) {
      callbackEnd(type, item);
    }
  }

  Widget _buildItem(
    BuildContext context, int index, Animation<double> animation) {
    if (list[index] == null) {
      return new Container();
    }
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
      onDownload: features != null && features['download'] != null ? (item) {
        handler('download', item);
      } : null,
      onShare: features != null && features['share'] != null ? (item) {
        handler('share', item);
      } : null,
      onRemove: features != null && features['remove'] != null ? (item) {
        handler('remove', item);
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