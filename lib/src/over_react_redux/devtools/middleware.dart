@JS()
library over_react_redux.devtools.middleware;

import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:logging/logging.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:js/js.dart';

@JS()
@anonymous
class _ReduxDevToolsExtensionConnection {
  external void subscribe(dynamic Function(JsMap data) listener);
  external void send([dynamic action, dynamic state]);
  external void init([dynamic initialState]);
}

@JS('__REDUX_DEVTOOLS_EXTENSION__.connect')
external _ReduxDevToolsExtensionConnection reduxExtConnect([dynamic options]);

class _OverReactReduxDevToolsMiddleware extends MiddlewareClass {
  Store _store;
  _ReduxDevToolsExtensionConnection devToolsExt;
  final Logger log = Logger('OverReactReduxDevToolsMiddleware');

  _OverReactReduxDevToolsMiddleware() {
    log.onRecord.listen((rec) {
      if (rec.level == Level.WARNING) {
        window.console.warn('${log.name} [${rec.level.name}]: ${rec.message}');
      } else {
        window.console.log('${log.name} [${rec.level.name}]: ${rec.message}');
      }
    });
    try {
      devToolsExt = reduxExtConnect();
    } catch(_) {
      log.warning(
        'Unable to connect to the redux dev tools browser extension.\n'
        'Please install it...\n'
        'Chrome: https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en\n'
        'Firefox: https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/\n'
      );
    }
  }

  set store(Store v) {
    _store = v;
    devToolsExt.init(_encodeForTransit(store.state));
    devToolsExt.subscribe(handleEventFromRemote);
  }

  Store get store => _store;

  dynamic _encodeForTransit(dynamic content, {bool shouldRethrow = false}) {
    try {
      return jsify(jsonDecode(jsonEncode(content)));
    } catch (_) {
      log.warning('You must implement a `toJson` method in your state and actions in order to view state changes in the redux dev tools.');
      if (shouldRethrow) rethrow;
    }
  }

  dynamic _encodeActionForTransit(dynamic action) {
    try {
      return _encodeForTransit({'type': _getActionType(action), 'payload': action}, shouldRethrow: true);
    } catch (_) {
      return _encodeForTransit({'type': _getActionType(action)});
    }
  }

  String _getActionType(dynamic action) {
    var actionString = action.toString();
    if (actionString.startsWith('Instance of')) {
      return action.runtimeType.toString();
    }
    return actionString;
  }

  void _relay(String type, [Object state, dynamic action, String nextActionId]) {
    final message = JsBackedMap();
    message['type'] = type;

    if (state != null) {
      try {
        message['payload'] = _encodeForTransit(state, shouldRethrow: true);
      } catch (_) {
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
        log.warning('Unknown type:' + data['type'].toString());
    }
  }

  void _handleDispatch(dynamic action) {
    if (_store == null) {
      log.warning('No store reference set, cannot dispatch remote action');
      return;
    }
    switch (action['type'] as String) {
      case 'JUMP_TO_ACTION':
      case 'JUMP_TO_STATE':
        _store.dispatch(DevToolsAction.jumpToState(action['actionId'] as int));
        break;
      default:
        log.warning("Unknown command: ${action['type']}. Ignoring");
    }
  }

  void _handleRemoteAction(String action) {
    if (_store == null) {
      log.warning('No store reference set, cannot dispatch remote action');
      return;
    }
    _store.dispatch(DevToolsAction.perform(jsonDecode(action)));
  }

  /// Middleware function called by redux, dispatches actions to devtools
  @override
  call(Store store, dynamic action, NextDispatcher next) {
    next(action);
    if (devToolsExt == null) return;
    store ??= store;
    if (!(action is DevToolsAction)) {
      _relay('ACTION', store.state, action);
    }
  }
}

final MiddlewareClass overReactReduxDevToolsMiddleware = _OverReactReduxDevToolsMiddleware();
