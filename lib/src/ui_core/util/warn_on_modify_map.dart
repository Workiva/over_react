library ui_core.warn_on_modify_map;

import 'dart:collection';

class WarnOnModifyMap extends MapView {
  WarnOnModifyMap(Map backingMap): super(backingMap);
}
