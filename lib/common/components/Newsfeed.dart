import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class Newsfeed extends StatelessWidget {
  const Newsfeed(
    {
      Key key,
      this.onTap,
      this.onStart,
      this.onShare,
      this.onRemove,
      this.onDownload,
      @required this.item
    })
      : assert(item != null),
        super(key: key);
  final Function onTap;
  final Function onDownload;
  final Function onStart;
  final Function onShare;
  final Function onRemove;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 1.7,
      child: new Container(
        decoration: new BoxDecoration(color: AppColors.white),
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: [
              new Row(
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
              ),
              new Row(
                children: [
                  new Expanded(
                    child: new GestureDetector(
                      child: new Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
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
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(
                                left: 4.0,
                                right: 4.0,
                                bottom: 4.0),
                            child: new Text(
                              item['summary'],
                              style: new TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        onTap != null && onTap(item);
                      },
                    ),
                  ),
                  new Column(
                    children: <Widget>[
                      new Padding(
                        padding:
                            new EdgeInsets.only(top: 8.0),
                        child: new SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: Hero(
                            tag: "news-feed-${item['url']}",
                            child: new Image.network(
                              item['image'],
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          onShare != null ? new GestureDetector(
                            child: new Padding(
                                padding:
                                    new EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 5.0),
                                child: Icon(
                                    Icons.share,
                                    color: Colors.black
                                  )
                                ),
                            onTap: () {
                              onShare(item);
                            },
                          ) : new Container(),
                          onDownload != null ? new GestureDetector(
                            child: new Padding(
                              padding:
                                  new EdgeInsets.all(5.0),
                              child: Icon(Icons.cloud_download, color: Colors.black)
                            ),
                            onTap: () {
                              onDownload(item);
                            }
                          ) : new Container(),
                          onRemove != null ? new GestureDetector(
                            child: new Padding(
                              padding:
                                  new EdgeInsets.all(5.0),
                              child: Icon(Icons.delete, color: Colors.black)
                            ),
                            onTap: () {
                              onRemove(item);
                            }
                          ) : new Container()
                        ]
                      )
                    ]
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }
}