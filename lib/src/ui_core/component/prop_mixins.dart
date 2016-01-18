/// Various prop related mixins to be used with [ComponentDefinition] descendants.
part of web_skin_dart.ui_core;

/// Typed getters/setters for reserved React props.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class ReactPropsMixin {
  Map get props;

  /// The children that were passed in to this component when it was built.
  List children;

  /// A String that differentiates a component from its siblings.
  ///
  /// When setting [key] you can use any [Object], its `toString()` method will be called when appling the value.
  ///
  /// Keys are necessary when children are dynamic, such as those passed in as a [List],
  /// but are generally not required when using variadic children.
  ///
  /// For more info, see:
  ///
  /// * <https://facebook.github.io/react/docs/multiple-components.html#children>
  /// * <https://facebook.github.io/react/docs/reconciliation.html>
  String get key         => props['key'];
  set key(dynamic value) => props['key'] = value.toString();

  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  dynamic ref;
}

/// Typed getters/setters for props related to CSS class manipulation, and used by all UIP components.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class CssClassPropsMixin {
  Map get props;

  /// String of space-delimited CSS classes to be added to the resultant DOM.
  ///
  /// All web_skin_dart components merge any added classes with this prop and the [classNameBlacklist] prop (see [BaseComponent.forwardingClassNameBuilder]).
  String className;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All web_skin_dart components merge any added classes with this prop and the [className] prop (see [BaseComponent.forwardingClassNameBuilder]).
  String classNameBlacklist;
}

/// Typed getters/setters for reserved DOM-related props.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class DomPropsMixin {
  Map get props;

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

/// Typed getters/setters for reserved DOM-related props that can be used by all UIP components.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class UbiquitousDomPropsMixin {
  Map get props;

  /// Whether the element if focusable.
  /// Must be a valid integer or String of valid integer.
  dynamic tabIndex;

  /// Unique identifier.
  /// Must be unique amongst all the ids, and contain at least one character.
  String id;

  /// Represents advisory information about the element.
  String title;

  /// An inline CSS style for the element.
  ///
  ///     ..style = {
  ///       'width': '${state.progress * 100}%',
  ///       'display': state.isHidden ? 'none' : '',
  ///     }
  ///
  /// See: <https://facebook.github.io/react/tips/inline-styles.html>
  Map<String, dynamic> style;

  /// Callback for when the user copies the content of an element
  ClipboardEventCallback onCopy;

  /// Callback for when the user cuts the content of an element
  ClipboardEventCallback onCut;

  /// Callback for when the user pastes some content in an element
  ClipboardEventCallback onPaste;

  /// Callback for when the user is pressing a key
  KeyboardEventCallback onKeyDown;

  /// Callback for when the user presses a key
  KeyboardEventCallback onKeyPress;

  /// Callback for when the user releases a key
  KeyboardEventCallback onKeyUp;

  /// Callback for when an element gets focus
  FocusEventCallback onFocus;

  /// Callback for when an element loses focus
  FocusEventCallback onBlur;

  /// Callback for  when the content of a form element, the selection, or the checked state have changed (for <input>,
  /// <keygen>, <select>, and <textarea>)
  FormEventCallback onChange;

  /// Callback for when an element gets user input
  FormEventCallback onInput;

  /// Callback for when a form is submitted
  FormEventCallback onSubmit;

  /// Callback for when the user clicks on an element
  MouseEventCallback onClick;

  /// Callback for when the user right-clicks on an element to open a context menu
  MouseEventCallback onContextMenu;

  /// Callback for when the user double-clicks on an element
  MouseEventCallback onDoubleClick;

  /// Callback for when an element is being dragged
  MouseEventCallback onDrag;

  /// Callback for when the user has finished dragging an element
  MouseEventCallback onDragEnd;

  /// Callback for when the dragged element enters the drop target
  MouseEventCallback onDragEnter;

  /// Callback for when the dragged element exits the drop target
  MouseEventCallback onDragExit;

  /// Callback for when the dragged element leaves the drop target
  MouseEventCallback onDragLeave;

  /// Callback for when the dragged element is over the drop target
  MouseEventCallback onDragOver;

  /// Callback for when the user starts to drag an element
  MouseEventCallback onDragStart;

  /// Callback for when the dragged element is dropped on the drop target
  MouseEventCallback onDrop;

  /// Callback for when the user presses a mouse button over an element
  MouseEventCallback onMouseDown;

  /// Callback for when the pointer is moved onto an element
  MouseEventCallback onMouseEnter;

  /// Callback for when the pointer is moved out of an element
  MouseEventCallback onMouseLeave;

  /// Callback for when the pointer is moving while it is over an element
  MouseEventCallback onMouseMove;

  /// Callback for when a user moves the mouse pointer out of an element, or out of one of its children
  MouseEventCallback onMouseOut;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  MouseEventCallback onMouseOver;

  /// Callback for when a user releases a mouse button over an element
  MouseEventCallback onMouseUp;

  /// Callback for when the touch is interrupted
  TouchEventCallback onTouchCancel;

  /// Callback for when a finger is removed from a touch screen
  TouchEventCallback onTouchEnd;

  /// Callback for when a finger is dragged across the screen
  TouchEventCallback onTouchMove;

  /// Callback for when a finger is placed on a touch screen
  TouchEventCallback onTouchStart;

  /// Callback for when an element's scrollbar is being scrolled
  UIEventCallback onScroll;

  /// Callback for when the mouse wheel rolls up or down over an element
  WheelEventCallback onWheel;
}
