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

import '../demo_components.dart';
part 'button_group.over_react.g.dart';

/// Groups a series of [Button]s together on a single line.
///
/// See: <https://getbootstrap.com/docs/4.4/components/button-group/>.
@Factory()
UiFactory<ButtonGroupProps> ButtonGroup = _$ButtonGroup;

@Props()
class _$ButtonGroupProps extends UiProps {
  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <https://getbootstrap.com/docs/4.4/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ButtonGroupSize size;

  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ButtonSkin skin;

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <https://getbootstrap.com/docs/4.4/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  bool isVertical;
}

@State()
class _$ButtonGroupState extends UiState {}

@Component()
class ButtonGroupComponent<T extends ButtonGroupProps, S extends ButtonGroupState>
    extends UiStatefulComponent<T, S> {
  @override
  Map getDefaultProps() => (newProps()
    ..size = ButtonGroupSize.DEFAULT
    ..isVertical = false
  );

  @override
  render() {
    return renderButtonGroup(renderButtons());
  }

  ReactElement renderButtonGroup(dynamic children) {
    var componentBuilder = Dom.div();

    if (children.length > 1) {
      componentBuilder.role = Role.group;
    }

    return (componentBuilder
      ..addProps(copyUnconsumedDomProps())
      ..className = getButtonGroupClasses().toClassName())(children);
  }

  ClassNameBuilder getButtonGroupClasses() {
    return forwardingClassNameBuilder()
      ..add('btn-group', !props.isVertical)
      ..add('btn-group-vertical', props.isVertical)
      ..add(props.size.className);
  }

  /// Renders a list of [Button]s using [renderButton].
  List<ReactElement> renderButtons() {
    List<ReactElement> buttons = [];

    for (int index = 0; index < props.children.length; index++) {
      buttons.add(renderButton(props.children[index], index));
    }

    return buttons;
  }

  /// Clones the provided [child] with the props specified in [buttonPropsToAdd].
  ReactElement renderButton(dynamic child, int index) {
    if (isValidButtonChild(child)) {
      return cloneElement(child, buttonPropsToAdd(child, index));
    }

    print('invalid child');
    return child;
  }

  /// The props that should be added when we clone the given [child] using
  /// [cloneElement] via [renderButton].
  ButtonProps buttonPropsToAdd(dynamic child, int index) {
    var childProps = childFactory(getProps(child));
    var childKey = getInstanceKey(child);

    return childFactory()
      ..skin = props.skin ?? childProps.skin
      ..key = childKey ?? index;
  }

  /// Returns whether the provided [child] can be cloned using [cloneElement].
  bool isValidButtonChild(dynamic child) {
    var isCloneable = false;
    if (isValidElement(child)) {
      if (!isComponentOfType(child, childFactory)) {
        assert(ValidationUtil.warn(
            'An unexpected child type was found within this component.',
            this
        ));
      }

      isCloneable = true;
    } else if (child != null) {
      assert(ValidationUtil.warn(
          'You are not using a valid ReactElement.',
          this
      ));
    }

    return isCloneable;
  }

  /// The factory expected for each child of [ButtonGroup].
  ///
  /// _The factory accept [ButtonProps] as its generic parameter._
  UiFactory<ButtonProps> get childFactory => Button;
}

/// Size options for a [ButtonGroup]s, with corresponding [className] values.
class ButtonGroupSize extends ClassNameConstant {
  const ButtonGroupSize._(String name, String className) : super(name, className);

  /// [className] value: 'btn-group-sm'
  static const ButtonGroupSize SMALL   = ButtonGroupSize._('SMALL', 'btn-group-sm');

  /// [className] value: ''
  static const ButtonGroupSize DEFAULT = ButtonGroupSize._('DEFAULT', '');

  /// [className] value: 'btn-group-lg'
  static const ButtonGroupSize LARGE   = ButtonGroupSize._('LARGE', 'btn-group-lg');
}

/// Mapping from [ButtonSize] values to their analogous [ButtonGroupSize] values.
///
/// __Example:__
///
///     mixin MyProps on UiProps {
///       ButtonSize size;
///     }
///
///     class MyComponent extends UiComponent<MyProps> {
///       ButtonGroupSize matchingButtonGroupSize = buttonToButtonGroupSize[props.size];
///     }
const Map<ButtonSize, ButtonGroupSize> buttonToButtonGroupSize = {
  ButtonSize.SMALL:   ButtonGroupSize.SMALL,
  ButtonSize.DEFAULT: ButtonGroupSize.DEFAULT,
  ButtonSize.LARGE:   ButtonGroupSize.LARGE,
};

