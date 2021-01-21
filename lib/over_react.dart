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

export 'package:react/react.dart'
    show
        SyntheticEvent,
        SyntheticAnimationEvent,
        SyntheticClipboardEvent,
        SyntheticKeyboardEvent,
        SyntheticFocusEvent,
        SyntheticFormEvent,
        SyntheticMouseEvent,
        SyntheticTouchEvent,
        SyntheticTransitionEvent,
        SyntheticUIEvent,
        SyntheticWheelEvent,
        TypedSnapshot,
        createSyntheticEvent,
        createSyntheticClipboardEvent,
        createSyntheticKeyboardEvent,
        createSyntheticCompositionEvent,
        createSyntheticFocusEvent,
        createSyntheticFormEvent,
        createSyntheticMouseEvent,
        createSyntheticPointerEvent,
        createSyntheticTouchEvent,
        createSyntheticTransitionEvent,
        createSyntheticAnimationEvent,
        createSyntheticUIEvent,
        createSyntheticWheelEvent,
        fakeSyntheticFormEvent,
        wrapNativeKeyboardEvent,
        wrapNativeMouseEvent,
        SyntheticEventTypeHelpers,
        DataTransferHelper;

export 'package:react/react_client/js_backed_map.dart' show JsBackedMap;

export 'package:react/react_client.dart'
    // ignore: deprecated_member_use
    show
        // ignore: deprecated_member_use
        setClientConfiguration,
        chainRefs,
        ReactElement,
        ReactComponentFactoryProxy;
export 'package:react/react_client/react_interop.dart' show ReactErrorInfo, Ref;
export 'package:react/hooks.dart' show StateHook, ReducerHook;

export 'src/component/_deprecated/abstract_transition.dart';
export 'src/component/_deprecated/abstract_transition_props.dart';
export 'src/component/aria_mixin.dart';
export 'src/component/callback_typedefs.dart';
export 'src/component/_deprecated/error_boundary.dart';
export 'src/component/_deprecated/error_boundary_mixins.dart' hide LegacyErrorBoundaryApi;
export 'src/component/dom_components.dart';
export 'src/component/error_boundary_api.dart' show defaultErrorBoundaryLoggerName;
export 'src/component/ref_util.dart';
export 'src/component/fragment_component.dart';
export 'src/component/hooks.dart';
export 'src/component/strictmode_component.dart';
export 'src/component/dummy_component.dart';
export 'src/component/prop_mixins.dart';
export 'src/component/prop_typedefs.dart';
export 'src/component/pure_component_mixin.dart';
export 'src/component/_deprecated/resize_sensor.dart';
export 'src/component_declaration/annotations.dart';
export 'src/component_declaration/builder_helpers.dart' hide GeneratedErrorMessages;
export 'src/component_declaration/component_base_2.dart'
    show
        registerComponent2,
        registerAbstractComponent2,
        UiComponent2,
        UiStatefulComponent2,
        UiStatefulMixin2;
export 'src/component_declaration/built_redux_component.dart';
export 'src/component_declaration/flux_component.dart';
export 'src/component_declaration/function_component.dart' hide getFunctionName, GenericUiProps;
export 'src/util/character_constants.dart';
export 'src/util/class_names.dart';
export 'src/util/constants_base.dart';
export 'src/util/css_value_util.dart';
export 'src/util/dom_util.dart';
export 'src/util/equality.dart' show propsOrStateMapsEqual;
export 'src/util/guid_util.dart';
export 'src/util/hoc.dart';
export 'src/util/handler_chain_util.dart';
export 'src/util/key_constants.dart';
export 'src/util/map_util.dart';
export 'src/util/memo.dart';
export 'src/util/pretty_print.dart';
export 'src/util/prop_errors.dart';
export 'src/util/prop_key_util.dart';
export 'src/util/react_util.dart';
export 'src/util/react_wrappers.dart';
export 'src/util/rem_util.dart';
export 'src/util/string_util.dart';
export 'src/util/safe_render_manager/safe_render_manager.dart';
export 'src/util/test_mode.dart';
export 'src/util/typed_default_props_for.dart';
export 'src/util/validation_util.dart';
export 'src/util/context.dart';
export 'src/util/cast_ui_factory.dart';
