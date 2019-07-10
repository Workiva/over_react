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
String getPropKey<T extends Map>(void accessProp(T keySpy), T factory(Map props)) {
  return _getKey((Map keySpy) {
    return accessProp(factory(keySpy));
  });
}

dynamic _getKey(void accessKey(Map keySpy)) {
  var keySpy = new SingleKeyAccessMapSpy(const {});

  accessKey(keySpy);

  return keySpy.key;
}

/// Helper class that stores the key accessed while getting a value within a Map.
class SingleKeyAccessMapSpy extends MapView {
  SingleKeyAccessMapSpy(Map map) : super(map);

  bool _hasBeenAccessed = false;
  dynamic _key;

  bool get hasBeenAccessed => _hasBeenAccessed;

  void reset() {
    _hasBeenAccessed = false;
    _key = false;
  }

  dynamic get key {
    if (!_hasBeenAccessed) throw new StateError('Key has not been accessed.');

    return _key;
  }

  @override
  operator[](key) {
    if (_hasBeenAccessed) throw new StateError('A key has already been accessed.');

    _key = key;
    _hasBeenAccessed = true;

    return null;
  }
}
