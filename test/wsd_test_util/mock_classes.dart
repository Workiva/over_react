// Copyright 2016 Workiva Inc.
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

library mock_classes;

import 'dart:async';
import 'dart:html';

// Tell dart2js that the `mockito` package only needs to reflect the specified mock/spied types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'dart.async.Timer',
  'MockTimer',
  // Also include Mock classes we use from w_test_tools.
  'dart.dom.html.KeyEvent',
  'dart.dom.html.HtmlDocument',
  'w_test_tools.src.mock_classes.MockKeyEvent',
  'w_test_tools.src.mock_classes.MockDocument',
  'MockFileList',
  'MockFile',
  'MockFileUploadInputElement',
  'dart.dom.html.FileList',
  'dart.dom.html.File',
  'dart.dom.html.FileUploadInputElement',
  'MockSyntheticEvent',
  'MockSyntheticMouseEvent',
  'react.SyntheticEvent',
  'react.SyntheticMouseEvent',
], override: 'mockito')
import 'dart:mirrors';

import 'package:mockito/mockito.dart';
import 'package:react/react.dart' as react;

typedef void _TimerCallback();

class MockTimer extends Mock implements Timer {
  bool _isInstantiated = false;
  _TimerCallback _callback;
  Duration _duration;

  /// Whether the timer has been initialized via [getTimerFactory].
  bool get isInstantiated => _isInstantiated;

  /// The callback the timer was initialized with.
  _TimerCallback get callback => _callback;

  /// The duration the timer was initialized with.
  Duration get duration => _duration;

  /// Returns a function that initializes [mock] with the given duration and callback.
  ///
  /// This function will raise an [AssertionError] if called more than once.
  static Function getTimerFactory(MockTimer mock) {
    Timer timerFactory(Duration duration, _TimerCallback callback) {
      assert(!mock._isInstantiated);

      mock._isInstantiated = true;
      mock._callback = callback;
      mock._duration = duration;

      return mock;
    };

    return timerFactory;
  }
}

class MockFileList extends Mock implements FileList {}

class MockFile extends Mock implements File {}

class MockFileUploadInputElement extends Mock implements FileUploadInputElement {}

class MockSyntheticEvent extends Mock implements react.SyntheticEvent {}

class MockSyntheticMouseEvent extends Mock implements react.SyntheticMouseEvent {}

class MockMouseEvent extends Mock implements MouseEvent {}
