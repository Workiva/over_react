part of over_react.web.demo_components;

/// Nest one or more `Button` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ButtonProps> Button = ([Map backingProps]) => new _$ButtonPropsImpl(backingProps);

@Props()
class ButtonProps extends UiProps {    /* GENERATED CONSTANTS */ static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys); static const PropDescriptor _$prop__skin = const PropDescriptor(_$key__skin), _$prop__size = const PropDescriptor(_$key__size), _$prop__isActive = const PropDescriptor(_$key__isActive), _$prop__isDisabled = const PropDescriptor(_$key__isDisabled), _$prop__isBlock = const PropDescriptor(_$key__isBlock), _$prop__href = const PropDescriptor(_$key__href), _$prop__target = const PropDescriptor(_$key__target), _$prop__type = const PropDescriptor(_$key__type); static const List<PropDescriptor> $props = const [_$prop__skin, _$prop__size, _$prop__isActive, _$prop__isDisabled, _$prop__isBlock, _$prop__href, _$prop__target, _$prop__type]; static const String _$key__skin = 'ButtonProps.skin', _$key__size = 'ButtonProps.size', _$key__isActive = 'ButtonProps.isActive', _$key__isDisabled = 'disabled', _$key__isBlock = 'ButtonProps.isBlock', _$key__href = 'href', _$key__target = 'target', _$key__type = 'ButtonProps.type'; static const List<String> $propKeys = const [_$key__skin, _$key__size, _$key__isActive, _$key__isDisabled, _$key__isBlock, _$key__href, _$key__target, _$key__type]; 
  /// The skin / "context" for the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#examples>.
  ///
  /// Default: [ButtonSkin.PRIMARY]
  ButtonSkin get skin => props[_$key__skin];  set skin(ButtonSkin value) => props[_$key__skin] = value;

  /// The size of the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#sizes>.
  ///
  /// Default: [ButtonSize.DEFAULT]
  ButtonSize get size => props[_$key__size];  set size(ButtonSize value) => props[_$key__size] = value;

  /// Whether the [Button] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#active-state>
  ///
  /// Default: false
  bool get isActive => props[_$key__isActive];  set isActive(bool value) => props[_$key__isActive] = value;

  /// Whether the [Button] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#disabled-state>
  ///
  /// Default: false
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled => props[_$key__isDisabled];  set isDisabled(bool value) => props[_$key__isDisabled] = value;

  /// Whether the [Button] is a block level button -- that which spans the full
  /// width of its parent.
  ///
  /// Default: false
  bool get isBlock => props[_$key__isBlock];  set isBlock(bool value) => props[_$key__isBlock] = value;

  /// The HTML `href` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  @Accessor(keyNamespace: '')
  String get href => props[_$key__href];  set href(String value) => props[_$key__href] = value;

  /// The HTML `target` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  @Accessor(keyNamespace: '')
  String get target => props[_$key__target];  set target(String value) => props[_$key__target] = value;

  /// The HTML `type` attribute value for the [Button] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [href] is not set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ButtonType get type => props[_$key__type];  set type(ButtonType value) => props[_$key__type] = value;
}

@Component()
class ButtonComponent extends UiComponent<ButtonProps> with _$ButtonComponentImplMixin {
  @override
  Map getDefaultProps() => (newProps()
    ..skin = ButtonSkin.PRIMARY
    ..size = ButtonSize.DEFAULT
    ..isActive = false
    ..isDisabled = false
    ..isBlock = false
    ..type = ButtonType.BUTTON
  );

  @override
  render() {
    BuilderOnlyUiFactory<DomProps> factory = _buttonDomNodeFactory;

    return (factory()
      ..addProps(copyUnconsumedDomProps())
      ..className = _getButtonClasses().toClassName()
      ..href = props.href
      ..target = props.target
      ..type = _isAnchorLink ? null : props.type.typeName
      ..disabled = _isAnchorLink ? null : props.isDisabled
      ..addProps(ariaProps()
        ..disabled = _isAnchorLink ? props.isDisabled : null
      )
    )(props.children);
  }

  ClassNameBuilder _getButtonClasses() {
    return forwardingClassNameBuilder()
      ..add('btn')
      ..add('btn-block', props.isBlock)
      ..add('active', props.isActive)
      ..add('disabled', props.isDisabled)
      ..add(props.skin.className)
      ..add(props.size.className);
  }

  BuilderOnlyUiFactory<DomProps> get _buttonDomNodeFactory => _isAnchorLink ? Dom.a : Dom.button;

  bool get _isAnchorLink => props.href != null;
}

/// Contextual skin options for a [Button] component.
class ButtonSkin extends ClassNameConstant {
  const ButtonSkin._(String name, String className) : super(name, className);

  /// [className] value: 'btn-primary'
  static const ButtonSkin PRIMARY =
      const ButtonSkin._('PRIMARY', 'btn-primary');

  /// [className] value: 'btn-secondary'
  static const ButtonSkin SECONDARY =
      const ButtonSkin._('SECONDARY', 'btn-secondary');

  /// [className] value: 'btn-danger'
  static const ButtonSkin DANGER =
      const ButtonSkin._('DANGER', 'btn-danger');

  /// [className] value: 'btn-success'
  static const ButtonSkin SUCCESS =
      const ButtonSkin._('SUCCESS', 'btn-success');

  /// [className] value: 'btn-warning'
  static const ButtonSkin WARNING =
      const ButtonSkin._('WARNING', 'btn-warning');

  /// [className] value: 'btn-info'
  static const ButtonSkin INFO =
      const ButtonSkin._('INFO', 'btn-info');

  /// [className] value: 'btn-link'
  static const ButtonSkin LINK =
      const ButtonSkin._('LINK', 'btn-link');

  /// [className] value: 'btn-outline-primary'
  static const ButtonSkin PRIMARY_OUTLINE =
      const ButtonSkin._('PRIMARY_OUTLINE', 'btn-outline-primary');

  /// [className] value: 'btn-outline-secondary'
  static const ButtonSkin SECONDARY_OUTLINE =
      const ButtonSkin._('SECONDARY_OUTLINE', 'btn-outline-secondary');

  /// [className] value: 'btn-outline-danger'
  static const ButtonSkin DANGER_OUTLINE =
      const ButtonSkin._('DANGER_OUTLINE', 'btn-outline-danger');

  /// [className] value: 'btn-outline-success'
  static const ButtonSkin SUCCESS_OUTLINE =
      const ButtonSkin._('SUCCESS_OUTLINE', 'btn-outline-success');

  /// [className] value: 'btn-outline-warning'
  static const ButtonSkin WARNING_OUTLINE =
      const ButtonSkin._('WARNING_OUTLINE', 'btn-outline-warning');

  /// [className] value: 'btn-outline-info'
  static const ButtonSkin INFO_OUTLINE =
      const ButtonSkin._('INFO_OUTLINE', 'btn-outline-info');
}

/// Size options for a [Button] component.
class ButtonSize extends ClassNameConstant {
  const ButtonSize._(String name, String className) : super(name, className);

  /// [className] value: ''
  static const ButtonSize DEFAULT =
      const ButtonSize._('DEFAULT', '');

  /// [className] value: 'btn-lg'
  static const ButtonSize LARGE =
      const ButtonSize._('LARGE', 'btn-lg');

  /// [className] value: 'btn-sm'
  static const ButtonSize SMALL =
      const ButtonSize._('SMALL', 'btn-sm');
}



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
//   GENERATED IMPLEMENTATIONS
//

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonComponentFactory = registerComponent(() => new ButtonComponent(),
    builderFactory: Button,
    componentClass: ButtonComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Button'
);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$ButtonPropsImpl extends ButtonProps {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$ButtonPropsImpl(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $ButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ButtonComponentImplMixin {
  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from ButtonProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [ButtonProps.$consumedProps];
  @override
  ButtonProps typedPropsFactory(Map backingMap) => new _$ButtonPropsImpl(backingMap);

}

//
//   END GENERATED IMPLEMENTATIONS
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

