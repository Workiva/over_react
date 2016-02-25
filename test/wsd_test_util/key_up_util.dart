library test_util.key_up_util;

import 'dart:html';
import 'dart:async';

import 'package:web_skin_dart/ui_core.dart';
import 'package:mockito/mockito.dart';

import 'mock_classes.dart';

// Expose utilities in ui_core/util/react_wrappers.dart
export 'package:web_skin_dart/ui_core.dart';

/// Controller used in keyDown events.
StreamController _mockedKeyUpController;

/// Helper function that sets up the StreamController to listen for KeyDown events.
/// To be called in the setUp of a group.
void setUpKeyUpNative() {
  _mockedKeyUpController = new StreamController(sync: true);
  var stream = _mockedKeyUpController.stream.asBroadcastStream();

  var documentSpy = spy(new MockDocument(), document);
  when(documentSpy.onKeyUp).thenReturn(stream);

  DocumentEventHelper.document = documentSpy;
}

/// Helper function to add a KeyDown event to the stream.
/// To be called in the test of a group.
void mockedKeyUp(int keyCode) {
  var mockKeyEvent = new MockKeyEvent();
  when(mockKeyEvent.type).thenReturn('keyup');
  when(mockKeyEvent.keyCode).thenReturn(keyCode);
  when(mockKeyEvent.target).thenReturn(document);

  if (_mockedKeyUpController != null) {
    _mockedKeyUpController.add(mockKeyEvent);
  }
}

/// Helper function to resets the DocumentEventHelper.
/// To be called in the tearDown of a group.
void tearDownKeyUpNative() {
  DocumentEventHelper.document = document;
}
