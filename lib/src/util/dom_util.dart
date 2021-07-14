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

library over_react.dom_util;

import 'dart:html';

import 'package:platform_detect/platform_detect.dart';

import './string_util.dart';
import './validation_util.dart';

/// Returns whether [root] is the same as or contains the [other] node.
///
/// Returns false if either [root] or [other] is null.
bool isOrContains(Element root, Element other) => (
  (root != null && other != null) &&
  (root == other || root.contains(other))
);

/// Returns an Iterable of [element] and all its ancestors, in ascending order.
Iterable<Element> _hierarchy(Element element) sync* {
  var current = element;
  do {
    yield current;
  } while ((current = current.parent) != null);
}

/// Returns the closest element in the hierarchy of [lowerBound] up to an optional [upperBound] (both inclusive)
/// that matches [selector], or `null` if no matches are found.
Element closest(Element lowerBound, String selector, {Element upperBound}) {
  for (var element in _hierarchy(lowerBound)) {
    if (element.matches(selector)) return element;
    if (upperBound != null && upperBound == element) break;
  }

  return null;
}

/// Returns the currently focused element ([Document.activeElement]),
/// or the focused element within a ShadowDOM ([ShadowRoot.activeElement]),
/// or `null` if nothing is focused (e.g. [Document.activeElement] is [BodyElement]).
Element getActiveElement() {
  var activeElement = document.activeElement;

  while (activeElement.shadowRoot != null) {
    activeElement = activeElement.shadowRoot.activeElement;
  }

  if (activeElement is! Element || activeElement == document.body) return null;

  return activeElement;
}

/// A list of the `type` attribute values for an HTML `<input>` element that implement [TextInputElementBase].
///
/// Necessary because of the circular inheritance hierarchy in Dart's [InputElement] class structure.
///
/// See: <https://github.com/dart-lang/sdk/issues/22967>
const List<String> inputTypesWithSelectionRangeSupport = [
  'search',
  'text',
  'url',
  'tel',
  'email',
  'password',
  'number',
];

/// Returns whether the provided [element] supports `setSelectionRange`.
///
/// Necessary in part because of the circular inheritance hierarchy in Dart's [InputElement] class structure,
/// and in part because the classes do not correspond to whether setSelectionRange is supported (e.g. number inputs).
///
/// See: <https://github.com/dart-lang/sdk/issues/22967>
bool supportsSelectionRange(InputElement element) {
  // Uncomment once https://github.com/dart-lang/sdk/issues/22967 is fixed.
  // if (element is TextInputElementBase) return true;

  final type = element.getAttribute('type');
  return inputTypesWithSelectionRangeSupport.contains(type);
}

/// Custom implementation to prevent the error that [TextInputElementBase.setSelectionRange] throws when called
/// on an [EmailInputElement] or [NumberInputElement] since ONLY Chrome does not support it.
///
/// A warning will be displayed in the console instead of an error.
///
/// __Example that will throw an exception in Chrome:__
///     InputElement inputNodeRef;
///
///     // This will throw an exception in Chrome when the node is focused.
///     renderEmailInput() {
///       return (Dom.input()
///         ..type = 'email'
///         ..onFocus = (_) {
///           inputNodeRef.setSelectionRange(inputNodeRef.value.length, inputNodeRef.value.length);
///         }
///         ..ref = (instance) { inputNodeRef = instance; }
///       )();
///     }
///
/// __Example that will not throw:__
///     InputElement inputNodeRef;
///
///     // This will not throw an exception - and will work in all
///     // browsers except Chrome until
///     // https://bugs.chromium.org/p/chromium/issues/detail?id=324360
///     // is fixed.
///     renderChromeSafeEmailInput() {
///       return (Dom.input()
///         ..type = 'email'
///         ..onFocus = (_) {
///           setSelectionRange(inputNodeRef, inputNodeRef.value.length, inputNodeRef.value.length);
///         }
///         ..ref = (instance) { inputNodeRef = instance; }
///       )();
///     }
///
/// See: <https://bugs.chromium.org/p/chromium/issues/detail?id=324360>
void setSelectionRange(/* TextInputElement | TextAreaElement */Element input, int start, int end, [String direction]) {
  if (input is TextAreaElement) {
    input.setSelectionRange(start, end, direction);
  } else if (input is InputElement && supportsSelectionRange(input)) {
    if (browser.isChrome || browser.isFirefox) {
      final inputType = input.getAttribute('type');

      if (inputType == 'email' || inputType == 'number') {
        assert(ValidationUtil.warn(unindent(
            '''
            Google Chrome does not support `setSelectionRange` on email or number inputs.
            See: https://bugs.chromium.org/p/chromium/issues/detail?id=324360
            '''
        ), input));

        return;
      }
    }

    input.setSelectionRange(start, end, direction);
  } else {
    throw ArgumentError.value(input, 'input', 'must be an instance of `TextInputElementBase`, `NumberInputElement` or `TextAreaElement`');
  }
}

/// Returns the index of the first selected character in [input].
///
/// To workaround a bug in Chrome, returns `null` for [EmailInputElement] and [NumberInputElement] on Chrome.
/// `null` will also be returned for any [input] that does not support `selectionStart`.
///
/// See: <https://bugs.chromium.org/p/chromium/issues/detail?id=324360>
int getSelectionStart(Element input) {
  if (input is TextAreaElement) {
    return input.selectionStart;
  } else if (input is InputElement && supportsSelectionRange(input)) {
    final inputType = input.getAttribute('type');

    if (browser.isChrome || browser.isFirefox) {
      if (inputType == 'email' || inputType == 'number') {
        // ignore: avoid_returning_null
        return null;
      }
    }

    return input.selectionStart;
  }

  // ignore: avoid_returning_null
  return null;
}
