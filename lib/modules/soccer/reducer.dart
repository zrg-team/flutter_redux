import 'package:redux/redux.dart';
import 'package:cat_dog/modules/soccer/actions.dart';
import 'package:cat_dog/modules/soccer/state.dart';

Reducer<SoccerState> soccerReducer = combineReducers([
  new TypedReducer<SoccerState, SetSoccerGames>(setSoccerGamesReducer)
]);

SoccerState setSoccerGamesReducer(SoccerState state, SetSoccerGames action) {
  return state.copyWith(
    games: action.games,
    days: action.days,
    matchs: action.matchs
  );
}