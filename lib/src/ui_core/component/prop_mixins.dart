/// Various prop related mixins to be used with [ComponentDefinition] descendants.
part of web_skin_dart.ui_core;

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
  /// All web_skin_dart components merge any added classes with this prop and the [classNameBlacklist] prop (see [BaseComponent.forwardingClassNameBuilder]).
  String get className;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All web_skin_dart components merge any added classes with this prop and the [className] prop (see [BaseComponent.forwardingClassNameBuilder]).
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
    lang, list, manifest, max, maxLength, media, mediaGroup, method, min, name, open, pattern, placeholder,
    poster, preload, radioGroup, rel, role, rowSpan, sandbox, scope, scrolling, shape, sizes, spellCheck, src, srcDoc,
    srcSet, step, tabIndex, target, title, type, useMap, value, width, wmode;

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

/// Typed getters/setters for reserved DOM-related props that can be used by all UIP components.
/// To be used as a mixin for React components and builders.
@GenerateProps(#UbiquitousDomProps, keyType: TypedMapKeyType.STRING)
abstract class _$template_UbiquitousDomProps {
  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  dynamic get tabIndex;

  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  String get id;

  /// Represents advisory information about the element.
  String get title;

  /// Specifies an inline CSS style for the element
  Map<String, dynamic> get style;

  /// Callback for when the user copies the content of an element
  ClipboardEventCallback get onCopy;

  /// Callback for when the user cuts the content of an element
  ClipboardEventCallback get onCut;

  /// Callback for when the user pastes some content in an element
  ClipboardEventCallback get onPaste;

  /// Callback for when the user is pressing a key
  KeyboardEventCallback get onKeyDown;

  /// Callback for when the user presses a key
  KeyboardEventCallback get onKeyPress;

  /// Callback for when the user releases a key
  KeyboardEventCallback get onKeyUp;

  /// Callback for when an element gets focus
  FocusEventCallback get onFocus;

  /// Callback for when an element loses focus
  FocusEventCallback get onBlur;

  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  FormEventCallback get onChange;

  /// Callback for when an element gets user input
  FormEventCallback get onInput;

  /// Callback for when a form is submitted
  FormEventCallback get onSubmit;

  /// Callback for when the user clicks on an element
  MouseEventCallback get onClick;

  /// Callback for when the user right-clicks on an element to open a context menu
  MouseEventCallback get onContextMenu;

  /// Callback for when the user double-clicks on an element
  MouseEventCallback get onDoubleClick;

  /// Callback for when an element is being dragged
  MouseEventCallback get onDrag;

  /// Callback for when the user has finished dragging an element
  MouseEventCallback get onDragEnd;

  /// Callback for when the dragged element enters the drop target
  MouseEventCallback get onDragEnter;

  /// Callback for when the dragged element exits the drop target
  MouseEventCallback get onDragExit;

  /// Callback for when the dragged element leaves the drop target
  MouseEventCallback get onDragLeave;

  /// Callback for when the dragged element is over the drop target
  MouseEventCallback get onDragOver;

  /// Callback for when the user starts to drag an element
  MouseEventCallback get onDragStart;

  /// Callback for when the dragged element is dropped on the drop target
  MouseEventCallback get onDrop;

  /// Callback for when the user presses a mouse button over an element
  MouseEventCallback get onMouseDown;

  /// Callback for when the pointer is moved onto an element
  MouseEventCallback get onMouseEnter;

  /// Callback for when the pointer is moved out of an element
  MouseEventCallback get onMouseLeave;

  /// Callback for when the pointer is moving while it is over an element
  MouseEventCallback get onMouseMove;

  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  MouseEventCallback get onMouseOut;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  MouseEventCallback get onMouseOver;

  /// Callback for when a user releases a mouse button over an element
  MouseEventCallback get onMouseUp;

  /// Callback for when the touch is interrupted
  TouchEventCallback get onTouchCancel;

  /// Callback for when a finger is removed from a touch screen
  TouchEventCallback get onTouchEnd;

  /// Callback for when a finger is dragged across the screen
  TouchEventCallback get onTouchMove;

  /// Callback for when a finger is placed on a touch screen
  TouchEventCallback get onTouchStart;

  /// Callback for when an element's scrollbar is being scrolled
  UIEventCallback get onScroll;

  /// Callback for when the mouse wheel rolls up or down over an element
  WheelEventCallback get onWheel;
}
