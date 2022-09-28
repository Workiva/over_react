@JS()
library react_material_ui.weak_map;

import 'package:js/js.dart';

/// Bindings for the JS WeakMap class, a collection of key/value pairs in which the keys are weakly referenced.
///
/// For more info, see: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap
///
/// This API is supported in IE11 and all modern browsers.
///
/// This class has no type parameters since they cause issues in dart2js: https://github.com/dart-lang/sdk/issues/43373
@JS()
class WeakMap {
  external WeakMap();

  /// Removes any value associated to the [key]. `has(key)` will return false afterwards.
  ///
  /// Returns whether a value was associated with the [key].
  external bool delete(Object key);

  /// Returns the value associated to the [key], or null if there is none.
  external Object get(Object key);

  /// Returns whether a value has been associated to the key.
  external bool has(Object key);

  /// Sets the value for the [key].
  // void since IE11 returns undefined, and you can cascade on the object instead of returning it in Dart.
  external void set(Object key, Object value);
}
