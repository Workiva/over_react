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

// ignore_for_file: prefer_generic_function_type_aliases
library over_react.callback_typedefs;

import 'dart:html';


import 'package:react/react.dart' as react;

// Callbacks for React's DOM event system
typedef DomEventCallback(react.SyntheticEvent event);
typedef AnimationEventCallback(react.SyntheticAnimationEvent event);
typedef ClipboardEventCallback(react.SyntheticClipboardEvent event);
typedef KeyboardEventCallback(react.SyntheticKeyboardEvent event);
typedef FocusEventCallback(react.SyntheticFocusEvent event);
typedef FormEventCallback(react.SyntheticFormEvent event);
typedef MouseEventCallback(react.SyntheticMouseEvent event);
typedef PointerEventCallback(react.SyntheticPointerEvent event);
typedef TouchEventCallback(react.SyntheticTouchEvent event);
typedef TransitionEventCallback(react.SyntheticTransitionEvent event);
typedef UIEventCallback(react.SyntheticUIEvent event);
typedef WheelEventCallback(react.SyntheticWheelEvent event);

/// A generic callback that takes no arguments.
typedef Callback();

/// A generic callback that takes a single `bool` [value].
typedef BoolCallback(bool value);

/// Callback for DOM elements
typedef Element ElementCallback();

/// Callback for [ResizeSensorEvent]s
typedef void ResizeSensorHandler(ResizeSensorEvent event);
