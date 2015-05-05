library ui_core;

///
/// Core UI Library
///   contains base classes for UI components and related utilities
///

//imports
import 'dart:collection' show MapView;
import 'dart:js' show JsObject;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' show ReactComponentFactory;

//parts
part 'src/ui_core/components/base_component.dart';
part 'src/ui_core/components/base_mixins.dart';
part 'src/ui_core/components/dom_components.dart';
part 'src/ui_core/components/prop_mixins.dart';
part 'src/ui_core/utils/class_names.dart';
