import 'package:redux/redux.dart';

import 'package:cat_dog/common/actions/common.dart';
import 'package:cat_dog/common/states/common.dart';

Reducer<CommonState> commonReducer = combineReducers([
  new TypedReducer<CommonState, SetUserLanguage>(setUserLanguageReducer)
]);

CommonState setUserLanguageReducer(CommonState common, SetUserLanguage action) {
  return common.copyWith(
    language: action.language
  );
}