part of w_ui_platform.ui_core;

/// Mixin for component definitions that provides hitarea related props.
/// To use:
/// - add [HitAreaProps] mixin class to component definition.
/// - add [HitAreaMixin] mixin class to component class.
/// - add defaults to getDefaultProps method of component class using [HitAreaMixin.defaultProps]
///   ..addProps(HitAreaMixin.defaultProps)
/// - call the inherited `renderHitArea` method with `render` method of your component.
@GenerateProps(#HitAreaProps)
abstract class _$template_HitAreaProps {
  /// Callback triggered by click events on the hitarea
  DomEventCallback get onClick;
  /// Callback triggered when a selectable hitarea item is clicked.
  /// Valid callbacks must be of type [OnSelectCallback], which include the `eventKey`
  /// of the selected item along with the optional `href` and `target` props.
  HitAreaSelectCallback get onSelect;
  /// Used alongside `props.onSelect` for basic controller behavior of clickable elements
  dynamic get eventKey;
  /// DomProp
  String get href;
  /// DomProp
  String get target;
  /// Use to explicitly define the node name you want to see in the rendered DOM
  DomNodeName get domNodeName;
  /// DomProp
  String get id;
  /// DomProp
  String get name;
  /// Attribute to support the role classification of elements.
  /// primarily used for the purposes of accessibility
  String get role;
  /// DomProp
  String get type;
  /// Whether the hitarea is active
  bool get isActive;
  /// Whether the hitarea is disabled.
  bool get isDisabled;
  /// Whether the button is a nav-item.
  bool get isNavItem;
  /// Whether the button is a nav-dropdown.
  bool get isNavDropdown;
}

/// Props used and set in [HitareaMixin.getValidatedHitAreaProps].
@GenerateProps(#_ValidatedHitareaProps)
abstract class $template__ValidatedHitareaProps {
  /// Renderer determined by getValidatedHitAreaProps used to render the hitarea.
  HitAreaRenderer get renderer;
  /// TODO: leftover from input component support?
  String get inputRef;
  /// TODO: leftover from input component support?
  String get inputId;
  /// TODO: leftover from WSR port?
  String get buttonRef;
  /// TODO: leftover from WSR port?
  bool get navItem;
  /// TODO: leftover from WSR port?
  bool get navDropdown;
}

class _ValidatedHitareaPropsMapView extends MapView with DomProps, ReactProps, _ValidatedHitareaProps {
  _ValidatedHitareaPropsMapView(Map map) : super(map);
  Map get props => this;
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

  bool isClickable() => !tProps.isDisabled && (tProps.href != null ||
      tProps.target != null ||
      tProps.name != null || //TODO: should name be here??
      tProps.onClick != null ||
      tProps.onSelect != null ||
      DomNodeName.isClickable(tProps.domNodeName));

  _ValidatedHitareaPropsMapView getValidatedHitAreaProps(Map hitAreaPropsMap, dynamic children,
      [bool isNavItemHitArea = false]) {
    assert(hitAreaPropsMap != null);
    HitAreaRenderer renderer = null;
    var hitAreaProps = new _ValidatedHitareaPropsMapView(new Map.from(hitAreaPropsMap));
    hitAreaProps.id = tProps.id;
    hitAreaProps.role = tProps.role;

    ClassNameBuilder classes = new ClassNameBuilder.fromProps(hitAreaProps);
    classes.add('hitarea');

    // resolve isNavItemHitArea
    isNavItemHitArea = (isNavItemHitArea || tProps.isNavItem || tProps.isNavDropdown);
    hitAreaProps.navItem = isNavItemHitArea;
    hitAreaProps.navDropdown = tProps.isNavDropdown;


    //
    // set active props
    //

    bool renderActive = tProps.isActive ||
                        hitAreaProps.checked == true ||
                        hitAreaProps.defaultChecked == true;

    // set active class
    if (renderActive) {
      hitAreaProps['aria-selected'] = 'true';

      if (!isNavItemHitArea) {
        // If a hitarea is within a NavItem or MenuItem, the active CSS class must be applied to the
        // parent item, not the hitarea. (it is the responsibility of the consumer/parent component to
        // do so) Otherwise, it's just a standard "toggle" button implementation, and the active CSS
        // class can go directly on the hitarea.
        classes.add('active');
      }
    }

    //
    // <a>
    //
    bool hasAnchorProps = (tProps.href != null || tProps.target != null);
    if (hasAnchorProps || tProps.domNodeName == DomNodeName.A) {
      renderer = HitAreaRenderer.ANCHOR;
      hitAreaProps
        ..href = tProps.href
        ..target = tProps.target
        ..name = tProps.name;

      if (tProps.domNodeName == DomNodeName.A) {
        if (!hasAnchorProps) {
          assert(ValidationUtil.warn(
              'You are explicitly requesting that a `<a>` element is rendered via your React component, '
              'but you have no `href`, `target` or `name` props defined, meaning its usage is as a button, '
              'triggering in-page functionality. It is recommended that you omit the `domNodeName` prop so '
              'that a `<button>` element will be rendered instead.'));
          // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
          hitAreaProps.role = 'button';
        }
      } else if (hasAnchorProps && tProps.domNodeName != null) {
        assert(ValidationUtil.warn(
            'You are explicitly requesting that a `<${tProps.domNodeName.name}>` element is rendered '
            'via your React component, but you also have declared either an `href` or `target` prop '
            '(or both). An `<a>` will be rendered since `href` and `target` are both invalid '
            'properties for a `<${tProps.domNodeName.name}>`.'));
      }
      if (tProps.href == '#') {
        assert(ValidationUtil.warn(
            'You are using an `href` attribute with a value of `#`. To trigger in-page functionality, '
            'it is recommended that you omit the `href` attribute altogether, so that this React '
            'component will produce a `<button>` element instead.'));
        // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
        hitAreaProps.role = 'button';
      }
      // strip `type` prop if exists (checked mode only)
      assert(_validateTypeForNonFormElem(
          tProps.type, hitAreaProps, DomNodeName.A.name));
    }

    //
    // <input>
    //
    else if (tProps.type == ClickableDomInputType.CHECKBOX ||
        tProps.type == ClickableDomInputType.RADIO) {
      renderer = HitAreaRenderer.INPUT;

      hitAreaProps
        ..type = tProps.type
        ..role = 'button'
        ..inputRef = tProps.type
        ..buttonRef = tProps.type + '_button'
        // set defaultChecked based on resolved `renderActive` value.
        ..defaultChecked = renderActive;

      // remove checked prop if set (transferred to defaultChecked)
      if (hitAreaProps.containsKey('checked') && hitAreaProps.checked != renderActive) {
        hitAreaProps.remove('checked');
      }

      if (tProps.id == null) {
        assert(ValidationUtil.warn(
            '${tProps.type} buttons require a unique `id` to function correctly.'));
        hitAreaProps.inputId = null;
      } else {
        hitAreaProps.inputId = '${tProps.id}_${tProps.type}';
      }

      if (tProps.type == ClickableDomInputType.RADIO && tProps.name == null) {
        assert(ValidationUtil.warn(
            'radio buttons require a `name` prop value that matches all the other '
            'radio buttons in the group in order to function correctly. WSR will '
            'apply a default name of "undefined_radio_group".'));
        hitAreaProps.name = 'undefined_radio_group';
      } else {
        hitAreaProps.name = tProps.name;
      }
    }

    //
    // <input> that will be rendered as a <button>
    // since it is not a checkbox or radio
    //
    else if (tProps.domNodeName == DomNodeName.INPUT) {
      assert(ValidationUtil.warn(
          'You are explicitly requesting that a `<input>` element is rendered via your '
          'React component, but you have not set the `type` prop to either `checkbox` or '
          '`radio`, which are the only two type values that require the use of the '
          '`<input>` element. A `<button>` will be rendered instead.'));
      renderer = HitAreaRenderer.BUTTON;
      assert(tProps.type == ClickableDomInputType.BUTTON
             || tProps.type == ClickableDomInputType.SUBMIT
             || tProps.type == ClickableDomInputType.RESET);
      hitAreaProps.type = tProps.type;
    }

    //
    // <div>
    //
    else if (tProps.domNodeName == DomNodeName.DIV) {
      renderer = HitAreaRenderer.DIV;
      hitAreaProps.role = 'button';
      assert(_validateTypeForNonFormElem(
          tProps.type, hitAreaProps, DomNodeName.DIV.name));
    }

    //
    // <button> (default)
    //
    else {
      renderer = HitAreaRenderer.BUTTON;
      hitAreaProps.type = tProps.type == null ? ClickableDomInputType.BUTTON : tProps.type;
    }

    //
    // set disabled props
    //
    bool renderDisabled = tProps.isDisabled;
    // set render props
    if (renderDisabled) {
      if (renderer == HitAreaRenderer.ANCHOR) {
        classes.add('disabled');
        hitAreaProps['aria-disabled'] = 'true';
      } else {
        hitAreaProps.disabled = true;
      }
    }

    // concatenate classes and assign className
    hitAreaProps.className = classes.toClassName();

    // assign renderer
    hitAreaProps.renderer = renderer;

    // use 'hitarea' as ref unless one has already been set
    if (!hitAreaProps.containsKey('ref')) {
      hitAreaProps.ref = 'hitarea';
    }

    return hitAreaProps;
  }

  /// Internal method which renders the actual hitarea DOM element.
  _renderHitAreaComponent(HitAreaRenderer renderer, Map props, dynamic children) {
    assert(props != null);
    DomComponentDefinition componentBuilder = renderer.componentBuilderFactory();
    componentBuilder.addProps(
        getPropsToForward(props, omitReactProps: false, keysToOmit: HitAreaProps.Z_$propKeys)
    );

    if (isClickable()) {
      componentBuilder.onClick = handleClick;
    }

    return componentBuilder(children);
  }

  /// Primary method for rendering a hitarea component which returns a react component instance.
  /// This should be called from within consuming component's [render] method with
  /// the props/children that should be used for rendering the hitarea element.
  renderHitArea(Map hitAreaPropsMap, dynamic children,
      [bool isNavItemHitArea = false]) {
    // consumer must pass initial props
    assert(hitAreaPropsMap != null);
    // validate and supplement props
    var hitAreaProps =
        getValidatedHitAreaProps(hitAreaPropsMap, children, isNavItemHitArea);
    // extract renderer from props
    assert(hitAreaProps.renderer != null);
    var renderer = hitAreaProps.remove(_ValidatedHitareaProps.Z_$KEY__RENDERER);
    return _renderHitAreaComponent(renderer, hitAreaProps, children);
  }

  /// Click handler for the hitarea.
  void handleClick(react.SyntheticEvent event) {
    // prevent click events if disabled
    if (tProps.isDisabled) {
      return;
    }
    // flag to prevent select if onClick handler returns `false`
    bool preventSelect = false;
    // call consumer onClick callback if provided
    if (tProps.onClick != null) {
      assert(tProps.onClick is DomEventCallback);
      preventSelect = tProps.onClick(event) == false;
    }
    // call consumer onSelect callback if provided
    if (tProps.onSelect != null && !preventSelect) {
      assert(tProps.onSelect is HitAreaSelectCallback);
      tProps.onSelect(tProps.eventKey, tProps.href, tProps.target);
    }
  }

  /// Static utility used to strip `type` prop from non `<input>` elements.
  static bool _validateTypeForNonFormElem(
      String type, Map props, String nodeName) {
    if (type != null) {
      assert(ValidationUtil.warn(
          'The `type` prop is not valid on an `<${nodeName}>` element. Try using a `<button>` instead.'));
      props['data-wsr-invalid-type'] = type;
      new DomPropsMapView(props).type = null;
    }
    return true;
  }
}

class DomNodeName {
  final String name;
  final Function renderer;
  final bool _isClickable;

  const DomNodeName._internal(this.name, this.renderer, this._isClickable);

  static const DomNodeName A = const DomNodeName._internal('a', Dom.a, true);
  static const DomNodeName BUTTON =
      const DomNodeName._internal('button', Dom.button, true);
  static const DomNodeName DIV =
      const DomNodeName._internal('div', Dom.div, false);
  static const DomNodeName INPUT =
      const DomNodeName._internal('input', Dom.input, true);

  static bool isClickable(DomNodeName t) => t != null ? t._isClickable : false;
}

/// Rendering options for a hitarea element, specifying its DOM representation.
class HitAreaRenderer {
  final DomComponentDefinitionFactory componentBuilderFactory;

  HitAreaRenderer._internal(
      DomComponentDefinitionFactory this.componentBuilderFactory);

  static final HitAreaRenderer ANCHOR = new HitAreaRenderer._internal(Dom.a);
  static final HitAreaRenderer BUTTON = new HitAreaRenderer._internal(Dom.button);
  static final HitAreaRenderer DIV = new HitAreaRenderer._internal(Dom.div);
  static final HitAreaRenderer INPUT = new HitAreaRenderer._internal(Dom.input);
}

class ClickableDomInputType {
  static const String BUTTON = 'button';
  static const String CHECKBOX = 'checkbox';
  static const String RADIO = 'radio';
  static const String SUBMIT = 'submit';
  static const String RESET = 'reset';
}
