import 'package:flutter/material.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReadingView extends StatefulWidget {
  final dynamic news;
  const ReadingView({
    Key key,
    this.news
  }) : super(key: key);

  @override
  _ReadingViewState createState() => new _ReadingViewState();
}
class _ReadingViewState extends State<ReadingView> {
  String html = '';
  @override
  void initState() {
    super.initState();
    this.getDetail();
  }
  getDetail () async {
    try {
      if (widget.news['data'] != null) {
        return setState(() {
          html = widget.news['data'];
        });
      }
      var result = await getDefailNews(widget.news['url']);
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          html = result;
        });
      });
    } catch (err) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new Markdown(
          data: html
        )
      )
    );
  }

}