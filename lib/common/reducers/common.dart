import 'package:redux/redux.dart';

import 'package:cat_dog/common/actions/common.dart';
import 'package:cat_dog/common/states/common.dart';

Reducer<CommonState> commonReducer = combineReducers([
  new TypedReducer<CommonState, SetUserLanguage>(setUserLanguageReducer)
]);

CommonState setUserLanguageReducer(CommonState auth, SetUserLanguage action) {
  return new CommonState().copyWith(
    language: action.language
  );
}