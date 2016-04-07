library ui_core.warn_on_modify_map;

import 'dart:collection';
import 'package:web_skin_dart/ui_core.dart';

class WarnOnModifyProps<K, V> extends MapView<K, V> {
  WarnOnModifyProps(Map backingMap): super(backingMap);
}
