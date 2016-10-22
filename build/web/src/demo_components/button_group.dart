part of over_react.web.demo_components;

/// Groups a series of [Button]s together on a single line.
///
/// See: <http://v4-alpha.getbootstrap.com/components/button-group/>.
@Factory()
UiFactory<ButtonGroupProps> ButtonGroup = ([Map backingProps]) => new _$ButtonGroupPropsImpl(backingProps);

@Props()
class ButtonGroupProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__size = const PropDescriptor(_$key__size), _$prop__skin = const PropDescriptor(_$key__skin), _$prop__isVertical = const PropDescriptor(_$key__isVertical); static const List<PropDescriptor> $props = const [_$prop__size, _$prop__skin, _$prop__isVertical]; static const String _$key__size = 'ButtonGroupProps.size', _$key__skin = 'ButtonGroupProps.skin', _$key__isVertical = 'ButtonGroupProps.isVertical'; static const List<String> $propKeys = const [_$key__size, _$key__skin, _$key__isVertical]; 
  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ButtonGroupSize get size => props[_$key__size];  set size(ButtonGroupSize value) => props[_$key__size] = value;

  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ButtonSkin get skin => props[_$key__skin];  set skin(ButtonSkin value) => props[_$key__skin] = value;

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  bool get isVertical => props[_$key__isVertical];  set isVertical(bool value) => props[_$key__isVertical] = value;
}

@Component()
class ButtonGroupComponent<T extends ButtonGroupProps, S extends UiState>
    extends UiStatefulComponent<T, S> with _$ButtonGroupComponentImplMixin {
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

    if (props.children.length > 1) {
      componentBuilder.role = Role.group;
    }

    return (componentBuilder
      ..addProps(copyUnconsumedDomProps())
      ..className = getButtonGroupClasses().toClassName())(props.children);
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



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonGroupComponentFactory = registerComponent(() => new ButtonGroupComponent(),
    builderFactory: ButtonGroup,
    componentClass: ButtonGroupComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ButtonGroup'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$ButtonGroupPropsImpl extends ButtonGroupProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$ButtonGroupPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $ButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonGroupProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ButtonGroupComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ButtonGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [ButtonGroupProps.$consumedProps];
  @override
  ButtonGroupProps typedPropsFactory(Map backingMap) => new _$ButtonGroupPropsImpl(backingMap);

}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

