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

library event_helpers_test;

import 'dart:html';

import 'package:mockito/mockito.dart';
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for Event Helpers testing
main() {
  test('wrapNativeKeyboardEvent', () {
    var nativeKeyboardEvent = new MockKeyboardEvent();
    var currentTarget = new DivElement();
    var target = new DivElement();

    when(nativeKeyboardEvent.bubbles).thenReturn(true);
    when(nativeKeyboardEvent.cancelable).thenReturn(true);
    when(nativeKeyboardEvent.currentTarget).thenReturn(currentTarget);
    when(nativeKeyboardEvent.defaultPrevented).thenReturn(false);
    when(nativeKeyboardEvent.preventDefault).thenReturn(() {});
    when(nativeKeyboardEvent.stopPropagation).thenReturn(() {});
    when(nativeKeyboardEvent.eventPhase).thenReturn(0);
    when(nativeKeyboardEvent.target).thenReturn(target);
    when(nativeKeyboardEvent.timeStamp).thenReturn(0);
    when(nativeKeyboardEvent.type).thenReturn('type');
    when(nativeKeyboardEvent.altKey).thenReturn(false);
    when(nativeKeyboardEvent.charCode).thenReturn(0);
    when(nativeKeyboardEvent.ctrlKey).thenReturn(false);
    when(nativeKeyboardEvent.location).thenReturn(0);
    when(nativeKeyboardEvent.keyCode).thenReturn(0);
    when(nativeKeyboardEvent.metaKey).thenReturn(false);
    when(nativeKeyboardEvent.repeat).thenReturn(false);
    when(nativeKeyboardEvent.shiftKey).thenReturn(false);

    expect(nativeKeyboardEvent.defaultPrevented, isFalse);

    var syntheticKeyboardEvent = wrapNativeKeyboardEvent(nativeKeyboardEvent);

    expect(syntheticKeyboardEvent.bubbles, isTrue);
    expect(syntheticKeyboardEvent.cancelable, isTrue);
    expect(syntheticKeyboardEvent.currentTarget, currentTarget);
    expect(syntheticKeyboardEvent.defaultPrevented, isFalse);
    expect(() => syntheticKeyboardEvent.preventDefault(), returnsNormally);
    expect(() => syntheticKeyboardEvent.stopPropagation(), returnsNormally);
    expect(syntheticKeyboardEvent.eventPhase, 0);
    expect(syntheticKeyboardEvent.isTrusted, isNull);
    expect(syntheticKeyboardEvent.nativeEvent, nativeKeyboardEvent);
    expect(syntheticKeyboardEvent.target, target);
    expect(syntheticKeyboardEvent.timeStamp, 0);
    expect(syntheticKeyboardEvent.type, 'type');
    expect(syntheticKeyboardEvent.altKey, isFalse);
    expect(syntheticKeyboardEvent.char, new String.fromCharCode(0));
    expect(syntheticKeyboardEvent.charCode, 0);
    expect(syntheticKeyboardEvent.ctrlKey, isFalse);
    expect(syntheticKeyboardEvent.locale, isNull);
    expect(syntheticKeyboardEvent.location, 0);
    expect(syntheticKeyboardEvent.key, isNull);
    expect(syntheticKeyboardEvent.keyCode, 0);
    expect(syntheticKeyboardEvent.metaKey, isFalse);
    expect(syntheticKeyboardEvent.repeat, isFalse);
    expect(syntheticKeyboardEvent.shiftKey, isFalse);
  });

  test('wrapNativeMouseEvent', () {
    var nativeMouseEvent = new MockMouseEvent();
    var currentTarget = new DivElement();
    var target = new DivElement();
    var relatedTarget = new DivElement();

    when(nativeMouseEvent.bubbles).thenReturn(true);
    when(nativeMouseEvent.cancelable).thenReturn(true);
    when(nativeMouseEvent.currentTarget).thenReturn(currentTarget);
    when(nativeMouseEvent.defaultPrevented).thenReturn(false);
    when(nativeMouseEvent.preventDefault).thenReturn(() {});
    when(nativeMouseEvent.stopPropagation).thenReturn(() {});
    when(nativeMouseEvent.eventPhase).thenReturn(0);
    when(nativeMouseEvent.target).thenReturn(target);
    when(nativeMouseEvent.timeStamp).thenReturn(0);
    when(nativeMouseEvent.type).thenReturn('type');
    when(nativeMouseEvent.altKey).thenReturn(false);
    when(nativeMouseEvent.button).thenReturn(0);
    when(nativeMouseEvent.ctrlKey).thenReturn(false);
    when(nativeMouseEvent.metaKey).thenReturn(false);
    when(nativeMouseEvent.relatedTarget).thenReturn(relatedTarget);
    when(nativeMouseEvent.shiftKey).thenReturn(false);

    var syntheticMouseEvent = wrapNativeMouseEvent(nativeMouseEvent);

    expect(syntheticMouseEvent.bubbles, isTrue);
    expect(syntheticMouseEvent.cancelable, isTrue);
    expect(syntheticMouseEvent.currentTarget, currentTarget);
    expect(syntheticMouseEvent.defaultPrevented, isFalse);
    expect(() => syntheticMouseEvent.preventDefault(), returnsNormally);
    expect(() => syntheticMouseEvent.stopPropagation(), returnsNormally);
    expect(syntheticMouseEvent.eventPhase, 0);
    expect(syntheticMouseEvent.isTrusted, isNull);
    expect(syntheticMouseEvent.nativeEvent, nativeMouseEvent);
    expect(syntheticMouseEvent.target, target);
    expect(syntheticMouseEvent.timeStamp, 0);
    expect(syntheticMouseEvent.type, 'type');
    expect(syntheticMouseEvent.altKey, isFalse);
    expect(syntheticMouseEvent.button, 0);
    expect(syntheticMouseEvent.buttons, isNull);
    expect(syntheticMouseEvent.clientX, isNull);
    expect(syntheticMouseEvent.clientY, isNull);
    expect(syntheticMouseEvent.ctrlKey, isFalse);
    expect(syntheticMouseEvent.dataTransfer, isNull);
    expect(syntheticMouseEvent.metaKey, isFalse);
    expect(syntheticMouseEvent.pageX, isNull);
    expect(syntheticMouseEvent.pageY, isNull);
    expect(syntheticMouseEvent.relatedTarget, relatedTarget);
    expect(syntheticMouseEvent.screenX, isNull);
    expect(syntheticMouseEvent.screenY, isNull);
    expect(syntheticMouseEvent.shiftKey, isFalse);
  });

  test('fakeSyntheticFormEvent', () {
    var element = new DivElement();
    var fakeEvent = fakeSyntheticFormEvent(element, 'change');

    expect(fakeEvent.bubbles, isFalse);
    expect(fakeEvent.cancelable, isFalse);
    expect(fakeEvent.currentTarget, element);
    expect(fakeEvent.defaultPrevented, false);
    expect(() => fakeEvent.preventDefault(), returnsNormally);
    expect(() => fakeEvent.stopPropagation(), returnsNormally);
    expect(fakeEvent.eventPhase, Event.AT_TARGET);
    expect(fakeEvent.isTrusted, isFalse);
    expect(fakeEvent.nativeEvent, isNull);
    expect(fakeEvent.target, element);
    expect(fakeEvent.timeStamp, new isInstanceOf<int>());
    expect(fakeEvent.type, 'change');
  });
}


class MockKeyboardEvent extends Mock implements KeyboardEvent {}
class MockMouseEvent extends Mock implements MouseEvent {}
