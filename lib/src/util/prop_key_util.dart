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

library over_react.prop_key_util;

import 'dart:collection';

/// Returns the string key of the [factory] prop accessed in [accessProp].
///
/// __Example:__
///
///     var valuePropKey = getPropKey((props) => props.value, TextInput);
String getPropKey<T extends Map>(void Function(T keySpy) accessProp, T Function(Map props) factory) {
  return _getKey((keySpy) {
    return accessProp(factory(keySpy));
  }) as String;
}

dynamic _getKey(void Function(Map keySpy) accessKey) {
  final keySpy = _SingleKeyAccessMapSpy();
  // When they access a key, _SingleKeyAccessMapSpy will throw a KeyAccessedException.
  try {
    accessKey(keySpy);
  } on KeyAccessedException catch (e) {
    return e.key;
  }
  // Edge-case: they caught our exception; attempt to still return the caught key.
  return keySpy.key;
}

/// Helper class that stores the key accessed while getting a value within a Map.
class _SingleKeyAccessMapSpy extends MapBase {
  bool _hasBeenAccessed = false;
  Object? _key;

  dynamic get key {
    if (!_hasBeenAccessed) throw StateError('Key has not been accessed.');
    return _key;
  }

  @override
  operator [](key) {
    if (_hasBeenAccessed) throw StateError('A key has already been accessed.');

    _key = key;
    _hasBeenAccessed = true;

    // Throw an exception to ourselves, so that we don't trigger any type errors caused by
    // returning null here.
    throw KeyAccessedException(key);
  }

  static UnsupportedError _unsupportedReadError() => UnsupportedError('Mutating this map is not supported; only read from it.');

  @override
  void operator []=(key, value) => throw _unsupportedReadError();

  @override
  void clear() => throw _unsupportedReadError();

  @override
  Iterable get keys => const [];

  @override
  remove(Object? key) => throw _unsupportedReadError();
}

// FIXME document, add test cases (especially for non-nullable props).
class KeyAccessedException implements Exception {
  final Object? key;

  KeyAccessedException(this.key);
}
