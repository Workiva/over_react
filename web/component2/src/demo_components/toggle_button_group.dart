// Copyright 2020 Workiva Inc.
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

import 'package:over_react/over_react.dart';

import '../demo_components.dart';
part 'toggle_button_group.over_react.g.dart';

/// A specialized [ButtonGroup] component that will surround one or more child
/// [ToggleButton] components so that a single shared `ToggleButtonGroupProps.name`
/// value can be applied to the aforementioned children via [cloneElement].
///
/// __Renders HTML Markup:__
///
///     <div class="form-group {props.size.class} {props.formGroupProps.className}">
///       <label class="control-label {props.groupLabelWidth.class}" for="{state.name}">
///         {props.groupLabel}
///       </label>
///       <div class="{props.wrapperClassName} {props.groupControlsWidth.class}">
///         <div class="btn-group {props.buttonSize.class}" data-toggle="buttons" role="group">
///           {props.children}
///         </div>
///       </div>
///     </div>
///
/// See: <http://v4-alpha.getbootstrap.com/components/buttons/#checkbox-and-radio-buttons>

UiFactory<ToggleButtonGroupProps> ToggleButtonGroup = castUiFactory(_$ToggleButtonGroup); // ignore: undefined_identifier

class ToggleButtonGroupProps = UiProps with ButtonGroupProps, AbstractInputPropsMixin;

class ToggleButtonGroupState = UiState with ButtonGroupState, AbstractInputStateMixin;

@Component2(subtypeOf: ButtonGroupComponent)
class ToggleButtonGroupComponent
    extends ButtonGroupComponent<ToggleButtonGroupProps, ToggleButtonGroupState> {
  // Refs

  Map<int, dynamic> _toggleButtonRefs = <int, dynamic>{};

  /// The name to use for all children of a [ToggleButtonGroup].
  ///
  /// Attempts to use `ToggleButtonGroupProps.name` _(specified by the consumer)_, falling back to
  /// `ToggleButtonGroupState.name` _(auto-generated)_.
  String? get name => props.name ?? state.name;

  @override
  get defaultProps => (newProps()
    ..addProps(super.defaultProps)
    ..toggleType = ToggleBehaviorType.CHECKBOX
  );

  @override
  get initialState => (newState()
    ..addAll(super.initialState)
    ..name = 'toggle_button_group_' + generateGuid()
  );

  @override
  get consumedProps => propsMeta.forMixins({AbstractInputPropsMixin});

  /// The props that should be added when we clone the given [child] using
  /// [cloneElement] via [renderButton].
  @override
  ToggleButtonProps buttonPropsToAdd(ReactElement child, int index) {
    var childProps = childFactory(getProps(child));

    ButtonProps superPropsToAdd = super.buttonPropsToAdd(child, index);

    return childFactory()
      ..addProps(superPropsToAdd)
      ..name = name
      ..toggleType = props.toggleType
      ..onChange = formEventCallbacks.chain(props.onChange, _handleOnChange)
      ..value = childProps.value ?? index
      ..ref = chainRef(child, (ref) { _toggleButtonRefs[index] = ref; });
  }

  @override
  ClassNameBuilder getButtonGroupClasses() {
    return super.getButtonGroupClasses()
      ..add('btn-toggle-group');
  }

  /// The handler for when one of the children of the [ToggleButtonGroup] is changed or unchecked
  void _handleOnChange(SyntheticFormEvent event) {
    _toggleButtonRefs.values.forEach((childComponent) {
      if (childComponent is ToggleButtonComponent) childComponent.refreshState();
    });
  }

  /// The factory expected for each child of [ToggleButtonGroup].
  @override
  UiFactory<ToggleButtonProps> get childFactory => ToggleButton;
}

