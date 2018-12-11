import 'package:redux/redux.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/modules/user/state.dart';

Reducer<UserState> authReducer = combineReducers([
  new TypedReducer<UserState, UserLoginRequest>(userLoginRequestReducer),
  new TypedReducer<UserState, UserLoginSuccess>(userLoginSuccessReducer),
  new TypedReducer<UserState, UserLoginFailure>(userLoginFailureReducer),
  new TypedReducer<UserState, UserLogout>(userLogoutReducer),
  new TypedReducer<UserState, UserSavedNews>(userSavedNewsReducer),
]);

UserState userLoginRequestReducer(UserState user, UserLoginRequest action) {
  return new UserState().copyWith(
    isAuthenticated: false,
    isAuthenticating: true,
  );
}

UserState userLoginSuccessReducer(UserState user, UserLoginSuccess action) {
  return new UserState().copyWith(
    isAuthenticated: true,
    isAuthenticating: false,
    user: action.user
  );
}

UserState userLoginFailureReducer(UserState user, UserLoginFailure action) {
  return new UserState().copyWith(
    isAuthenticated: false,
    isAuthenticating: false,
    error: action.error
  );
}

UserState userSavedNewsReducer(UserState user, UserSavedNews action) {
  var news = user.saved;
  news.insert(0, action.news);
  return user.copyWith(
    saved: news
  );
}

UserState userLogoutReducer(UserState user, UserLogout action) {
  return new UserState();
}