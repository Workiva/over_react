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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
part 'constants.over_react.g.dart';

const String demoMountNodeSelectorPrefix = '.component-demo__mount';

/// A class of possible HTML `type` attribute values to be placed on a [Dom.button].
class ButtonType extends DebugFriendlyConstant {
  /// The DOM `<button>` `type` attribute value associated with this constant.
  final String typeName;

  const ButtonType._(String name, this.typeName) : super(name);

  /// [typeName] value: 'button'
  static const ButtonType BUTTON = ButtonType._('BUTTON', 'button');

  /// [typeName] value: 'submit'
  static const ButtonType SUBMIT = ButtonType._('SUBMIT', 'submit');

  /// [typeName] value: 'reset'
  static const ButtonType RESET  = ButtonType._('RESET', 'reset');

  @override
  String get debugDescription => 'typeName: $typeName';
}

/// Toggle button behavior options for the children of a `ToggleButtonGroup`.
class ToggleBehaviorType extends DebugFriendlyConstant {
  /// The HTML `type` attribute value that should be placed on the HTML `<input>` element rendered
  /// by a `ToggleButton`.
  final String typeName;

  const ToggleBehaviorType._(String name, this.typeName) : super(name);

  /// [typeName] value: 'radio'
  static const ToggleBehaviorType RADIO = ToggleBehaviorType._('RADIO', 'radio');

  /// [typeName] value: 'checkbox'
  static const ToggleBehaviorType CHECKBOX = ToggleBehaviorType._('CHECKBOX', 'checkbox');

  @override
  String get debugDescription => 'typeName: $typeName';
}

@PropsMixin()
abstract class _$AbstractInputPropsMixin {
  Map get props;

  /// The id for the input.
  ///
  /// If unspecified, [AbstractInputStateMixin.id] will be generated.
  ///
  /// _Proxies [DomPropsMixin.id]._
  String? get id;

  /// The HTML `name` attribute to be applied to `<input>`.
  ///
  /// If unspecified, [AbstractInputStateMixin.name] will be generated.
  ///
  /// _Proxies [DomPropsMixin.name]._
  @Accessor(keyNamespace: '')
  String? name;

  /// The value of the input. Setting this will make the input's value _controlled_; it will not update automatically in
  /// response to user input, but instead will always render the value of this prop.
  ///
  /// See: [React Controlled Components](https://facebook.github.io/react/docs/forms.html#controlled-components)
  ///
  /// _Proxies [DomPropsMixin.value]._
  @Accessor(keyNamespace: '')
  dynamic value;

  /// The type of "toggle" behavior an HTML `<input>` should exhibit:
  ///
  /// * [ToggleBehaviorType.CHECKBOX] - More than one can be active at once.
  /// * [ToggleBehaviorType.RADIO] - Only one can be active at once.
  ///
  /// Default: [ToggleBehaviorType.CHECKBOX]
  ToggleBehaviorType? toggleType;
}

@StateMixin()
abstract class _$AbstractInputStateMixin {
  Map get state;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.id] prop is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML ids are needed in inputs for proper label linking and accessibility support,
  /// so this state value ensures there's always a valid ID value to use.
  String? id;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.name] is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML names must be the same for anything that renders an HTML `<input type="radio">` element
  /// so that only one can be selected at a time.
  String? name;
}
