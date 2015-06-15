/// Various prop related mixins to be used with [ComponentDefinition] descendants.
part of w_ui_platform.ui_core;

/// Typed getters/setters for reserved React props.
/// To be used as a mixin for React components and builders.
@GenerateProps(#ReactProps, keyType: TypedMapKeyType.STRING)
abstract class _$template_ReactProps {
  List get children;
  String get key;
  dynamic get ref;
}

/// Typed getters/setters for props related to CSS class manipulation, and used by all UIP components.
/// To be used as a mixin for React components and builders.
@GenerateProps(#CssClassProps, keyType: TypedMapKeyType.STRING)
abstract class _$template_CssClassProps {
  /// Map of class names to be added/omitted (true/false) to the resultant DOM.
  /// Used within components with [w_ui_platform.class_names.classNames].
  /// Precedence: props.classMap, props.className, added component props
  @deprecated
  Map<String, bool> get classMap;

  /// Class name to be added to the resultant DOM.
  /// Used within components with [w_ui_platform.class_names.classNames].
  /// Precedence: props.classMap, props.className, added component props
  @deprecated
  String get className;

  String get classNameBlacklist;
}

/// Typed getters/setters for reserved DOM-related props.
/// To be used as a mixin for React components and builders.
@GenerateProps(#DomProps,
  keyType: TypedMapKeyType.STRING,
  enumerateKeys: false,
  fromSyntheticGetters: true
)
abstract class _$template_DomProps {
  int cols, rows, size, span, start;

  bool allowFullScreen, async, autoPlay, checked, controls, defer, disabled, formNoValidate, hidden, loop, multiple,
    muted, noValidate, readOnly, required, seamless, selected;

  Map<String, dynamic> style;

  dynamic accept, acceptCharset, accessKey, action, allowTransparency, alt, autoComplete, cellPadding, cellSpacing,
    charSet, classID, className, colSpan, content, contentEditable, contextMenu, coords, crossOrigin, data, dateTime,
    dir, download, draggable, encType, form, frameBorder, height, href, hrefLang, htmlFor, httpEquiv, icon, id, label,
    lang, list, manifest, max, maxLength, media, mediaGroup, method, min, name, open, pattern, placeholder, poster,
    preload, radioGroup, rel, role, rowSpan, sandbox, scope, scrolling, shape, sizes, spellCheck, src, srcDoc, srcSet,
    step, tabIndex, target, title, type, useMap, value, width, wmode;

  ClipboardEventCallback onCopy, onCut, onPaste;
  KeyboardEventCallback onKeyDown, onKeyPress, onKeyUp;
  FocusEventCallback onFocus, onBlur;
  FormEventCallback onChange, onInput, onSubmit;
  MouseEventCallback
    onClick, onContextMenu, onDoubleClick, onDrag, onDragEnd, onDragEnter, onDragExit, onDragLeave, onDragOver,
    onDragStart, onDrop, onMouseDown, onMouseEnter, onMouseLeave, onMouseMove, onMouseOut, onMouseOver, onMouseUp;
  TouchEventCallback onTouchCancel, onTouchEnd, onTouchMove, onTouchStart;
  UIEventCallback onScroll;
  WheelEventCallback onWheel;
}

class DomPropsMapView extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}
