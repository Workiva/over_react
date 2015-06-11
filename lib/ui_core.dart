/// Base classes for UI components and related utilities.
library w_ui_platform.ui_core;

//imports
import 'dart:collection' show MapView;
import 'dart:js';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

//parts
part 'src/ui_core/component/base_component.dart';
part 'src/ui_core/component/callback_typedefs.dart';
part 'src/ui_core/component/color_props.dart';
part 'src/ui_core/component/dom_components.dart';
part 'src/ui_core/component/hitarea_mixin.dart';
part 'src/ui_core/component/prop_mixins.dart';
part 'src/ui_core/component/typed_mixins.dart';
part 'src/ui_core/util/class_names.dart';
part 'src/ui_core/util/map_util.dart';
part 'src/ui_core/util/validation_util.dart';
part 'src/ui_core/util/react_wrappers.dart';
