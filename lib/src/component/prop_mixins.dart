// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Various prop related mixins to be used with [UiComponent] descendants.
library over_react.prop_mixins;

import 'package:over_react/over_react.dart' show AriaPropsMapView, AriaPropsMixin, DomProps, PropsMeta;
// Must import these consts because they are used in the transformed code.
// ignore: deprecated_member_use, unused_shown_name
import 'package:over_react/over_react.dart' show PropDescriptor, ConsumedProps, PropsMeta;
import 'package:over_react/src/component/callback_typedefs.dart';
import 'package:over_react/src/component_declaration/annotations.dart';

part 'prop_mixins.over_react.g.dart';

/// This class is only present to allow for consumers which have used the
/// --backwards-compat flag with over_react_codemod to statically analyze:
/// <https://github.com/Workiva/over_react_codemod/blob/71e5713ec6c256ddaf7c616ff9d6d26d77bb8f25/README.md#dart-1-to-dart-2-codemod>
abstract class $ReactPropsMixin {}

/// Typed getters/setters for reserved React props.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class _$ReactPropsMixin {
  Map get props;

  /// The children that were passed in to this component when it was built.
  List children;

  /// A String that differentiates a component from its siblings.
  ///
  /// When setting [key] you can use any [Object], its `toString()` method will be called when applying the value.
  ///
  /// Keys are necessary when children are dynamic, such as those passed in as a [List],
  /// but are generally not required when using variadic children.
  ///
  /// For more info, see:
  ///
  /// * <https://facebook.github.io/react/docs/multiple-components.html#children>
  /// * <https://facebook.github.io/react/docs/reconciliation.html>
  String get key        => props['key'];
  set key(Object value) => props['key'] = value == null ? null : value.toString();

  /// Either a String used to retrieve the element at a later time via [react.Component.ref],
  /// or a Function that gets called with the element when it is mounted.
  ///
  /// See: <https://facebook.github.io/react/docs/more-about-refs.html>.
  dynamic ref;
}

/// This class is only present to allow for consumers which have used the
/// --backwards-compat flag with over_react_codemod to statically analyze:
/// <https://github.com/Workiva/over_react_codemod/blob/71e5713ec6c256ddaf7c616ff9d6d26d77bb8f25/README.md#dart-1-to-dart-2-codemod>
abstract class $DomPropsMixin {}

/// Typed getters/setters for reserved DOM-related props.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class _$DomPropsMixin {
  Map get props;

  int cols, minLength, rows, size, span, start;

  num high, low, marginHeight, marginWidth, optimum;

  @Accessor(key: 'default')
  bool htmlDefault;

  @Accessor(key: 'is')
  String htmlIs;

  bool allowFullScreen, async, autoPlay, checked, controls, defer, disabled, formNoValidate, hidden, loop, multiple,
      muted, noValidate, open, readOnly, required, reversed, scoped, seamless, selected;

  Map<String, dynamic> style;

  String challenge, cite, className, controlsList, formAction, formEncType, formMethod, formTarget, headers, id,
      inputMode, integrity, keyParams, keyType, kind, nonce, srcLang, summary, title, wrap;

  dynamic accept, acceptCharset, accessKey, action, allowTransparency, alt, autoComplete, capture, cellPadding, cellSpacing,
    charSet, classID, colSpan, content, contentEditable, contextMenu, coords, crossOrigin, data, dateTime,
    dir, download, draggable, encType, form, frameBorder, height, href, hrefLang, htmlFor, httpEquiv, icon, label,
    lang, list, manifest, max, maxLength, media, mediaGroup, method, min, name, pattern, placeholder,
    poster, preload, radioGroup, rel, role, rowSpan, sandbox, scope, scrolling, shape, sizes, spellCheck, src, srcDoc,
    srcSet, step, tabIndex, target, type, useMap, value, width, wmode;

  AnimationEventCallback onAnimationEnd, onAnimationIteration, onAnimationStart;
  ClipboardEventCallback onCopy, onCut, onPaste;
  KeyboardEventCallback onKeyDown, onKeyPress, onKeyUp;
  FocusEventCallback onFocus, onBlur;
  FormEventCallback onChange, onInput, onSubmit, onReset;
  MouseEventCallback
    onClick, onContextMenu, onDoubleClick, onDrag, onDragEnd, onDragEnter, onDragExit, onDragLeave, onDragOver,
    onDragStart, onDrop, onMouseDown, onMouseEnter, onMouseLeave, onMouseMove, onMouseOut, onMouseOver, onMouseUp;
  PointerEventCallback onPointerCancel, onPointerDown, onPointerEnter, onPointerLeave, onPointerMove, onPointerOver, onPointerOut, onPointerUp;
  TouchEventCallback onTouchCancel, onTouchEnd, onTouchMove, onTouchStart;
  TransitionEventCallback onTransitionEnd;
  UIEventCallback onScroll;
  WheelEventCallback onWheel;

  ClipboardEventCallback onCopyCapture, onCutCapture, onPasteCapture;
  KeyboardEventCallback onKeyDownCapture, onKeyPressCapture, onKeyUpCapture;
  FocusEventCallback onFocusCapture, onBlurCapture;
  FormEventCallback onChangeCapture, onInputCapture, onSubmitCapture, onResetCapture;
  MouseEventCallback
    onClickCapture, onContextMenuCapture, onDoubleClickCapture, onDragCapture, onDragEndCapture, onDragEnterCapture, onDragExitCapture, onDragLeaveCapture, onDragOverCapture,
    onDragStartCapture, onDropCapture, onMouseDownCapture, onMouseEnterCapture, onMouseLeaveCapture, onMouseMoveCapture, onMouseOutCapture, onMouseOverCapture, onMouseUpCapture;
  PointerEventCallback onGotPointerCapture, onLostPointerCapture;
  TouchEventCallback onTouchCancelCapture, onTouchEndCapture, onTouchMoveCapture, onTouchStartCapture;
  UIEventCallback onScrollCapture;
  WheelEventCallback onWheelCapture;

  // props specific to React.INPUT
  bool defaultChecked;
  dynamic defaultValue;

  /// Polyfills/normalizes the `autofocus` attribute via AutoFocusMixin
  /// (mixed in by React DOM <input>, <textarea>, and <select>).
  bool autoFocus;
}

/// This class is only present to allow for consumers which have used the
/// --backwards-compat flag with over_react_codemod to statically analyze:
/// <https://github.com/Workiva/over_react_codemod/blob/71e5713ec6c256ddaf7c616ff9d6d26d77bb8f25/README.md#dart-1-to-dart-2-codemod>
abstract class $SvgPropsMixin {}

@PropsMixin(keyNamespace: '')
abstract class _$SvgPropsMixin {
  Map get props;

  @Accessor(key: 'in')
  String htmlIn;

  @Accessor(key: 'values')
  String htmlValues;

  String accumulate, additive, alignmentBaseline, allowReorder, arabicForm, attributeName, attributeType, colorInterpolationFilters,
      fillRule, filter, mask, result, strokeLinejoin, xChannelSelector, xmlns, xmlnsXlink, yChannelSelector, zoomAndPan;

  dynamic accentHeight, alphabetic, amplitude, ascent, autoReverse, azimuth, baseFrequency,
      baseProfile, baselineShift, bbox, begin, bias, by, calcMode, capHeight, clip, clipPath, clipPathUnits,
      clipRule, colorInterpolation, colorProfile, colorRendering, contentScriptType, contentStyleType,
      cursor, cx, cy, d, decelerate, descent, diffuseConstant, direction, display, divisor, dominantBaseline,
      dur, dx, dy, edgeMode, elevation, enableBackground, end, exponent, externalResourcesRequired,
      fill, fillOpacity, filterRes, filterUnits, floodColor, floodOpacity, focusable, fontFamily, fontSize,
      fontSizeAdjust, fontStretch, fontStyle, fontVariant, fontWeight, format, from, fx, fy, g1, g2, glyphName,
      glyphOrientationHorizontal, glyphOrientationVertical, glyphRef, gradientTransform, gradientUnits, hanging,
      horizAdvX, horizOriginX, ideographic, imageRendering, in2, intercept, k, k1, k2, k3, k4, kernelMatrix, kernelUnitLength,
      kerning, keyPoints, keySplines, keyTimes, lengthAdjust, letterSpacing, lightingColor, limitingConeAngle,
      local, markerEnd, markerHeight, markerMid, markerStart, markerUnits, markerWidth, maskContentUnits, maskUnits, mathematical,
      mode, numOctaves, offset, opacity, operator, order, orient, orientation, origin, overflow, overlinePosition,
      overlineThickness, paintOrder, panose1, pathLength, patternContentUnits, patternTransform, patternUnits, pointerEvents,
      points, pointsAtX, pointsAtY, pointsAtZ, preserveAlpha, preserveAspectRatio, primitiveUnits, r, radius, refX, refY,
      renderingIntent, repeatCount, repeatDur, requiredExtensions, requiredFeatures, restart, rotate, rx, ry, scale, seed,
      shapeRendering, slope, spacing, specularConstant, specularExponent, speed, spreadMethod, startOffset, stdDeviation, stemh, stemv,
      stitchTiles, stopColor, stopOpacity, strikethroughPosition, strikethroughThickness, string, stroke, strokeDasharray,
      strokeDashoffset, strokeLinecap, strokeMiterlimit, strokeOpacity, strokeWidth, surfaceScale, systemLanguage,
      tableValues, targetX, targetY, textAnchor, textDecoration, textLength, textRendering, to, transform, u1, u2, underlinePosition,
      underlineThickness, unicode, unicodeBidi, unicodeRange, unitsPerEm, vAlphabetic, vHanging, vIdeographic, vMathematical,
      vectorEffect, version, vertAdvY, vertOriginX, vertOriginY, viewBox, viewTarget, visibility, widths, wordSpacing, writingMode,
      x, x1, x2, xHeight, xlinkActuate, xlinkArcrole, xlinkHref, xlinkRole, xlinkShow, xlinkTitle, xlinkType, xmlBase;
}
/// This class is only present to allow for consumers which have used the
/// --backwards-compat flag with over_react_codemod to statically analyze:
/// <https://github.com/Workiva/over_react_codemod/blob/71e5713ec6c256ddaf7c616ff9d6d26d77bb8f25/README.md#dart-1-to-dart-2-codemod>
abstract class $UbiquitousDomPropsMixin {}

/// Typed getters/setters for reserved DOM-related props that can be used by all UIP components.
/// To be used as a mixin for React components and builders.
@PropsMixin(keyNamespace: '')
abstract class _$UbiquitousDomPropsMixin {
  Map get props;

  /// A cache for the MapView used for [aria].
  @Accessor(doNotGenerate: true)
  AriaPropsMapView _aria;

  /// A cache for the MapView used for [dom].
  @Accessor(doNotGenerate: true)
  DomProps _dom;

  /// A view into this map that can be used to access `aria-` props, for convenience.
  ///
  /// Example:
  ///
  ///     (Button()
  ///       ..aria.controls = 'my_popover'
  ///     )('Open popover')
  AriaPropsMixin get aria {
    _aria ??= new AriaPropsMapView(props);
    return _aria;
  }

  /// A view into this map that can be used to access DOM props, for convenience.
  ///
  /// Example:
  ///
  ///     (Tab()
  ///       ..dom.draggable = true
  ///     )('Untitled Document')
  DomPropsMixin get dom {
    _dom ??= new DomProps(null, props);
    return _dom;
  }

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

  /// Callback for when a CSS Animation has completed.
  ///
  /// > Related: [onAnimationIteration], [onAnimationStart], [onTransitionEnd]
  AnimationEventCallback onAnimationEnd;

  /// Callback for when an iteration of a CSS Animation ends, and another one begins.
  ///
  /// > Related: [onAnimationEnd], [onAnimationStart]
  AnimationEventCallback onAnimationIteration;

  /// Callback for when a CSS animation has started.
  ///
  /// > Related: [onAnimationEnd], [onAnimationIteration]
  AnimationEventCallback onAnimationStart;

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

  /// Callback for when a form is reset
  FormEventCallback onReset;

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

  /// Callback for when the pointing device is interrupted
  PointerEventCallback onPointerCancel;

  /// Callback for when the pointer becomes active over an element
  PointerEventCallback onPointerDown;

  /// Callback for when the pointer is moved onto an element
  PointerEventCallback onPointerEnter;

  /// Callback for when the pointer is moved out of an element
  PointerEventCallback onPointerLeave;

  /// Callback for when the pointer is moving while it is over an element
  PointerEventCallback onPointerMove;

  /// Callback for when the pointer is moved onto an element, or onto one of its children
  PointerEventCallback onPointerOver;

  /// Callback for when the pointer is moved out of an element, or out of one of its children
  PointerEventCallback onPointerOut;

  /// Callback for when the pointer becomes inactive over an element
  PointerEventCallback onPointerUp;

  /// Callback for when the touch is interrupted
  TouchEventCallback onTouchCancel;

  /// Callback for when a finger is removed from a touch screen
  TouchEventCallback onTouchEnd;

  /// Callback for when a finger is dragged across the screen
  TouchEventCallback onTouchMove;

  /// Callback for when a finger is placed on a touch screen
  TouchEventCallback onTouchStart;

  /// Callback for when a CSS transition has completed.
  ///
  /// > Related: [onAnimationEnd]
  TransitionEventCallback onTransitionEnd;

  /// Callback for when an element's scrollbar is being scrolled
  UIEventCallback onScroll;

  /// Callback for when the mouse wheel rolls up or down over an element
  WheelEventCallback onWheel;
}
