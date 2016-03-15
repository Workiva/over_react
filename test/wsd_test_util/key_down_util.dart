library test_util.key_down_util;

import 'dart:html';
import 'dart:async';
// Tell dart2js that the `mockito` package only needs to reflect the specified mock/spied types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'dart.dom.html.Document',
], override: 'mockito')
import 'dart:mirrors';

import 'package:web_skin_dart/ui_core.dart';
import 'package:mockito/mockito.dart';

import 'mock_classes.dart';

// Expose utilities in ui_core/util/react_wrappers.dart
export 'package:web_skin_dart/ui_core.dart';

/// Controller used in keyDown events.
StreamController _mockedKeyDownController;

/// Helper function that sets up the StreamController to listen for KeyDown events.
/// To be called in the setUp of a group.
void setUpKeyDownNative() {
  _mockedKeyDownController = new StreamController(sync: true);
  var stream = _mockedKeyDownController.stream.asBroadcastStream();

  var documentSpy = spy(new MockDocument(), document);
  when(documentSpy.onKeyDown).thenReturn(stream);

  DocumentEventHelper.document = documentSpy;
}

/// Helper function to add a KeyDown event to the stream.
/// To be called in the test of a group.
void mockedKeyDown(int keyCode) {
  var mockKeyEvent = new MockKeyEvent();
  when(mockKeyEvent.type).thenReturn('keydown');
  when(mockKeyEvent.keyCode).thenReturn(keyCode);
  when(mockKeyEvent.target).thenReturn(document);

  if (_mockedKeyDownController != null) {
    _mockedKeyDownController.add(mockKeyEvent);
  }
}

/// Helper function to resets the DocumentEventHelper.
/// To be called in the tearDown of a group.
void tearDownKeyDownNative() {
  DocumentEventHelper.document = document;
}
