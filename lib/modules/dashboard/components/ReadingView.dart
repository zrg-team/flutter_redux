import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';

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
  bool loading = true;
  CarouselSlider carouselInstance;
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
          loading = false;
        });
      }
      var result = await getDetailNews(widget.news['url']);
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          html = result['text'];
          if (result['video'] != null && result['video'].length > 0) {
            carouselInstance = buildCarousel(result['video'] ?? []);
          }
          loading = false;
        });
      });
    } catch (err) {
    }
  }

  CarouselSlider buildCarousel (List<dynamic> data) {
    return CarouselSlider(
      items: data.map((item) {
        return new Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: FlatButton(
            onPressed: () async {
              String url = item['url'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                print('Could not launch $url');
              }
            },
            child: Stack(
              children: <Widget>[
                new Center(
                  child: new Image(
                    image: NetworkImage(item['image']),
                  )
                ),
                new Center(
                  child: Icon(Icons.play_arrow, size: 56, color: AppColors.white)
                ),
              ]
            )
          )
        );
      }).toList(),
      autoPlay: data.length > 1,
      autoPlayCurve: Curves.fastOutSlowIn
    );
  }

  @override
  Widget build(BuildContext context) {
     return new LoadingPage(
      loading: loading,
      component: Column(
        children: <Widget>[
          carouselInstance != null
            ? carouselInstance : new Container( width: 0, height: 0 ),
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
      )
    );
  }

}