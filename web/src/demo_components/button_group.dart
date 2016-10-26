part of over_react.web.demo_components;

/// Groups a series of [Button]s together on a single line.
///
/// See: <http://v4-alpha.getbootstrap.com/components/button-group/>.
@Factory()
UiFactory<ButtonGroupProps> ButtonGroup;

@Props()
class ButtonGroupProps extends UiProps {
  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ButtonGroupSize size;

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  bool isVertical;
}

@State()
class ButtonGroupState extends UiState {}

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
    return renderButtonGroup(props.children);
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
}

/// Size options for a [ButtonGroup]s, with corresponding [className] values.
class ButtonGroupSize extends ClassNameConstant {
  const ButtonGroupSize._(String name, String className) : super(name, className);

  /// [className] value: 'btn-group-sm'
  static const ButtonGroupSize SMALL   = const ButtonGroupSize._('SMALL', 'btn-group-sm');

  /// [className] value: ''
  static const ButtonGroupSize DEFAULT = const ButtonGroupSize._('DEFAULT', '');

  /// [className] value: 'btn-group-lg'
  static const ButtonGroupSize LARGE   = const ButtonGroupSize._('LARGE', 'btn-group-lg');
}

/// Mapping from [ButtonSize] values to their analogous [ButtonGroupSize] values.
///
/// __Example:__
///
///     @Props()
///     class MyProps extends UiProps {
///       ButtonSize size;
///     }
///
///     @Component()
///     class MyComponent extends UiComponent<MyProps> {
///       ButtonGroupSize matchingButtonGroupSize = buttonToButtonGroupSize[props.size];
///     }
final Map<ButtonSize, ButtonGroupSize> buttonToButtonGroupSize = const <ButtonSize, ButtonGroupSize>{
  ButtonSize.SMALL:   ButtonGroupSize.SMALL,
  ButtonSize.DEFAULT: ButtonGroupSize.DEFAULT,
  ButtonSize.LARGE:   ButtonGroupSize.LARGE,
};
