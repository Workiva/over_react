part of w_ui_platform.ui_core;

enum _HitAreaPropsKeys {
  DOM_NODE_NAME,
  EVENT_KEY,
  HREF,
  IS_ACTIVE,
  IS_DISABLED,
  IS_NAV_ITEM,
  IS_NAV_DROPDOWN,
  IS_SELECTED,
  ID,
  NAME,
  ON_CLICK,
  ON_SELECT,
  ROLE,
  TARGET,
  TYPE,
}

/// Method signature for callbacks assignable to
typedef bool SyntheticEventCallback(react.SyntheticEvent event);

/// Method signature for onSelect callbacks
typedef bool OnSelectCallback(dynamic eventKey, String href, String target);

/// Mixin for component definitions that provides hitarea related props.
/// To use:
/// - add [HitAreaProps] to component definition
/// - add [HitAreaMixin] to component class
/// - add defaults to getDefaultProps method of component class using getDefaults() call:
///   ..addProps(HitAreaProps.getDefaults())
abstract class HitAreaProps {

  Map get props;

  // TODO: Doc string
  SyntheticEventCallback get onClick => props[_HitAreaPropsKeys.ON_CLICK];
  set onClick(SyntheticEventCallback value) => props[_HitAreaPropsKeys.ON_CLICK] = value;

  // TODO: Fix doc string below
  /// Will return a callback containing the `eventKey` of the selected item
  /// along with an optional `href` and `target` prop (if present)
  OnSelectCallback get onSelect => props[_HitAreaPropsKeys.ON_SELECT];
  set onSelect(OnSelectCallback value) => props[_HitAreaPropsKeys.ON_SELECT] = value;

  /// Used alongside `props.onSelect` for basic controller behavior of clickable elements
  dynamic get eventKey => props[_HitAreaPropsKeys.EVENT_KEY];
  set eventKey(dynamic value) => props[_HitAreaPropsKeys.EVENT_KEY] = value;

  /// DomProp
  String get href => props[_HitAreaPropsKeys.HREF];
  set href(String value) => props[_HitAreaPropsKeys.HREF] = value;

  /// DomProp
  String get target => props[_HitAreaPropsKeys.TARGET];
  set target(String value) => props[_HitAreaPropsKeys.TARGET] = value;

  /// Use to explicitly define the node name you want to see in the rendered DOM
  DomNodeName get domNodeName => props[_HitAreaPropsKeys.DOM_NODE_NAME];
  set domNodeName(DomNodeName value) => props[_HitAreaPropsKeys.DOM_NODE_NAME] = value;

  /// prop: id
  String get id => props[_HitAreaPropsKeys.ID];
  set id(String value) => props[_HitAreaPropsKeys.ID] = value;

  /// DomProp
  String get name => props[_HitAreaPropsKeys.NAME];
  set name(String value) => props[_HitAreaPropsKeys.NAME] = value;

  /// Attribute to support the role classification of elements.
  /// primarily used for the purposes of accessibility
  String get role => props[_HitAreaPropsKeys.ROLE];
  set role(String value) => props[_HitAreaPropsKeys.ROLE] = value;

  /// prop: type
  String get type => props[_HitAreaPropsKeys.TYPE];
  set type(String value) => props[_HitAreaPropsKeys.TYPE] = value;

  /// Whether the hitarea is active
  bool get isActive => props[_HitAreaPropsKeys.IS_ACTIVE]; //TODO: == true
  set isActive(bool value) => props[_HitAreaPropsKeys.IS_ACTIVE] = value;

  /// Whether the hitarea is disabled.
  bool get isDisabled => props[_HitAreaPropsKeys.IS_DISABLED];
  set isDisabled(bool value) => props[_HitAreaPropsKeys.IS_DISABLED] = value;

  /// prop: isSelected
  bool get isSelected => props[_HitAreaPropsKeys.IS_SELECTED];
  set isSelected(bool value) => props[_HitAreaPropsKeys.IS_SELECTED] = value;

  /// Whether the button is a nav-item.
  bool get isNavItem => props[_HitAreaPropsKeys.IS_NAV_ITEM];
  set isNavItem(bool value) => props[_HitAreaPropsKeys.IS_NAV_ITEM] = value;

  /// Whether the button is a nav-dropdown.
  bool get isNavDropdown => props[_HitAreaPropsKeys.IS_NAV_DROPDOWN];
  set isNavDropdown(bool value) => props[_HitAreaPropsKeys.IS_NAV_DROPDOWN] = value;

  /// Returns a [Map] instance containing key/value pairs for the standard HitAreaProps defaults.
  static Map getDefaults() {
    var props = {};

    props[_HitAreaPropsKeys.IS_ACTIVE] = false;
    props[_HitAreaPropsKeys.IS_DISABLED] = false;
    props[_HitAreaPropsKeys.IS_NAV_DROPDOWN] = false;
    props[_HitAreaPropsKeys.IS_NAV_ITEM] = false;

    return props;
  }

}

abstract class HitAreaMixin<P extends HitAreaProps> {

  P get tProps;
  Map get props;

  bool isClickable() => !(tProps.isDisabled == true) &&
                        (tProps.href != null ||
                         tProps.target != null ||
                         tProps.name != null || //TODO: should name be here??
                         tProps.onClick != null ||
                         tProps.onSelect != null ||
                         DomNodeName.isClickable(tProps.domNodeName));

  Map getValidatedHitAreaProps(Map hitAreaProps, dynamic children, [bool isNavItemHitArea = false]) {
    assert(hitAreaProps != null);
    HitAreaRenderer renderer = null;
    hitAreaProps = MapUtil.copyMap(hitAreaProps);
    hitAreaProps['id'] = tProps.id;
    hitAreaProps['role'] = tProps.role;

    Map classes = mergeClassDefinitions([hitAreaProps['classMap'], hitAreaProps['className']]);
    classes['hitarea'] = true;

    // resolve isNavItemHitArea
    isNavItemHitArea = (isNavItemHitArea == true ||
                        tProps.isNavItem == true ||
                        tProps.isNavDropdown == true);
    classes['navItem'] = isNavItemHitArea;
    classes['navDropdown'] = tProps.isNavDropdown == true;

    //
    // <a>
    //
    var hasAnchorProps = (tProps.href != null || tProps.target != null);
    if (hasAnchorProps || tProps.domNodeName == DomNodeName.A) {
      renderer = HitAreaRenderer.ANCHOR;
      hitAreaProps['href'] = tProps.href;
      hitAreaProps['target'] = tProps.target;
      hitAreaProps['name'] = tProps.name;

      if (tProps.domNodeName == DomNodeName.A) {
        if (!hasAnchorProps) {
          assert(ValidationUtil.warn('You are explicitly requesting that a `<a>` element is rendered via your React component, but you have no `href`, `target` or `name` props defined, meaning its usage is as a button, triggering in-page functionality. It is recommended that you omit the `domNodeName` prop so that a `<button>` element will be rendered instead.'));
          // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
          hitAreaProps['role'] = 'button';
        }
      }
      else if (hasAnchorProps && tProps.domNodeName != null) {
          assert(ValidationUtil.warn('You are explicitly requesting that a `<${tProps.domNodeName.name}>` element is rendered via your React component, but you also have declared either an `href` or `target` prop (or both). An `<a>` will be rendered since `href` and `target` are both invalid properties for a `<${tProps.domNodeName.name}>`.'));
      }
      if (tProps.href == '#') {
        assert(ValidationUtil.warn('You are using an `href` attribute with a value of `#`. To trigger in-page functionality, it is recommended that you omit the `href` attribute altogether, so that this React component will produce a `<button>` element instead.'));
        // Signify that this anchor triggers in-page functionality despite using an `<a>` tag.
        hitAreaProps['role'] = 'button';
      }
      // strip `type` prop if exists (checked mode only)
      assert(_validateTypeForNonFormElem(tProps.type, hitAreaProps, DomNodeName.A.name));
    }

    //
    // <input>
    //
    else if (tProps.type == DomInputType.CHECKBOX || tProps.type == DomInputType.RADIO) {
      renderer = HitAreaRenderer.INPUT;
      hitAreaProps['type'] = tProps.type;
      hitAreaProps['role'] = 'button';
      hitAreaProps['inputRef'] = tProps.type;
      hitAreaProps['buttonRef'] = tProps.type + '_button';

      bool renderChecked = tProps.isSelected == true ||
                           hitAreaProps['checked'] == true ||
                           hitAreaProps['defaultChecked'] == true;

      // set defaultChecked based on resolved `renderChecked` value.
      hitAreaProps['defaultChecked'] = renderChecked;
      hitAreaProps.remove('checked');

      if (tProps.id == null) { // TODO: Add 'id' to inherited props for all components
        assert(ValidationUtil.warn('${tProps.type} buttons require a unique `id` to function correctly.'));
        hitAreaProps['inputId'] = null;
      }
      else {
        hitAreaProps['inputId'] = "${tProps.id}_${tProps.type}";
      }

      if (tProps.type == DomInputType.RADIO && tProps.name == null) {
        assert(ValidationUtil.warn('radio buttons require a `name` prop value that matches all the other radio buttons in the group in order to function correctly. WSR will apply a default name of "undefined_radio_group".'));
        hitAreaProps['name'] = 'undefined_radio_group';
      }
      else {
        hitAreaProps['name'] = tProps.name;
      }

      // set checked for active inputs
      // TODO: Not sure if this still makes sense to do? HitareaMixin.jsx:140
      if (tProps.isActive == true && !renderChecked) {
        hitAreaProps['defaultChecked'] = true;
      }
    }

    //
    // <input> that will be rendered as a <button>
    // since it is not a checkbox or radio
    //
    else if (tProps.domNodeName == DomNodeName.INPUT) {
      assert(ValidationUtil.warn('You are explicitly requesting that a `<input>` element is rendered via your React component, but you have not set the `type` prop to either `checkbox` or `radio`, which are the only two type values that require the use of the `<input>` element. A `<button>` will be rendered instead.'));
      renderer = HitAreaRenderer.BUTTON;
      hitAreaProps['type'] = tProps.type;
    }

    //
    // <div>
    //
    else if (tProps.domNodeName == DomNodeName.DIV) {
      renderer = HitAreaRenderer.DIV;
      hitAreaProps['role'] = 'button';
      assert(_validateTypeForNonFormElem(tProps.type, hitAreaProps, DomNodeName.DIV.name));
    }

    //
    // <button> (default)
    //
    else {
      renderer = HitAreaRenderer.BUTTON;
      hitAreaProps['type'] = tProps.type == null ? 'button' : tProps.type;
    }

    //
    // set active props
    //
    var renderActive = tProps.isActive == true || hitAreaProps['checked'] == true || hitAreaProps['defaultChecked'] == true;
    // check for 'active' class being set without isActive prop
    if (!renderActive && classes['active'] == true) {
      assert(ValidationUtil.warn('`active` className was detected, but the `isActive` prop is `false`.  Should use the `isActive` prop instead.'));
      renderActive = true;
    }
    // set active class
    if (renderActive) {
      hitAreaProps['aria-selected'] = 'true';

      if (!isNavItemHitArea) {
        classes['active'] = true;
      }
    }

    //
    // set disabled props
    //
    var renderDisabled = tProps.isDisabled == true;
    // Check first to see if they are trying to disable without using the correct disabled prop
    if (classes['disabled'] == true) {
      if (renderer == HitAreaRenderer.ANCHOR)
        assert(ValidationUtil.warn('You are trying to make an element look disabled by adding the "disabled" CSS class. This will make it appear disabled but may not prevent click events from firing in most browsers.'));
      renderDisabled = true;
    }
    // set render props
    if (renderDisabled) {
      if (renderer == HitAreaRenderer.ANCHOR) {
        assert(ValidationUtil.warn('You are trying to make an <a> HTML element look disabled. This will make it appear disabled but will not prevent click events from firing in most browsers.'));
        classes['disabled'] = true;
      } else {
        hitAreaProps['disabled'] = true;
      }
      hitAreaProps['aria-disabled'] = 'true'; // TODO: Do we want this for all types of elements?
    }

    // concatenate classes and assign className
    hitAreaProps['className'] = classNames(classes);

    // assign renderer
    hitAreaProps['renderer'] = renderer;

    return hitAreaProps;
  }

  /// Main function that renders the hitarea item with the given props
  renderHitAreaComponent(HitAreaRenderer renderer, Map props, dynamic children) {
    assert(props != null);
    DomComponentDefinition componentBuilder = renderer.componentBuilderFactory();
    componentBuilder.addProps(props);

    if (isClickable()) {
      componentBuilder.onClick = handleClick;
    }

    return componentBuilder(children);
  }

  renderHitArea(Map hitAreaProps, dynamic children, [bool isNavItemHitArea = false]) {
    // consumer must pass initial props
    assert(hitAreaProps != null);
    // validate and supplement props
    hitAreaProps = getValidatedHitAreaProps(hitAreaProps, children, isNavItemHitArea);
    // extract renderer from props
    assert(hitAreaProps['renderer'] != null);
    var renderer = hitAreaProps.remove('renderer');
    return renderHitAreaComponent(renderer, hitAreaProps, children);
  }

    /// Click handler for the hitarea.
  void handleClick(react.SyntheticEvent event) {
    // prevent click events if disabled
    if (tProps.isDisabled == true) {
      return;
    }
    // flag to prevent select if onClick handler returns `false`
    bool preventSelect = false;
    // call consumer onClick callback if provided
    if (tProps.onClick != null) {
      assert(tProps.onClick is SyntheticEventCallback);
      preventSelect = tProps.onClick(event) == false;
    }
    // call consumer onSelect callback if provided
    if (tProps.onSelect != null && !preventSelect) {
      assert(tProps.onSelect is OnSelectCallback);
      tProps.onSelect(tProps.eventKey, tProps.href, tProps.target);
    }
  }

  /// Static utility used to strip `type` prop from non `<input>` elements.
  static bool _validateTypeForNonFormElem(String type, Map props, String nodeName) {
    if (type != null) {
      assert(ValidationUtil.warn('The `type` prop is not valid on an `<${nodeName}>` element. Try using a `<button>` instead.'));
      props['data-wsr-invalid-type'] = type;
      props['type'] = null;
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
  static const DomNodeName BUTTON = const DomNodeName._internal('button', Dom.button, true);
  static const DomNodeName DIV = const DomNodeName._internal('div', Dom.div, false);
  static const DomNodeName INPUT = const DomNodeName._internal('input', Dom.input, true);

  static bool isClickable(DomNodeName t) => t != null ? t._isClickable : false;
}

/// Rendering options for a [ListGroupItem], specifying its DOM representation.
class HitAreaRenderer {
  final DomComponentDefinitionFactory componentBuilderFactory;

  HitAreaRenderer._internal(DomComponentDefinitionFactory this.componentBuilderFactory);

  static final HitAreaRenderer ANCHOR = new HitAreaRenderer._internal(Dom.a);
  static final HitAreaRenderer BUTTON = new HitAreaRenderer._internal(Dom.button);
  static final HitAreaRenderer DIV = new HitAreaRenderer._internal(Dom.div);
  static final HitAreaRenderer INPUT = new HitAreaRenderer._internal(Dom.input);
}


class DomInputType {
  static const String BUTTON = 'button';
  static const String CHECKBOX = 'checkbox';
  static const String RADIO = 'radio';
  static const String TEXT = 'text';
  static const String SUBMIT = 'submit';
  static const String RESET = 'reset';
}

class DomNodeRole {
  static const String BUTTON = 'button';
  static const String PRESENTATION = 'presentation';
}