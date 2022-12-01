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

/// A wrapper around [Expando] with a more [Map]-like interface, with typing on keys.
///
/// Keys may not be primitive values, and as a result keys are also non-nullable.
///
/// Values may also not be nullable in order to simplify the [has]/[putIfAbsent] implementations
/// by assuming that `null` Expando values correspond unambiguously to unset keys.
class WeakMap<K extends Object, V extends Object> {
  final _valueFor = Expando<V>();

  V? get(K key) => _valueFor[key];

  V? getNullableKey(K? key) => key == null ? null : get(key);

  void set(K key, V value) => _valueFor[key] = value;

  bool has(K key) => get(key) != null;

  void remove(K key) => _valueFor[key] = null;

  V putIfAbsent(K key, V Function() ifAbsent) {
    final existingValue = get(key);
    if (existingValue != null) return existingValue;
    final value = ifAbsent();
    set(key, value);
    return value;
  }
}

extension MemoizeWithWeakMap<K extends Object, V extends Object> on V Function(K) {
  V Function(K) memoizeWithWeakMap(WeakMap<K, V> map) {
    return (key) => map.putIfAbsent(key, () => this(key));
  }
}
