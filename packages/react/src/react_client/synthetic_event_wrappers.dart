/// JS interop classes for React synthetic events.
///
/// For use in `react_client.dart` and by advanced react-dart users.
@JS()
library react_client.synthetic_event_wrappers;

import 'dart:html';
import 'package:js/js.dart';

@JS()
@anonymous
class SyntheticEvent {
  external bool get bubbles;
  external bool get cancelable;
  external get currentTarget;
  external bool get defaultPrevented;
  external num get eventPhase;
  external bool get isTrusted;
  external get nativeEvent;
  external get target;
  external num get timeStamp;
  external String get type;

  external void stopPropagation();
  external void preventDefault();

  external void persist();
}

@JS()
@anonymous
class SyntheticClipboardEvent extends SyntheticEvent {
  external get clipboardData;
}

@JS()
@anonymous
class SyntheticKeyboardEvent extends SyntheticEvent {
  external bool get altKey;
  external String get char;
  external bool get ctrlKey;
  external String get locale;
  external num get location;
  external String get key;
  external bool get metaKey;
  external bool get repeat;
  external bool get shiftKey;
  external num get keyCode;
  external num get charCode;
}

@JS()
@anonymous
class SyntheticFocusEvent extends SyntheticEvent {
  external EventTarget get relatedTarget;
}

@JS()
@anonymous
class SyntheticFormEvent extends SyntheticEvent {}

@JS()
@anonymous
class SyntheticDataTransfer {
  external String get dropEffect;
  external String get effectAllowed;
  external List<File> get files;
  external List<String> get types;
}

@JS()
@anonymous
class SyntheticMouseEvent extends SyntheticEvent {
  external bool get altKey;
  external num get button;
  external num get buttons;
  external num get clientX;
  external num get clientY;
  external bool get ctrlKey;
  external SyntheticDataTransfer get dataTransfer;
  external bool get metaKey;
  external num get pageX;
  external num get pageY;
  external EventTarget get relatedTarget;
  external num get screenX;
  external num get screenY;
  external bool get shiftKey;
}

@JS()
@anonymous
class SyntheticTouchEvent extends SyntheticEvent {
  external bool get altKey;
  external TouchList get changedTouches;
  external bool get ctrlKey;
  external bool get metaKey;
  external bool get shiftKey;
  external TouchList get targetTouches;
  external TouchList get touches;
}

@JS()
@anonymous
class SyntheticUIEvent extends SyntheticEvent {
  external num get detail;
  external get view;
}

@JS()
@anonymous
class SyntheticWheelEvent extends SyntheticEvent {
  external num get deltaX;
  external num get deltaMode;
  external num get deltaY;
  external num get deltaZ;
}
