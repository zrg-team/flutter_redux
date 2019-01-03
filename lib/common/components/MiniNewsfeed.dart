import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class MiniNewsfeed extends StatelessWidget {
  const MiniNewsfeed(
    {
      Key key,
      this.onTap,
      dynamic folding,
      dynamic metaData,
      dynamic imageWidth,
      dynamic imageHeight,
      @required this.item
    })
      : assert(item != null),
      imageWidth = imageWidth != null ? imageWidth : 100.0,
      imageHeight = imageHeight != null ? imageHeight : 100.0,
      metaData = metaData != null ? metaData : false,
      folding = folding != null ? folding : false,
      super(key: key);
  final Function onTap;
  final dynamic item;
  final bool metaData;
  final bool folding;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 1.7,
      child: new Container(
        decoration: new BoxDecoration(color: AppColors.white),
        child: new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new Column(
            children: [
              new GestureDetector(
                onTap: !folding ? () {
                  onTap != null && onTap(item);
                } : null,
                child: new Row(
                  children: [
                    new Column(
                      children: <Widget>[
                        new Padding(
                          padding:
                            new EdgeInsets.only(top: 8.0),
                          child: new SizedBox(
                            height: imageWidth,
                            width: imageHeight,
                            child: Hero(
                              tag: "mini-news-feed-${item['url']}",
                              child: new Image.network(
                                item['image'],
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                        )
                      ]
                    ),
                    new Expanded(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                          CrossAxisAlignment.start,
                        children: [
                          this.metaData != null ? new Row(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.only(left: 4.0),
                                child: new Text(
                                  timeago.format(DateTime.parse(item['time']), allowFromNow: true),
                                  style: new TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(5.0),
                                child: new Text(
                                  item['source'],
                                  style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ) : new Container(),
                          new Padding(
                            padding: new EdgeInsets.only(
                              left: 4.0,
                              right: 8.0,
                              bottom: 8.0,
                              top: 8.0),
                            child: new Text(
                              item['heading'],
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}