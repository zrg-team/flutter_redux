import 'package:flutter/material.dart';
import 'package:cat_dog/common/components/MiniNewsfeed.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:cat_dog/common/components/Newsfeed.dart';

class MiniNewsList extends StatefulWidget {
  MiniNewsList({
    Key key,
    dynamic metaData,
    dynamic folding,
    List<dynamic> list,
    dynamic controller,
    dynamic widget,
    dynamic features,
    Function onTap,
    Function handleRefresh,
  }) :
  metaData = metaData != null ? metaData : false,
  folding = folding != null ? folding : false,
  list = list,
  onTap = onTap,
  parentWidget = widget,
  controller = controller,
  handleRefresh = handleRefresh,
  super(key: key);

  final List<dynamic> list;
  final ScrollController controller;
  final Function onTap;
  final Function handleRefresh;
  final parentWidget;
  final bool metaData;
  final bool folding;

  @override
  _MiniNewsListState createState() => new _MiniNewsListState();
}
class _MiniNewsListState extends State<MiniNewsList> {
  Widget _buildItem(
    BuildContext context, int index) {
    if (widget.list[index] == null) {
      return new Container();
    }
    if (widget.folding == true && widget.list[index]['news'] != null && widget.list[index]['news'].length >= 2) {
      return SimpleFoldingCell(
        frontWidget: MiniNewsfeed(
          item: widget.list[index],
          metaData: widget.metaData,
          imageWidth: 120.0,
          imageHeight: 120.0
        ),
        innerTopWidget: Newsfeed(
          item: widget.list[index]['news'][0],
          onTap: (seleted) {
            pushByName('/reading', context, { 'news': seleted });
          },
          onDownload: null,
          onShare: null,
          onRemove: null
        ),
        innerBottomWidget: Newsfeed(
          item: widget.list[index]['news'][1],
          onTap: (seleted) {
            pushByName('/reading', context, { 'news': seleted });
          },
          onDownload: null,
          onShare: null,
          onRemove: null
        ),
        cellSize: Size(MediaQuery.of(context).size.width, 165),
        padding: EdgeInsets.all(0.0),
      );
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
    print(widget.list.length);
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.list.length,
      itemBuilder: _buildItem,
    );
  }
}