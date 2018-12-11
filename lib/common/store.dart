import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:cat_dog/common/reducers/app.dart';
import 'package:cat_dog/common/state.dart';
import 'package:redux_logging/redux_logging.dart';

Future<Store<AppState>> createStore() async { 
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.rehydrationJSON)
  );
  // Load initial state
  final initialState = await persistor.load();
  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState(),
    middleware: [
      thunkMiddleware,
      persistor.createMiddleware(),
      new LoggingMiddleware.printer()
    ],
  );

  return store;
}