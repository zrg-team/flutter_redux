import 'package:redux/redux.dart';
import 'package:cat_dog/modules/dashboard/actions.dart';
import 'package:cat_dog/modules/user/models/user.dart';
import 'package:cat_dog/common/state.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  final User user;
  UserLoginSuccess(this.user);
}

class UserLoginFailure {
  final String error;
  UserLoginFailure(this.error);
}

class UserLogout {}

class UserSavedNews {
  final Object news;
  UserSavedNews(this.news);
}

// TODO: Remove thunk usage
final Function loginAction = (String username, String password) {
  return (Store<AppState> store) {
    store.dispatch(new UserLoginRequest());
    if (username == 'admin' && password == 'admin') {
      store.dispatch(new UserLoginSuccess(new User('placeholder_token', 'placeholder_id')));
      return true;
    } else {
      store.dispatch(new UserLoginFailure('Username or password were incorrect.'));
      return false;
    }
  };
};
// TODO: Remove thunk usage
final Function logoutAction = () {
  return (Store<AppState> store) {
    store.dispatch(new UserLogout());
  };
};

final Function saveNewsAction = (Store<AppState> store, Map<String, dynamic> item) async {
  var result = await getDetailNews(item['url']);
  dynamic data = item;
  data['data'] = result['text'];
  store.dispatch(UserSavedNews(item));
  return true;
};