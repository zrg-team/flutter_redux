import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/soccer/components/SoccerCalendarView.dart';
import 'package:cat_dog/modules/soccer/actions.dart';

class SoccerCalendar extends StatelessWidget {
  final BuildContext scaffoldContext;
  SoccerCalendar({Key key, BuildContext scaffoldContext}) :
  scaffoldContext = scaffoldContext,
  super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (Store<AppState> store) {
        return {
          'getTodaySoccerCalendar': () => getTodaySoccerCalendarAction(store),
          'getSoccerCalendarAction': (url) => getSoccerCalendarAction(url)
        };
      },
      builder: (BuildContext context, props) {
        return new SoccerCalendarView(
          key: key,
          scaffoldContext: scaffoldContext,
          getSoccerCalendar: props['getSoccerCalendarAction'],
          getTodaySoccerCalendar: props['getTodaySoccerCalendar']
        );
      }
    );
  }
}