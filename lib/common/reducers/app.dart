import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/reducer.dart';

AppState appReducer(AppState state, action){
  return new AppState(
    auth: authReducer(state.auth, action),
  );
} 