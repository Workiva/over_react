// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@JS()
library over_react_redux.devtools.middleware;

import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:logging/logging.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

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
  Store? _store;
  _ReduxDevToolsExtensionConnection? devToolsExt;
  final Logger log = Logger('OverReactReduxDevToolsMiddleware');

  _OverReactReduxDevToolsMiddleware() {
    var windowConsole = getProperty(window, 'console') as Object;
    log.onRecord.listen((rec) {
      // This return is to safeguard against this listener acting like
      // `Logger.root.onRecord` when `hierarchicalLoggingEnabled` is false.
      if (rec.loggerName != log.name) return;
      if (rec.level == Level.WARNING) {
        callMethod(windowConsole, 'warn', ['${log.name} [${rec.level.name}]: ${rec.message}', if (rec.error != null) rec.error]);
      } else {
        callMethod(windowConsole, 'log', ['${log.name} [${rec.level.name}]: ${rec.message}', if (rec.error != null) rec.error]);
      }
    });
    try {
      devToolsExt = reduxExtConnect();
      devToolsExt!.subscribe(allowInterop(handleEventFromRemote));
    } catch (e) {
      log.warning(e);
      log.warning(
        'Unable to connect to the redux dev tools browser extension.\n'
        'Please install it...\n'
        'Chrome: https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en\n'
        'Firefox: https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/'
      );
    }
  }

  JsMap? _encodeForTransit(Object? content, {bool shouldRethrow = false}) {
    try {
      return jsify(jsonDecode(jsonEncode(content)) as Object) as JsMap;
    } catch (e) {
      log.warning(e);
      log.warning(
        'You must implement a `toJson` method in your state and actions in order to view state changes in the redux dev tools.\n'
        'If you are not sure what is causing this issue in DevTools, you can use "pause on caught exceptions" to pinpoint which part of your state/action is not able to be converted to json.'
      );
      if (shouldRethrow) rethrow;
      return null;
    }
  }

  JsMap? _encodeActionForTransit(dynamic action) {
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

  void _relay(String type, [Object? state, dynamic action, String? nextActionId]) {
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
      devToolsExt!.send(message['action'], message['payload']);
    } else {
      devToolsExt!.send(message.jsObject);
    }
  }

  void handleEventFromRemote(JsMap jsData) {
    JsBackedMap data = JsBackedMap.fromJs(jsData);
    switch (data['type'] as String?) {
      case 'DISPATCH':
        _handleDispatch(JsBackedMap.fromJs(data['payload'] as JsMap));
        break;
      case 'ACTION':
        _handleRemoteAction(data['action'] as String?);
        break;
      case 'START':
        // This is an event from `@devtools-extension` letting us know that it has started.
        // We don't need to do anything.
        break;
      default:
        log.warning("Unknown event from ${data['source'] ?? 'remote'}: ${data['type']}. Ignoring", jsData);
    }
  }

  void _handleDispatch(dynamic action) {
    if (_store == null) {
      log.warning('No store reference set, cannot dispatch remote action');
      return;
    }
    switch (action['type'] as String?) {
      case 'JUMP_TO_ACTION':
      case 'JUMP_TO_STATE':
        _store!.dispatch(DevToolsAction.jumpToState(action['actionId'] as int));
        break;
      default:
        log.warning("Unknown command: ${action['type']}. Ignoring");
    }
  }

  void _handleRemoteAction(String? action) {
    if (_store == null) {
      log.warning('No store reference set, cannot dispatch remote action');
      return;
    }
    _store!.dispatch(DevToolsAction.perform(jsonDecode(action!)));
  }

  /// Middleware function called by redux, dispatches actions to devtools
  @override
  call(Store storeArg, dynamic action, NextDispatcher next) {
    next(action);
    if (devToolsExt == null) return;

    if (_store == null) {
      _store = storeArg;
      devToolsExt!.init(_encodeForTransit(_store!.state));
    }

    if (action is! DevToolsAction) {
      _relay('ACTION', _store!.state, action);
    }
  }
}

/// A Middleware that can be added to a [DevToolsStore] in order to utilize the Redux DevTools browser extension.
///
/// Example:
/// ```
/// var store = new DevToolsStore<AppState>(
///   /*YourReducer*/,
///   initialState: /*YourInitialState*/,
///   middleware: [overReactReduxDevToolsMiddleware],
/// );
/// ```
final MiddlewareClass overReactReduxDevToolsMiddleware = _OverReactReduxDevToolsMiddleware();
