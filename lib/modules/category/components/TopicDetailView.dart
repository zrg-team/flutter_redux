import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/styles/colors.dart';

class TopicDetailView extends StatefulWidget {
  final dynamic topic;
  final BuildContext scaffoldContext;
  const TopicDetailView({
    Key key,
    this.topic,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _TopicDetailViewState createState() => new _TopicDetailViewState();
}

class _TopicDetailViewState extends State<TopicDetailView> {
  List<Object> list = [];
  _TopicDetailViewState();

  @override
  void initState() {
    super.initState();
    getNews(true);
  }

  getNews (bool replace) async {
    await Future.delayed(Duration(milliseconds: 400), () async {
      try {
        List<dynamic> data = await getNewsFromUrl(GET_NEWS_API + widget.topic['url'], 1);
        setState(() {
          if (replace) {
            list = data;
          } else {
            list.addAll(data);
          }
        });
      } catch (err) {
        print(err);
      }
    });
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildAvatar(),
        _buildInfo(),
        _buildVideoScroller(),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 20.0, left: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: ClipOval(
        child: Hero(
          tag: "mini-news-feed-${widget.topic['url']}",
          child: Image.network(widget.topic['image'], fit: BoxFit.cover)
        )
      ),
    );
  }

  Widget _buildInfo() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.topic['heading'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.85),
                margin: const EdgeInsets.symmetric(vertical: 14.0),
                width: 225.0,
                height: 1.0,
              ),
              Text(
                widget.topic['summary'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  height: 1.4,
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  Widget _buildVideoScroller() {
    return Container(
      height: 295,
      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: SizedBox.fromSize(
        size: Size.fromHeight(275.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          itemCount: list.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            var news = list[index];
            return TopicItemView(news, (seleted) {
              pushByName('/reading', context, { 'news': seleted });
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: _buildContent(),
        ),
      )
    );
  }
}

class TopicItemView extends StatelessWidget {
  TopicItemView(this.news, this.onTap);
  final dynamic news;
  final Function onTap;

  BoxDecoration _buildShadowAndRoundedCorners() {
    return BoxDecoration(
      color: AppColors.itemDefaultColor.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 10.0,
          // color: Colors.black26,
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.network(news['image'])
          // Positioned(
          //   bottom: 12.0,
          //   right: 12.0,
          //   child: _buildPlayButton(),
          // ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Text(
        news['heading'],
        style: TextStyle(color: Colors.white.withOpacity(0.85)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        onTap(news);
      },
      child: Container(
        width: 175.0,
        height: 245,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        decoration: _buildShadowAndRoundedCorners(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 3, child: _buildThumbnail()),
            Flexible(flex: 2, child: _buildInfo()),
          ]
        )
      )
    );
  }
}