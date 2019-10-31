@JS()
library over_react_redux.devtools.middleware;

import 'dart:convert';
import 'dart:js_util';

import 'package:react/react_client/js_backed_map.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:js/js.dart';

@JS()
@anonymous
class ReduxDevToolsExtensionConnection {
  external factory ReduxDevToolsExtensionConnection();
  external subscribe(Function listener);
  external send([action, state]);
  external init([initalState]);
}

@JS('__REDUX_DEVTOOLS_EXTENSION__.connect')
external ReduxDevToolsExtensionConnection reduxExtConnect([dynamic options]);

class OverReactReduxDevToolsMiddleware extends MiddlewareClass {
  bool devToolsExtensionFound = false;
  Store _store;
  ReduxDevToolsExtensionConnection devToolsExt;
  OverReactReduxDevToolsMiddleware() {
    try {
      devToolsExt = reduxExtConnect();
      devToolsExtensionFound = true;
    } catch(e) {
      print('Unable to connect to the redux dev tools browser extension. \nPlease install it... \nChrome: https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en \nFirefox: https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/');
    }

  }

  set store(Store v) {
    _store = v;
    devToolsExt.init(_encodeForTransit(store.state));
    devToolsExt.subscribe(handleEventFromRemote);
  }

  get store => _store;

  dynamic _encodeForTransit(dynamic content) {
    try {
    return jsify(jsonDecode(jsonEncode(content)));
    } catch (e) {
      print('You must implement a `toJson` method in your state and actions in order to view state changes in the redux dev tools.');
    }
  }

  dynamic _encodeActionForTransit(dynamic action) {
    try {
      return _encodeForTransit({'type': _getActionType(action), 'payload': action});
    } on Error {
      return _encodeForTransit({'type': _getActionType(action)});
    }
  }

  String _getActionType(dynamic action) {
    if (action.toString().contains('Instance of')) {
      return action.runtimeType.toString();
    }
    return action.toString();
  }

  _relay(String type, [Object state, dynamic action, String nextActionId]) {
    var message = JsBackedMap();
    message['type'] = type;

    if (state != null) {
      try {
        message['payload'] = _encodeForTransit(state);
      } catch (error) {
        message['payload'] = 'Could not encode state. Ensure state is json encodable';
      }
    }
    if (type == 'ACTION') {
      message['action'] = _encodeActionForTransit(action);
      message['nextActionId'] = nextActionId;
    } else if (action != null) {
      message['action'] = action as String;
    }

    if (message.containsKey('action')) {
      devToolsExt.send(message['action'], message['payload']);
    } else {
      devToolsExt.send(message.jsObject);
    }
  }

  void handleEventFromRemote(JsMap jsData) {
    JsBackedMap data = JsBackedMap.fromJs(jsData);
    switch (data['type'] as String) {
      case 'DISPATCH':
        _handleDispatch(JsBackedMap.fromJs(data['payload']));
        break;
      case 'ACTION':
        _handleRemoteAction(data['action'] as String);
        break;
      default:
        print('Unknown type:' + data['type'].toString());
    }
  }

  void _handleDispatch(dynamic action) {
    if (this._store == null) {
      print('No store reference set, cannot dispatch remote action');
      return;
    }
    switch (action['type'] as String) {
      case 'JUMP_TO_ACTION':
      case 'JUMP_TO_STATE':
        this._store.dispatch(new DevToolsAction.jumpToState(action['actionId'] as int));
        break;
      default:
        print("Unknown command: ${action['type']}. Ignoring");
    }
  }

  void _handleRemoteAction(String action) {
    if (this._store == null) {
      print('No store reference set, cannot dispatch remote action');
      return;
    }
    this._store.dispatch(new DevToolsAction.perform(jsonDecode(action)));
  }

  /// Middleware function called by redux, dispatches actions to devtools
  @override
  call(Store store, dynamic action, NextDispatcher next) {
    next(action);
    if (!devToolsExtensionFound) return;
    this.store ??= store;
    if (!(action is DevToolsAction)) {
      this._relay('ACTION', store.state, action);
    }
  }
}

final overReactReduxDevToolsMiddleware = OverReactReduxDevToolsMiddleware();
