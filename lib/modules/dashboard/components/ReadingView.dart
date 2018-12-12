import 'package:flutter/material.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController videoController;
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
          if (video != null && video.length > 0) {
            videoController = VideoPlayerController.network(
              result['video'][0],
            )
            ..addListener(() {
              final bool playingStatus = videoController.value.isPlaying;
              if (isPlaying != playingStatus) {
                setState(() {
                  isPlaying = playingStatus;
                });
              }
            })
            ..initialize().then((_) {
              setState(() {
              });
            });
          }
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
          margin: EdgeInsets.all(5),
          child: FlatButton(
            onPressed: () {
              videoController.value.isPlaying
              ? videoController.pause()
              : videoController.play();
            },
            child: new Center(
              child: videoController.value.initialized
                ? AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: VideoPlayer(videoController),
                  )
                : Container(),
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