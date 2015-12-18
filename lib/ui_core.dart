/// Base classes for UI components and related utilities.
library web_skin_dart.ui_core;

// Imports
import 'dart:collection' show MapView;
import 'dart:html';
import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

import 'ui_core/component/callback_typedefs.dart';
import 'ui_core/component/typed_mixins.dart';
import 'ui_core/component_declaration/component_base.dart' as component_base;
import 'ui_core/component_declaration/transformer_helpers.dart';

// Exports
export 'ui_core/component/callback_typedefs.dart';
export 'ui_core/component/resize_sensor.dart';
export 'ui_core/component/typed_mixins.dart';
export 'ui_core/util/character_constants.dart';
export 'ui_core/util/css_value_util.dart';
export 'ui_core/util/document_event_helper_util.dart';
export 'ui_core/util/dom_util.dart';
export 'ui_core/util/guid_util.dart';
export 'ui_core/util/handler_chain_util.dart';
export 'ui_core/util/react_wrappers.dart';
export 'ui_core/util/validation_util.dart';
export 'ui_core/component_declaration/flux_component.dart';
export 'ui_core/component_declaration/transformer_helpers.dart';

// Parts
part 'ui_core/component/aria_mixin.dart';
part 'ui_core/component/base_component.dart';
part 'ui_core/component/dom_components.dart';
part 'ui_core/component/prop_mixins.dart';
part 'ui_core/util/class_names.dart';
part 'ui_core/util/event_helpers.dart';
part 'ui_core/util/map_util.dart';
