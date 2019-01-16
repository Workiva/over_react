part of over_react.web.demo_components;

/// Nest one or more `Button` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
// ignore: undefined_identifier
UiFactory<ButtonProps> Button = _$Button;

@Props()
class _$ButtonProps extends UiProps {
  /// The skin / "context" for the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#examples>.
  ///
  /// Default: [ButtonSkin.PRIMARY]
  ButtonSkin skin;

  /// The size of the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#sizes>.
  ///
  /// Default: [ButtonSize.DEFAULT]
  ButtonSize size;

  /// Whether the [Button] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#active-state>
  ///
  /// Default: false
  bool isActive;

  /// Whether the [Button] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#disabled-state>
  ///
  /// Default: false
  @Accessor(key: 'disabled', keyNamespace: '')
  bool isDisabled;

  /// Whether the [Button] is a block level button -- that which spans the full
  /// width of its parent.
  ///
  /// Default: false
  bool isBlock;

  /// The HTML `href` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  @Accessor(keyNamespace: '')
  String href;

  /// The HTML `target` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  @Accessor(keyNamespace: '')
  String target;

  /// The HTML `type` attribute value for the [Button] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [href] is not set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ButtonType type;
}

@State()
class _$ButtonState extends UiState {}

@Component()
class ButtonComponent<T extends ButtonProps, S extends ButtonState> extends UiStatefulComponent<T, S> {
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
    return renderButton(props.children);
  }

  ReactElement renderButton(dynamic children) {
    BuilderOnlyUiFactory<DomProps> factory = _buttonDomNodeFactory;

    return (factory()
      ..addProps(copyUnconsumedDomProps())
      ..className = getButtonClasses().toClassName()
      ..href = props.href
      ..target = props.target
      ..type = _type
      ..disabled = _isAnchorLink ? null : props.isDisabled
      ..addProps(ariaProps()
        ..disabled = _isAnchorLink ? props.isDisabled : null
      )
    )(children);
  }

  ClassNameBuilder getButtonClasses() {
    return forwardingClassNameBuilder()
      ..add('btn')
      ..add('btn-block', props.isBlock)
      ..add('active', _isActive)
      ..add('disabled', props.isDisabled)
      ..add(props.skin.className)
      ..add(props.size.className);
  }

  BuilderOnlyUiFactory<DomProps> get _buttonDomNodeFactory => _isAnchorLink ? Dom.a : Dom.button;

  bool get _isAnchorLink => props.href != null;

  bool get _isActive => props.isActive;

  String get _type => _isAnchorLink ? null : props.type.typeName;
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

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class ButtonProps extends _$ButtonProps with _$ButtonPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForButtonProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class ButtonState extends _$ButtonState with _$ButtonStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForButtonState;
}
