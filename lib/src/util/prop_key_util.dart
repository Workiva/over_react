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
  var keySpy = _SingleKeyAccessMapSpy(const {});

  accessKey(keySpy);

  return keySpy.key;
}

/// Helper class that stores the key accessed while getting a value within a Map.
class _SingleKeyAccessMapSpy extends MapView {
  _SingleKeyAccessMapSpy(Map map) : super(map);

  bool _hasBeenAccessed = false;

  dynamic _key;

  dynamic get key {
    if (!_hasBeenAccessed) throw StateError('Key has not been accessed.');

    return _key;
  }

  @override
  operator [](key) {
    if (_hasBeenAccessed) throw StateError('A key has already been accessed.');

    _key = key;
    _hasBeenAccessed = true;

    return null;
  }
}
