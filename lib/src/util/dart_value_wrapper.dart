// Copyright 2022 Workiva Inc.
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

import 'dart:js';

// Taken from react-dart
/// A wrapper around a value that can't be stored in its raw form
/// within a JS object (e.g., a Dart function).
class DartValueWrapper {
  final Object value;

  const DartValueWrapper(this.value);

  static final _functionWrapperCache = Expando<DartValueWrapper>('_functionWrapperCache');

  static Object wrapIfNeeded(Object value) {
    // This case should be fairly uncommon, since functions usually aren't used as
    // a Redux store's state or the result of a connect or selector hook selector.
    if (value is Function && !identical(allowInterop(value), value)) {
      // Reuse wrappers for the same function so that they're identical to the JS.
      return _functionWrapperCache[value] ??= DartValueWrapper(value);
    }
    return value;
  }

  static T unwrapIfNeeded<T>(Object value) {
    if (value is DartValueWrapper) {
      return value.value as T;
    }
    return value as T;
  }
}
