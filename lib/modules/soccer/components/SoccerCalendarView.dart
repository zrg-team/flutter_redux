import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog/common/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class SoccerCalendarView extends StatefulWidget {
  final BuildContext scaffoldContext;
  final Function getSoccerCalendar;
  const SoccerCalendarView({
    Key key,
    this.scaffoldContext,
    this.getSoccerCalendar
  }) : super(key: key);

  @override
  _SoccerCalendarViewState createState() => new _SoccerCalendarViewState();
}

class _SoccerCalendarViewState extends State<SoccerCalendarView> {
  bool loading = false;
  GlobalKey pageKey = new GlobalKey();
  final ScrollController scrollController = new ScrollController();
  List<Object> list = [];
  @override
  void initState() {
    super.initState();
    widget.getSoccerCalendar();
  }

  void callbackStart (type, item) {
    if (type == 'remove') {
      setState(() {
        loading = true;
      });
    }
  }

  void callbackEnd (type, item) {
    if (type == 'remove') {
      Future.delayed(new Duration(milliseconds: 1000), () {
        setState(() {
          loading = false;
        });
      });
    }
  }

  Widget buildItem (BuildContext context, dynamic item) {
    if (item == null) {
      return new Container();
    }
    List<dynamic> matchs = item['matchs'];
    List<Widget> column = [
      new Container(
        child: Text("${item['league']} - ${item['info']}")
      ),
    ];
    
    column.addAll(matchs.map<Widget>((data) {
      return new Row(
        children: [
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: new Text(
                    data['home'] ?? '',
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                data['homeLogo'] != null
                  ? Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      data['homeLogo'],
                      width: 32,
                      height: 32
                    )
                  ): Container(),
              ],
            )
          ),
          new Container(
            height: 60,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                CrossAxisAlignment.center,
              children: [
                new Padding(
                  padding: new EdgeInsets.only(
                    left: 4.0,
                    right: 8.0,
                    bottom: 8.0,
                    top: 8.0),
                  child: new Text(
                    "${data['homeScore']} - ${data['awayScore']}",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                CrossAxisAlignment.center,
              children: [
                data['awayLogo'] != null
                  ? Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      data['awayLogo'],
                      width: 32,
                      height: 32
                    ))
                  : Container(),
                Expanded(
                  child: new Text(
                    data['away'] ?? '',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ],
            )
          )
        ]
      );
    }).toList());
    
    return new Card(
      elevation: 1.7,
      child: new Container(
        decoration: new BoxDecoration(color: AppColors.white),
        child: new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new Column(
            children: column
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Container(
        // height: MediaQuery.of(context).size.height - 476,
        decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
        child: new StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {
            return store.state.soccer.games;
          },
          builder: (BuildContext context, news) {
            return new ListView.builder(
              itemCount: news.length,
              itemBuilder: (BuildContext context, int index) {
                return buildItem(context, news[index]);
              }
            );
          }
        )
      )
    );
  }
}