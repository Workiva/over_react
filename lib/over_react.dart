// Copyright 2016 Workiva Inc.
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

/// Base classes for UI components and related utilities.
library over_react;

export 'package:react/react.dart' show
    SyntheticEvent,
    SyntheticClipboardEvent,
    SyntheticKeyboardEvent,
    SyntheticFocusEvent,
    SyntheticFormEvent,
    SyntheticDataTransfer,
    SyntheticMouseEvent,
    SyntheticTouchEvent,
    SyntheticUIEvent,
    SyntheticWheelEvent;

export 'package:react/react_client.dart' show setClientConfiguration, ReactElement;

export 'src/component/abstract_transition.dart';
export 'src/component/abstract_transition_props.dart';
export 'src/component/aria_mixin.dart';
export 'src/component/callback_typedefs.dart';
export 'src/component/dom_components.dart';
export 'src/component/dummy_component.dart';
export 'src/component/prop_mixins.dart';
export 'src/component/prop_typedefs.dart';
export 'src/component/resize_sensor.dart';
export 'src/component_declaration/built_redux_component.dart';
export 'src/component_declaration/flux_component.dart';
export 'src/component_declaration/transformer_helpers.dart';
export 'src/util/character_constants.dart';
export 'src/util/class_names.dart';
export 'src/util/constants_base.dart';
export 'src/util/css_value_util.dart';
export 'src/util/dom_util.dart';
export 'src/util/event_helpers.dart';
export 'src/util/guid_util.dart';
export 'src/util/handler_chain_util.dart';
export 'src/util/key_constants.dart';
export 'src/util/map_util.dart';
export 'src/util/pretty_print.dart';
export 'src/util/prop_errors.dart';
export 'src/util/prop_key_util.dart';
export 'src/util/react_wrappers.dart';
export 'src/util/rem_util.dart';
export 'src/util/string_util.dart';
export 'src/util/test_mode.dart';
export 'src/util/validation_util.dart';
