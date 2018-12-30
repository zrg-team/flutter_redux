import 'package:redux/redux.dart';
import 'package:cat_dog/common/actions/common.dart';
import 'package:cat_dog/common/states/common.dart';

Reducer<CommonState> commonReducer = combineReducers([
  new TypedReducer<CommonState, SetFirstOpen>(setFirstOpenReducer),
  new TypedReducer<CommonState, SetUserLanguage>(setUserLanguageReducer),
  new TypedReducer<CommonState, SetAboutInformation>(setAboutInformationReducer),
  new TypedReducer<CommonState, AddReadingCount>(addReadingCountReducer),
  new TypedReducer<CommonState, ClearReadingCount>(clearReadingCountReducer),
]);

CommonState setUserLanguageReducer(CommonState common, SetUserLanguage action) {
  return common.copyWith(
    language: action.language
  );
}

CommonState setAboutInformationReducer(CommonState common, SetAboutInformation action) {
  return common.copyWith(
    about: action.data
  );
}

CommonState setFirstOpenReducer(CommonState common, SetFirstOpen action) {
  return common.copyWith(
    first: action.first
  );
}

CommonState addReadingCountReducer(CommonState common, AddReadingCount action) {
  return common.copyWith(
    readingCount: (common.readingCount ?? 0) + 1
  );
}

CommonState clearReadingCountReducer(CommonState common, ClearReadingCount action) {
  return common.copyWith(
    readingCount: 0
  );
}