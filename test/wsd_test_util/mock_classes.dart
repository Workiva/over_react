library mock_classes;

import 'dart:async';
import 'dart:html';

import 'package:mockito/mockito.dart';

class MockKeyEvent extends Mock implements KeyEvent {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockDocument extends Mock implements Document {
  noSuchMethod(i) => super.noSuchMethod(i);
}

typedef void _TimerCallback();

class MockTimer extends Mock implements Timer {
  noSuchMethod(i) => super.noSuchMethod(i);

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
