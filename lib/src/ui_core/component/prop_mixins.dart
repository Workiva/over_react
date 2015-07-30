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
  /// String of space-delimited CSS classes to be added to the resultant DOM.
  ///
  /// All w_ui_platform components merge any added classes with this prop and the [classNameBlacklist] prop (see [BaseComponent.forwardingClassNameBuilder]).
  String get className;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All w_ui_platform components merge any added classes with this prop and the [className] prop (see [BaseComponent.forwardingClassNameBuilder]).
  String get classNameBlacklist;
}

/// Typed getters/setters for reserved DOM-related props.
/// To be used as a mixin for React components and builders.
@GenerateProps(#DomProps,
  keyType: TypedMapKeyType.STRING,
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

  // props specific to React.INPUT
  bool defaultChecked;
  dynamic defaultValue;

  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  bool autoFocus;
}
