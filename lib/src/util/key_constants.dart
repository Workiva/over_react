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

library over_react.key_constants;

import 'package:over_react/over_react.dart';

/// Key values that are returned from [SyntheticKeyboardEvent.key].
///
/// > See: <https://w3c.github.io/uievents/#h-fixed-virtual-key-codes>.
abstract class KeyValue {
  static const String BACKSPACE = 'Backspace';
  static const String TAB = 'Tab';
  static const String ENTER = 'Enter';
  static const String SHIFT = 'Shift';
  static const String CONTROL = 'Control';
  static const String ALT = 'Alt';
  static const String CAPS_LOCK = 'CapsLock';
  static const String ESC = 'Escape';
  static const String SPACE  = ' ';
  static const String PAGE_UP = 'PageUp';
  static const String PAGE_DOWN = 'PageDown';
  static const String END = 'End';
  static const String HOME = 'Home';
  static const String ARROW_LEFT = 'ArrowLeft';
  static const String ARROW_UP = 'ArrowUp';
  static const String ARROW_RIGHT = 'ArrowRight';
  static const String ARROW_DOWN = 'ArrowDown';
  static const String DELETE = 'Delete';


  /// All of the [KeyValue] values.
  static const List<String> values = const <String>[
    BACKSPACE,
    TAB,
    ENTER,
    SHIFT,
    CONTROL,
    ALT,
    CAPS_LOCK,
    ESC,
    SPACE,
    PAGE_UP,
    PAGE_DOWN,
    END,
    HOME,
    ARROW_LEFT,
    ARROW_UP,
    ARROW_RIGHT,
    ARROW_DOWN,
    DELETE
  ];
}
