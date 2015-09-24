part of web_skin_dart.ui_core;

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
  Object get eventKey;

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

  /// The target for the [HitAreaMixin].
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
  ///
  /// Default: HitAreaButtonType.BUTTON
  HitAreaButtonType get type;

  /// The role for the [HitAreaMixin].
  /// This will only be applied if [domNodeName] is not set to [DomNodeName.BUTTON].
  ///
  /// _Proxies [DomProps.role]_
  ///
  /// Default: 'button'
  String get role;
}

abstract class HitAreaMixin<P extends HitAreaProps> {
  /// Standard HitAreaProps defaults.
  static const Map defaultProps = const {
    HitAreaProps.Z_$KEY__IS_ACTIVE: false,
    HitAreaProps.Z_$KEY__IS_DISABLED: false,
    HitAreaProps.Z_$KEY__IS_NAV_ITEM: false,
    HitAreaProps.Z_$KEY__IS_NAV_DROPDOWN: false,
    HitAreaProps.Z_$KEY__TYPE: HitAreaButtonType.BUTTON,
    HitAreaProps.Z_$KEY__ROLE: Role.button,
    HitAreaProps.Z_$KEY__DOM_NODE_NAME: DomNodeName.DIV
  };

  Function get ref;

  P get tProps;
  Map get props;

  String _hitAreaRef;

  Element findHitAreaDomNode() => findDomNode(ref(_hitAreaRef));

  /// Method for rendering a [HitAreaMixin] component which returns a react component instance.
  /// This should be called from within consuming component's [render] method with
  /// the props/children that should be used for rendering the [HitAreaMixin] element.
  renderHitArea(Map hitAreaPropsMap, dynamic children, {bool isNavItemHitArea: false}) {
    assert(hitAreaPropsMap != null);

    var builder;
    bool hasAnchorProps = (tProps.href != null || tProps.target != null);
    if (hasAnchorProps || tProps.domNodeName == DomNodeName.A) {
      builder = Dom.a()
        ..addProps(getPropsToForward(hitAreaPropsMap, omitReactProps: false, keysToOmit: HitAreaProps.Z_$propKeys))
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
        builder.role = tProps.role;
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
        builder.role = tProps.role;
      }
    } else if (tProps.domNodeName == DomNodeName.BUTTON) {
      builder = Dom.button()
        ..addProps(getPropsToForward(hitAreaPropsMap, omitReactProps: false, keysToOmit: HitAreaProps.Z_$propKeys))
        ..name = tProps.name
        ..type = tProps.type.typeName;
    } else {
      var domPropsMapView = domProps(hitAreaPropsMap);

      if (tProps.domNodeName == DomNodeName.LI) {
        builder = Dom.li();
      } else if (tProps.domNodeName == DomNodeName.DIV) {
        builder = Dom.div();
      }

      // Prop 'tabIndex' is required on a DIV or LI of type='button' in order to gain focus.
      // Key handlers are added to allow 'click' via keyboard spacebar and enter keys.
      builder
        ..addProps(getPropsToForward(hitAreaPropsMap, omitReactProps: false, keysToOmit: HitAreaProps.Z_$propKeys))
        ..role = tProps.role
        ..tabIndex = (domPropsMapView.tabIndex == null) ? 0 : domPropsMapView.tabIndex
        ..onKeyDown = createChainedKeyboardEventCallback(domPropsMapView.onKeyDown, _handleKeyDown)
        ..onKeyPress = createChainedKeyboardEventCallback(domPropsMapView.onKeyPress, _handleKeyPress)
        ..onKeyUp = createChainedKeyboardEventCallback(domPropsMapView.onKeyUp, _handleKeyUp);
    }

    ClassNameBuilder classes = new ClassNameBuilder.fromProps(hitAreaPropsMap)
      ..add('hitarea');

    builder
      ..id = tProps.id;

    isNavItemHitArea = (isNavItemHitArea || tProps.isNavItem || tProps.isNavDropdown);

    if (tProps.isActive) {
      builder..addProp('aria-selected', 'true');

      if (!isNavItemHitArea) {
        // If a hitarea is within a NavItem or NavDropdown, the active CSS class must be applied to the
        // parent item, not the hitarea. (it is the responsibility of the consumer/parent component to
        // do so) Otherwise, it's just a standard "toggle" button implementation, and the active CSS
        // class can go directly on the hitarea.
        classes.add('active');
      }
    }

    if (tProps.isDisabled) {
      if (builder == Dom.button()) {
        builder.disabled = true;
      } else {
        classes.add('disabled');
        builder.addProp('aria-disabled', 'true');
      }
    }

    _hitAreaRef = hitAreaPropsMap.containsKey('ref') ? hitAreaPropsMap['ref'] : 'hitarea';

    builder
      ..className = classes.toClassName()
      ..ref = _hitAreaRef
      ..onClick = _handleClick;

    return builder(children);
  }

  /// Evaluate whether any props that denote a hitarea have been set in the provided [hitAreaPropsMap].
  bool isHitArea(Map hitAreaPropsMap) {
    return hitAreaPropsMap[HitAreaProps.Z_$KEY__DOM_NODE_NAME] == DomNodeName.A
        || hitAreaPropsMap[HitAreaProps.Z_$KEY__DOM_NODE_NAME] == DomNodeName.BUTTON
        || hitAreaPropsMap[HitAreaProps.Z_$KEY__HREF] != null
        || hitAreaPropsMap[HitAreaProps.Z_$KEY__ON_CLICK] != null
        || hitAreaPropsMap[HitAreaProps.Z_$KEY__ON_SELECT] != null
        || hitAreaPropsMap[HitAreaProps.Z_$KEY__TARGET] != null;
  }

  void _handleClick(react.SyntheticEvent event) {
    if (tProps.isDisabled) {
      return;
    }

    bool preventSelect = false;
    if (tProps.onClick != null) {
      preventSelect = tProps.onClick(event) == false;
    }
    if (tProps.onSelect != null && !preventSelect) {
      tProps.onSelect(event, tProps.eventKey);
    }
  }

  void _handleKeyDown(react.SyntheticKeyboardEvent event) {
    // Prevent the page from scrolling when the space key is pressed.
    if (event.key == ' ') {
      event.preventDefault();
    }
  }

  void _handleKeyPress(react.SyntheticKeyboardEvent event) {
    if (tProps.isDisabled || event.key != 'Enter') {
      return;
    }

    findHitAreaDomNode().click();
  }

  void _handleKeyUp(react.SyntheticKeyboardEvent event) {
    if (tProps.isDisabled || event.key != ' ') {
      return;
    }

    findHitAreaDomNode().click();
  }
}

@GenerateConstants(#DomNodeName, #nodeName)
class _$template_DomNodeName {
  static const A = '<a>';
  static const BUTTON = '<button>';
  static const DIV = '<div>';
  static const LI = '<li>';
}

@GenerateConstants(#HitAreaButtonType, #typeName)
class _$template_HitAreaButtonType {
  static const BUTTON  = 'button';
  static const SUBMIT  = 'submit';
  static const RESET   = 'reset';
}
