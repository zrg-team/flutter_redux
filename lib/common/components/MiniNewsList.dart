import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/MiniNewsfeed.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class MiniNewsList extends StatefulWidget {
  MiniNewsList({
    Key key,
    bool metaData,
    List<Object> list,
    dynamic controller,
    dynamic widget,
    dynamic features,
    Function onTap
  }) :
  metaData = metaData,
  list = list,
  onTap = onTap,
  parentWidget = widget,
  controller = controller,
  super(key: key);

  final List<Object> list;
  final ScrollController controller;
  final Function onTap;
  final parentWidget;
  final bool metaData;

  @override
  _MiniNewsListState createState() => new _MiniNewsListState();
}
class _MiniNewsListState extends State<MiniNewsList> {
  Widget _buildItem(
    BuildContext context, int index) {
    if (widget.list[index] == null) {
      return new Container();
    }
    return MiniNewsfeed(
      item: widget.list[index],
      metaData: widget.metaData,
      onTap: (seleted) {
        if (widget.onTap != null) {
          widget.onTap(seleted);
        } else {
          pushByName('/reading', context, { 'news': seleted });
        }
      }
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