library ui_core.warn_on_modify_map;

import 'dart:collection';
import 'package:web_skin_dart/ui_core.dart';

class WarnOnModifyProps<K, V> extends MapView<K, V> {
  WarnOnModifyProps(Map backingMap): super(backingMap);

  @override
  operator []=(K key, V value) {
    _warn();
    return super[key] = value;
  }

  @override
  void addAll(Map<K, V> other) {
    _warn();
    super.addAll(other);
  }

  @override
  void clear() {
    _warn();
    super.clear();
  }

  @override
  V putIfAbsent(K key, V ifAbsent()) {
    _warn();
    return super.putIfAbsent(key, ifAbsent);
  }

  @override
  V remove(Object key) {
    _warn();
    return super.remove(key);
  }

  _warn() {
    assert(ValidationUtil.warn(unindent(
      '''
      The props being modified belong to an existing component. Modifications to these props may cause
      undesired behavior.
      '''
    )));
  }
}
