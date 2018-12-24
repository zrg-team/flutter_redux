import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/user/reducer.dart';
import 'package:cat_dog/common/reducers/common.dart';
import 'package:cat_dog/modules/dashboard/reducer.dart';

AppState appReducer(AppState state, action){
  return new AppState(
    user: authReducer(state.user, action),
    common: commonReducer(state.common, action),
    dashboard: dashboardReducer(state.dashboard, action)
  );
} 