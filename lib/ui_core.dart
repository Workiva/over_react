/// Base classes for UI components and related utilities.
library web_skin_dart.ui_core;

// Imports
import 'dart:collection' show MapView, SplayTreeSet;
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

import 'src/ui_core/component/callback_typedefs.dart';
import 'src/ui_core/component_declaration/component_base.dart' as component_base;
import 'src/ui_core/component_declaration/transformer_helpers.dart';

// Exports
export 'src/ui_core/component/abstract_transition.dart';
export 'src/ui_core/component/callback_typedefs.dart';
export 'src/ui_core/component/dummy_component.dart';
export 'src/ui_core/component/prop_typedefs.dart';
export 'src/ui_core/component/resize_sensor.dart';
export 'src/ui_core/util/character_constants.dart';
export 'src/ui_core/util/constants_base.dart';
export 'src/ui_core/util/css_value_util.dart';
export 'src/ui_core/util/document_event_helper_util.dart';
export 'src/ui_core/util/dom_util.dart';
export 'src/ui_core/util/guid_util.dart';
export 'src/ui_core/util/handler_chain_util.dart';
export 'src/ui_core/util/js_util.dart';
export 'src/ui_core/util/key_constants.dart';
export 'src/ui_core/util/pretty_print.dart';
export 'src/ui_core/util/prop_errors.dart';
export 'src/ui_core/util/react_wrappers.dart';
export 'src/ui_core/util/rem_util.dart';
export 'src/ui_core/util/string_util.dart';
export 'src/ui_core/util/test_mode.dart';
export 'src/ui_core/util/validation_util.dart';
export 'src/ui_core/component_declaration/transformer_helpers.dart';

// Parts
part 'src/ui_core/component/aria_mixin.dart';
part 'src/ui_core/component/dom_components.dart';
part 'src/ui_core/component/prop_mixins.dart';
part 'src/ui_core/util/class_names.dart';
part 'src/ui_core/util/event_helpers.dart';
part 'src/ui_core/util/map_util.dart';
part 'src/ui_core/util/react_util.dart';
