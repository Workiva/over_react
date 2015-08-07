part of w_ui_platform.ui_core;

/// Mixin for component definitions that provides [HitAreaProps].
/// To use:
/// - Add [HitAreaProps] mixin class to component definition.
/// - Add [HitAreaMixin] mixin class to component class.
/// - Add default [HitAreaProps] to getDefaultProps method of component class using [HitAreaMixin.defaultProps]:
///   ..addProps(HitAreaMixin.defaultProps)
/// - Call the inherited `renderHitArea` method within the `render` method of your component.
@GenerateProps(#HitAreaProps)
abstract class _$template_HitAreaProps {
  /// Callback triggered by click events on the [HitAreaMixin].
  /// To prevent [onSelect] have this function return false.
  MouseEventCallback get onClick;

  /// Callback triggered when a selectable [HitAreaMixin] item is clicked.
  /// To prevent this from being called return false from [onClick].
  EventKeyCallback get onSelect;

  /// Used alongside [onSelect] for basic controller behavior.
  dynamic get eventKey;

  /// Use to explicitly define the node name you want to see in the rendered DOM.
  /// We recommend against setting this unless you know what you are doing.
  ///
  /// Default: DomNodeName.DIV
  DomNodeName get domNodeName;

  /// Whether the [HitAreaMixin] is active.
  ///
  /// Default: false
  bool get isActive;

  /// Whether the [HitAreaMixin] is disabled.
  /// If disabled [HitAreaMixin] will not fire click events.
  ///
  /// Default: false
  bool get isDisabled;

  /// Whether the [HitAreaMixin] is a [NavItem].
  ///
  /// Default: false
  bool get isNavItem;

  /// Whether the [HitAreaMixin] is a [NavDropdown].
  ///
  /// Default: false
  bool get isNavDropdown;

  // --------------------------------------------------------------------------
  // Proxied [DomProps].
  // --------------------------------------------------------------------------

  /// The href for the [HitAreaMixin].
  /// If set [HitAreaMixin] will render as [Dom.a()].
  ///
  /// _Proxies [DomProps.href]_
  String get href;

  /// The targer for the [HitAreaMixin].
  /// If set [HitAreaMixin] will render as [Dom.a()].
  ///
  /// _Proxies [DomProps.target]_
  String get target;

  /// The id for the [HitAreaMixin].
  ///
  /// _Proxies [DomProps.id]_
  String get id;

  /// The name for the [HitAreaMixin].
  /// Is not applied if a [Dom.div()] is rendered.
  ///
  /// _Proxies [DomProps.name]_
  String get name;

  /// The type for the [HitAreaMixin].
  /// This will only be applied if [domNodeName] is set to [DomNodeName.BUTTON].
  ///
  /// _Proxies [DomProps.type]_
  HitAreaButtonType get type;
}

abstract class HitAreaMixin<P extends HitAreaProps> {
  /// Standard HitAreaProps defaults.
  static const Map defaultProps = const {
    HitAreaProps.Z_$KEY__IS_ACTIVE: false,
    HitAreaProps.Z_$KEY__IS_DISABLED: false,
    HitAreaProps.Z_$KEY__IS_NAV_ITEM: false,
    HitAreaProps.Z_$KEY__IS_NAV_DROPDOWN: false,
  };

  P get tProps;
  Map get props;

  /// Method for rendering a [HitAreaMixin] component which returns a react component instance.
  /// This should be called from within consuming component's [render] method with
  /// the props/children that should be used for rendering the [HitAreaMixin] element.
  renderHitArea(Map hitAreaPropsMap, dynamic children, {bool isNavItemHitArea: false}) {
    assert(hitAreaPropsMap != null);

    DomComponentDefinition renderer;
    bool hasAnchorProps = (tProps.href != null || tProps.target != null);
    if (hasAnchorProps || tProps.domNodeName == DomNodeName.A) {
      renderer = Dom.a()
        ..href = tProps.href
        ..target = tProps.target
        ..name = tProps.name;

      if (tProps.domNodeName == DomNodeName.A && !hasAnchorProps) {
        assert(ValidationUtil.warn(
          'You are explicitly requesting that a `<a>` element is rendered via your React component, '
          'but you have no `href`, `target` or `name` props defined, meaning its usage is as a button, '
          'triggering in-page functionality. It is recommended that you omit the `domNodeName` prop so '
          'that a `<button>` element will be rendered instead.'));
        // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
        renderer.role = 'button';
      } else if (hasAnchorProps && tProps.domNodeName != null) {
        assert(ValidationUtil.warn(
          'You are explicitly requesting that a `<${tProps.domNodeName.nodeName}>` element is rendered '
          'via your React component, but you also have declared either an `href` or `target` prop '
          '(or both). An `<a>` will be rendered since `href` and `target` are both invalid '
          'properties for a `${tProps.domNodeName.nodeName}`.'));
      }

      if (tProps.href == '#') {
        assert(ValidationUtil.warn(
          'You are using an `href` attribute with a value of `#`. To trigger in-page functionality, '
          'it is recommended that you omit the `href` attribute altogether, so that this React '
          'component will produce a `<button>` element instead.'));
        // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
        renderer.role = 'button';
      }
    } else if (tProps.domNodeName == DomNodeName.BUTTON) {
      renderer = Dom.button()
        ..name = tProps.name
        ..type = tProps.type == null ? 'button' : tProps.type.typeName;
    } else {
      renderer = Dom.div()
        ..role = 'button';
    }

    ClassNameBuilder classes = new ClassNameBuilder.fromProps(hitAreaPropsMap)
      ..add('hitarea');

    renderer
      ..id = tProps.id;

    isNavItemHitArea = (isNavItemHitArea || tProps.isNavItem || tProps.isNavDropdown);

    if (tProps.isActive) {
      renderer..addProp('aria-selected', 'true');

      if (!isNavItemHitArea) {
        // If a hitarea is within a NavItem or MenuItem, the active CSS class must be applied to the
        // parent item, not the hitarea. (it is the responsibility of the consumer/parent component to
        // do so) Otherwise, it's just a standard "toggle" button implementation, and the active CSS
        // class can go directly on the hitarea.
        classes.add('active');
      }
    }

    if (tProps.isDisabled) {
      if (renderer == Dom.button()) {
        renderer.disabled = true;
      } else {
        classes.add('disabled');
        renderer.addProp('aria-disabled', 'true');
      }
    }

    renderer
      ..addProps(getPropsToForward(props, omitReactProps: false, keysToOmit: HitAreaProps.Z_$propKeys))
      ..className = classes.toClassName()
      ..ref = hitAreaPropsMap.containsKey('ref') ? hitAreaPropsMap['ref'] : 'hitarea'
      ..onClick = _handleClick;

    return renderer(children);
  }

  _handleClick(react.SyntheticEvent event) {
    if (tProps.isDisabled) {
      return;
    }

    bool preventSelect = false;
    if (tProps.onClick != null) {
      preventSelect = tProps.onClick(event) == false;
    }
    if (tProps.onSelect != null && !preventSelect) {
      tProps.onSelect(event, tProps.eventKey, tProps.href, tProps.target);
    }
  }
}

@GenerateConstants(#DomNodeName, #nodeName)
class _$template_DomNodeName {
  static const A = '<a>';
  static const BUTTON = '<button>';
  static const DIV = '<div>';
}

@GenerateConstants(#HitAreaButtonType, #typeName)
class _$template_HitAreaButtonType {
  static const BUTTON  = 'button';
  static const SUBMIT  = 'submit';
  static const RESET   = 'reset';
}
