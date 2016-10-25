part of over_react.web.demo_components;

/// Nest one or more `Button` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<ButtonProps> Button;

@Props()
class ButtonProps extends UiProps {
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

@Component()
class ButtonComponent extends UiComponent<ButtonProps> {
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
      const ButtonSkin._('PRIMARY', 'btn-outline-primary');

  /// [className] value: 'btn-outline-secondary'
  static const ButtonSkin SECONDARY_OUTLINE =
      const ButtonSkin._('SECONDARY', 'btn-outline-secondary');

  /// [className] value: 'btn-outline-danger'
  static const ButtonSkin DANGER_OUTLINE =
      const ButtonSkin._('DANGER', 'btn-outline-danger');

  /// [className] value: 'btn-outline-success'
  static const ButtonSkin SUCCESS_OUTLINE =
      const ButtonSkin._('SUCCESS', 'btn-outline-success');

  /// [className] value: 'btn-outline-warning'
  static const ButtonSkin WARNING_OUTLINE =
      const ButtonSkin._('WARNING', 'btn-outline-warning');

  /// [className] value: 'btn-outline-info'
  static const ButtonSkin INFO_OUTLINE =
      const ButtonSkin._('INFO', 'btn-outline-info');
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
