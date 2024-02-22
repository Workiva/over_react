// @dart=2.11
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

Object _getKey(void Function(Map keySpy) accessKey) {
  final keySpy = _SingleKeyAccessMapSpy();
  // When they access a key, _SingleKeyAccessMapSpy will throw a _InterceptedKeyAccessException.
  try {
    accessKey(keySpy);
  } on _InterceptedKeyAccessException catch (e) {
    return e.key;
  }
  // Edge-case: they caught our exception; attempt to still return the caught key.
  return keySpy.key;
}

/// Helper class that stores the key accessed while getting a value within a Map.
class _SingleKeyAccessMapSpy extends MapBase {
  bool _hasBeenAccessed = false;
  Object _key;

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
    throw _InterceptedKeyAccessException(key);
  }

  static UnsupportedError _unsupportedReadError() => UnsupportedError('Mutating this map is not supported; only read from it.');

  @override
  void operator []=(key, value) => throw _unsupportedReadError();

  @override
  void clear() => throw _unsupportedReadError();

  @override
  Iterable get keys => const [];

  @override
  remove(Object key) => throw _unsupportedReadError();
}

/// An exception thrown as part of [_SingleKeyAccessMapSpy]'s operation, in order to short-circuit
/// any logic that comes after intercepting the key access.
class _InterceptedKeyAccessException implements Exception {
  // The key being accessed.
  final Object key;

  _InterceptedKeyAccessException(this.key);
}
