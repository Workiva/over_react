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

/// A wrapper around [Expando] with typing on keys, and also allowing nullable values.
///
/// Keys may not be primitive values, and as a result keys are also non-nullable.
///
/// Similar to the JS `WeakMap`.
class WeakMap<K extends Object, V> {
  final _wrappedValues = Expando<_ValueWrapper<V>>();

  /// Returns the value for the given [key], or null if there is no entry.
  V? get(K key) => _wrappedValues[key]?.value;

  /// Returns the value for the given [key], or null if there is no entry.
  ///
  /// This method the same as [get], but also allows nullable keys for convenience.
  ///
  /// `getNullableKey(null)` will always return null.
  V? getNullableKey(K? key) => key == null ? null : get(key);

  /// Sets the [value] for the given [key], overwriting any existing value.
  void set(K key, V value) => _wrappedValues[key] = _ValueWrapper(value);

  /// Returns whether a value has been set for [key].
  bool has(K key) => _wrappedValues[key] != null;

  /// Removes any value previously set for [key].
  void remove(K key) => _wrappedValues[key] = null;

  /// Look up the value of [key], or add a new entry if it isn't there.
  ///
  /// Returns the value associated to [key], if there is one.
  /// Otherwise calls [ifAbsent] to get a new value, associates [key] to
  /// that value, and then returns the new value.
  V putIfAbsent(K key, V Function() ifAbsent) => (_wrappedValues[key] ??= _ValueWrapper(ifAbsent())).value;
}

/// A wrapper around a WeakMap value.
///
/// Used to allow null values in [WeakMap] and tell them apart from unset values,
/// since [Expando] doesn't allow nullable values.
class _ValueWrapper<T> {
  final T value;

  _ValueWrapper(this.value);
}

extension MemoizeWithWeakMap<K extends Object, V> on V Function(K) {
  /// Memoizes this function by storing the return value in a WeakMap, keyed by the single argument.
  ///
  /// Optionally uses [map], or creates a new WeakMap if not specified.
  ///
  /// Note that return values will be retained by their corresponding argument values,
  /// unless they're explicitly removed in the map.
  V Function(K) memoizeWithWeakMap([WeakMap<K, V>? map]) {
    final _map = map ?? WeakMap();
    return (key) => _map.putIfAbsent(key, () => this(key));
  }
}

/// Memoizes [computeValue] by storing the return value in a WeakMap, keyed by the single argument.
///
/// Optionally uses [map], or creates a new WeakMap if not specified.
///
/// Note that return values will be retained by their corresponding argument values,
/// unless they're explicitly removed in the map.
V Function(K) memoizeWithWeakMap<K extends Object, V>(V Function(K) computeValue, [WeakMap<K, V>? map]) =>
    computeValue.memoizeWithWeakMap(map);
