/// Various prop related mixins to be used with [ComponentDefinition] descendants.
part of w_ui_platform.ui_core;

/// Typed getters/setters for reserved React props.
/// To be used as a mixin for React components and builders.
abstract class ReactProps {
  Map get props;

  List get children     => props['children'];

  String get key        => props['key'];
  set key(String value) => props['key'] = value;

  dynamic get ref        => props['ref'];
  set ref(dynamic value) => props['ref'] = value;
}

/// Typed getters/setters for props related to CSS class manipulation, and used by all UIP components.
/// To be used as a mixin for React components and builders.
abstract class CssClassProps {
  Map get props;

  /// Map of class names to be added/omitted (true/false) to the resultant DOM.
  /// Used within components with [w_ui_platform.class_names.classNames].
  /// Precedence: props.classMap, props.className, added component props
  @deprecated
  Map<String, bool> get classMap        => props[CssClassPropsKey.CLASS_MAP];
  @deprecated
  set classMap(Map<String, bool> value) => props[CssClassPropsKey.CLASS_MAP] = value;

  /// Class name to be added to the resultant DOM.
  /// Used within components with [w_ui_platform.class_names.classNames].
  /// Precedence: props.classMap, props.className, added component props
  String get className                  => props[CssClassPropsKey.CLASS_NAME];
  set className(String value)           => props[CssClassPropsKey.CLASS_NAME] = value;

  String get classNameBlacklist         => props[CssClassPropsKey.CLASS_NAME_BLACKLIST];
  set classNameBlacklist(String value)  => props[CssClassPropsKey.CLASS_NAME_BLACKLIST] = value;
}

abstract class CssClassPropsKey {
  static const String CLASS_MAP = 'classMap';
  static const String CLASS_NAME = 'className';
  static const String CLASS_NAME_BLACKLIST = 'classNameBlacklist';
}

/// Typed getters/setters for reserved DOM-related props.
/// To be used as a mixin for React components and builders.
abstract class DomProps {
  Map get props;

  // Universal attributes
  Map<String, dynamic> get style        => props['style'];
  set style(Map<String, dynamic> value) => props['style'] = value;
  String get id                => props['id'];
  set id(String value)         => props['id'] = value;
  String get className         => props['className'];
  set className(String value)  => props['className'] = value;
  dynamic get tabIndex         => props['tabIndex'];
  set tabIndex(dynamic value)  => props['tabIndex'] = value;
  bool get disabled            => props['disabled'];
  set disabled(bool value)     => props['disabled'] = value;
  String get title             => props['title'];
  set title(String value)      => props['title'] = value;

  // Event handlers
  Function get onClick         => props['onClick'];
  set onClick(Function value)  => props['onClick'] = value;
  Function get onChange        => props['onChange'];
  set onChange(Function value) => props['onChange'] = value;

  // Input elements
  String get htmlFor           => props['htmlFor'];
  set htmlFor(String value)    => props['htmlFor'] = value;
  String get type              => props['type'];
  set type(String value)       => props['type'] = value;
  bool get checked             => props['checked'];
  set checked(bool value)      => props['checked'] = value;
  bool get defaultChecked             => props['defaultChecked'];
  set defaultChecked(bool value)      => props['defaultChecked'] = value;
  String get href              => props['href'];
  set href(String value)       => props['href'] = value;
  String get target            => props['target'];
  set target(String value)     => props['target'] = value;
  String get name            => props['name'];
  set name(String value)     => props['name'] = value;

  // Accessibility
  String get role              => props['role'];
  set role(String value)       => props['role'] = value;
  String get scope             => props['scope'];
  set scope(String value)      => props['scope'] = value;
}

class DomPropsMapView extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}
