import 'package:html/parser.dart' show parse;
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/soccer/repository.dart';

class SetSoccerGames {
  final List<Object> games;
  final List<Object> days;
  final List<Object> matchs;
  SetSoccerGames(this.games, this.days, this.matchs);
}

parseSoccerNews (result) {
  List<dynamic> data = new List();
  List<dynamic> days = new List();
  List<dynamic> matchs = new List();
  try {
    var document = parse(result);

    var matchDays = document
      .getElementsByClassName('s-weekday')[0]
      .getElementsByTagName('a');

    int j;
    int lengthDay = matchDays.length;

    for (j = 0; j < lengthDay; j++) {
      var day = matchDays[j];
      days.add({
        'heading': day.innerHtml,
        'url': day.attributes['href']
      });
    }

    var elements = document
      .getElementsByClassName('s-list')[0]
      .getElementsByClassName('row');
    int i;
    int length = elements.length;
    int indexData;
    for (i = 0; i < length; i++) {
      try {
        var item = elements[i];
        if (!item.className.contains('match')) {
          var tagA = item.getElementsByTagName('a');
          String league = tagA[0].innerHtml;
          String info = tagA[1].innerHtml;
          String time = item.getElementsByTagName('time')[0].innerHtml;
          var leagueInfo = {
            'league': league,
            'info': info,
            'time': time,
            'matchs': [],
            'match': false
          };
          matchs.add(leagueInfo);
          data.add(leagueInfo);
          if (indexData == null) {
            indexData = 0;
          } else {
            indexData++;
          }
        } else {
          var tagTeam = item.getElementsByClassName('team');

          var home = tagTeam[0];
          String homeName = home.getElementsByTagName('span')[0].innerHtml;
          var homeLogo = home.getElementsByTagName('img');
          var away = tagTeam[1];
          String awayName = away.getElementsByTagName('span')[0].innerHtml;
          var awayLogo = away.getElementsByTagName('img');
          var scoTag = item.getElementsByClassName('sco')[0];
          String homeScore = scoTag.getElementsByTagName('span')[0].innerHtml;
          String awayScore = scoTag.getElementsByTagName('span')[2].innerHtml;
          var match = {
            'match': true,
            'home': homeName,
            'homeLogo': homeLogo.length > 0
              ? homeLogo[0].attributes['src'].replaceAll('//', 'https://') : null,
            'away': awayName,
            'awayLogo': awayLogo.length > 0
              ? awayLogo[0].attributes['src'].replaceAll('//', 'https://') : null,
            'homeScore': homeScore,
            'awayScore': awayScore,
            'time': data[indexData]['time']
          };
          matchs.add(match);
          data[indexData]['matchs'].add(match);
        }
      } catch (err) {
        print(err);
      }
    }
  } catch (err) {
  }
  return {
    'data': data,
    'days': days,
    'matchs': matchs
  };
}

final Function getTodaySoccerCalendarAction = (Store<AppState> store) async {
  String result = await fetchSoccerCalendar();
  if (result != '') {
    var data = parseSoccerNews(result);
    store.dispatch(new SetSoccerGames(data['data'], data['days'], data['matchs']));
    return data['data'];
  }
  return [];
};

final Function getSoccerCalendarAction = (String url) async {
  String result = await fetchSoccerCalendarByDay(url);
  if (result != '') {
    var data = parseSoccerNews(result);
    return data['data'];
  }
  return [];
};