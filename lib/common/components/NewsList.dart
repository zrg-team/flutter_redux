import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/Newsfeed.dart';
import 'package:share/share.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class NewsList extends StatefulWidget {
  NewsList({
    Key key,
    List<Object> list,
    dynamic controller,
    dynamic callbackStart,
    dynamic callbackEnd,
    dynamic widget,
    dynamic features
  }) :
  list = list,
  parentWidget = widget,
  features = features,
  controller = controller,
  callbackEnd = callbackEnd,
  callbackStart = callbackStart,
  super(key: key);

  final List<Object> list;
  final ScrollController controller;
  final Function callbackStart;
  final Function callbackEnd;
  final parentWidget;
  final dynamic features;

  @override
  _NewsListState createState() => new _NewsListState();
}
class _NewsListState extends State<NewsList> {
  void handler (type, item) async {
    if (widget.callbackStart != null) {
      widget.callbackStart(type, item);
    }
    switch (type) {
      case 'download':
        if (widget.parentWidget.saveNews != null) {
          await widget.parentWidget.saveNews(item);
          Scaffold.of(widget.parentWidget.scaffoldContext).showSnackBar(new SnackBar(
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
        if (widget.parentWidget.removeSavedNews != null) {
          await widget.parentWidget.removeSavedNews(item);
          Scaffold.of(widget.parentWidget.scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: AppColors.itemDefaultColor,
            content: new Text('Đã Xóa Tin !')
          ));
        }
        break;
    }
    if (widget.callbackEnd != null) {
      widget.callbackEnd(type, item);
    }
  }

  Widget _buildItem(
    BuildContext context, int index) {
    if (widget.list[index] == null) {
      return new Container();
    }
    return Newsfeed(
      item: widget.list[index],
      onTap: (seleted) {
        pushByName('/reading', context, { 'news': seleted });
      },
      onDownload: widget.features != null && widget.features['download'] != null ? (item) {
        handler('download', item);
      } : null,
      onShare: widget.features != null && widget.features['share'] != null ? (item) {
        handler('share', item);
      } : null,
      onRemove: widget.features != null && widget.features['remove'] != null ? (item) {
        handler('remove', item);
      } : null
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.list.length,
      itemBuilder: _buildItem,
    );
  }
}