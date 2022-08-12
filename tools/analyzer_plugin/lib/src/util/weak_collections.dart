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

class WeakSet<E extends Object> {
  final _isEntry = Expando<bool>();

  void add(E key) => _isEntry[key] = true;

  bool has(E key) => _isEntry[key] ?? false;

  void remove(E key) => _isEntry[key] = null;
}

class WeakMap<K extends Object, V extends Object> {
  final _keys = WeakSet<K>();
  final _valueFor = Expando<V>();

  V? get(K key) => has(key) ? _valueFor[key] : null;

  V? getNullableKey(K? key) => key == null ? null : get(key);

  void set(K key, V value) {
    _keys.add(key);
    _valueFor[key] = value;
  }

  bool has(K key) => _keys.has(key);

  void remove(K key) {
    _keys.remove(key);
    _valueFor[key] = null;
  }

  V putIfAbsent(K key, V Function() ifAbsent) {
    if (has(key)) return get(key)!;
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
