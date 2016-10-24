library async_key_mocking;

import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:w_test_tools/src/key_event_util.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'package:w_test_tools/src/mock_classes.dart';

/// Dispatches a mock capturing keydown event with [keyCode] and returns a Future
/// [MockKeyEvent] that completes when its [StreamSubscription] listeners have been called.
///
/// Workaround until https://github.com/Workiva/w_test_tools/issues/11 is fixed.
Future<MockKeyEvent> waitKeyDown(int keyCode, {CustomizeEvent customizeEvent}) {
  var completer = new Completer();
  StreamSubscription<MockKeyEvent> keyDownListener;
  keyDownListener = DocumentEventHelper.document.body.onKeyDown.capture((event) {
    completer.complete(event);
    keyDownListener.cancel();
  });

  mockDocumentKeyDown(keyCode, customizeEvent: (MockKeyEvent mock) {
    // Default ctrlKey to a non-null value so it doesn't break callbacks that access it
    // called from tests that don't set it explicitly.
    //
    // (This happens already in w_test_tool to metaKey/shiftKey.)
    when(mock.ctrlKey).thenReturn(false);

    if (customizeEvent != null) customizeEvent(mock);
  });

  return completer.future;
}

/// Dispatches a mock capturing keyup event with [keyCode] and returns a Future
/// [MockKeyEvent] that completes when its [StreamSubscription] listeners have been called.
///
/// Workaround until https://github.com/Workiva/w_test_tools/issues/11 is fixed.
Future<MockKeyEvent> waitKeyUp(int keyCode, {CustomizeEvent customizeEvent}) {
  var completer = new Completer();
  StreamSubscription<MockKeyEvent> keyUpListener;
  keyUpListener = DocumentEventHelper.document.body.onKeyUp.capture((event) {
    completer.complete(event);
    keyUpListener.cancel();
  });

  mockDocumentKeyUp(keyCode, customizeEvent: (MockKeyEvent mock) {
    // Default ctrlKey to a non-null value so it doesn't break callbacks that access it
    // called from tests that don't set it explicitly.
    //
    // (This happens already in w_test_tool to metaKey/shiftKey.)
    when(mock.ctrlKey).thenReturn(false);

    if (customizeEvent != null) customizeEvent(mock);
  });

  return completer.future;
}
