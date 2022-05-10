@JS()
library react_material_ui.weak_map;

import 'package:js/js.dart';

/// Bindings for the JS WeakMap class, a collection of key/value pairs in which the keys are weakly referenced.
///
/// For more info, see: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap
///
/// This API is supported in IE11 and all modern browsers.
@JS()
class WeakMap<K, V> {
  external factory WeakMap();

  /// Removes any value associated to the [key]. `has(key)` will return false afterwards.
  ///
  /// Returns whether a value was associated with the [key].
  external bool delete(K key);

  /// Returns the value associated to the [key], or null if there is none.
  external V get(K key);

  /// Returns whether a value has been associated to the key.
  external bool has(K key);

  /// Sets the value for the [key].
  // void since IE11 returns undefined, and you can cascade on the object instead of returning it in Dart.
  external void set(key, value);
}
