import 'package:flutter/material.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReadingView extends StatefulWidget {
  final dynamic news;
  final BuildContext scaffoldContext;
  const ReadingView({
    Key key,
    this.news,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _ReadingViewState createState() => new _ReadingViewState();
}
class _ReadingViewState extends State<ReadingView> {
  String html = '';
  var video = [];
  bool isPlaying = false;
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
      var result = await getDetailNews(widget.news['url']);
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          html = result['text'];
          video = result['video'];
        });
      });
    } catch (err) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        video.length > 0 ? new Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: FlatButton(
            onPressed: () async {
              String url = widget.news['url'];
              url = DEFAULT_URL + url.replaceAll('/c/', '/r/');
              print(url);
              if (await canLaunch(url)) {
                await launch(url, forceWebView: true);
              } else {
                print('Could not launch $url');
              }
            },
            child: new Center(
              child: new Image(
                image: AssetImage('assets/videoplayer.jpg'),
              ),
            )
          )
        ) : new Container( width: 0, height: 0 ),
        new Expanded(
          child: new Center(
            child: new Container(
              child: new Markdown(
                data: html
              )
            )
          )
        )
      ]
    );
  }

}