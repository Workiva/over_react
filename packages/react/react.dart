// Copyright (c) 2013-2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A Dart library for building UI using ReactJS.
library react;

import 'package:react/src/typedefs.dart';

/// Top-level ReactJS [Component class](https://facebook.github.io/react/docs/react-component.html)
/// which provides the [ReactJS Component API](https://facebook.github.io/react/docs/react-component.html#reference)
abstract class Component {
  /// A private field that backs [props], which is exposed via getter/setter so
  /// it can be overridden in strong mode.
  ///
  /// Necessary since the `@virtual` annotation within the meta package
  /// [doesn't work for overriding fields](https://github.com/dart-lang/sdk/issues/27452).
  ///
  /// TODO: Switch back to a plain field once this issue is fixed.
  Map _props;

  /// A private field that backs [state], which is exposed via getter/setter so
  /// it can be overridden in strong mode.
  ///
  /// Necessary since the `@virtual` annotation within the meta package
  /// [doesn't work for overriding fields](https://github.com/dart-lang/sdk/issues/27452).
  ///
  /// TODO: Switch back to a plain field once this issue is fixed.
  Map _state = {};

  /// A private field that backs [ref], which is exposed via getter/setter so
  /// it can be overridden in strong mode.
  ///
  /// Necessary since the `@virtual` annotation within the meta package
  /// [doesn't work for overriding fields](https://github.com/dart-lang/sdk/issues/27452).
  ///
  /// TODO: Switch back to a plain field once this issue is fixed.
  Ref _ref;

  /// ReactJS [Component] props.
  ///
  /// Related: [state]
  Map get props => _props;
  set props(Map value) => _props = value;

  /// ReactJS [Component] state.
  ///
  /// Related: [props]
  Map get state => _state;
  set state(Map value) => _state = value;

  /// A function that returns a component reference:
  ///
  /// * [Component] if it is a Dart component.
  /// * `Element` _(DOM node)_ if it is a React DOM component.
  Ref get ref => _ref;
  set ref(Ref value) => _ref = value;

  dynamic _jsRedraw;

  dynamic _jsThis;

  List _setStateCallbacks = [];

  List _transactionalSetStateCallbacks = [];

  /// The List of callbacks to be called after the component has been updated from a call to [setState].
  List get setStateCallbacks => _setStateCallbacks;

  /// The List of transactional `setState` callbacks to be called before the component updates.
  List get transactionalSetStateCallbacks => _transactionalSetStateCallbacks;

  /// The JavaScript [`ReactComponent`](https://facebook.github.io/react/docs/top-level-api.html#reactdom.render)
  /// instance of this `Component` returned by [render].
  dynamic get jsThis => _jsThis;

  /// Allows the [ReactJS `displayName` property](https://facebook.github.io/react/docs/react-component.html#displayname)
  /// to be set for debugging purposes.
  String get displayName => runtimeType.toString();

  /// Bind the value of input to [state[key]].
  bind(key) => [state[key], (value) => setState({key: value})];

  initComponentInternal(props, _jsRedraw, [Ref ref, _jsThis]) {
    this._jsRedraw = _jsRedraw;
    this.ref = ref;
    this._jsThis = _jsThis;
    _initProps(props);
  }

  _initProps(props) {
    this.props = new Map.from(props);
    this.nextProps = this.props;
  }

  initStateInternal() {
    this.state = new Map.from(getInitialState());
    // Call `transferComponentState` to get state also to `_prevState`
    transferComponentState();
  }

  /// Private reference to the value of [state] from the previous render cycle.
  ///
  /// Useful for ReactJS lifecycle methods [shouldComponentUpdate], [componentWillUpdate] and [componentDidUpdate].
  Map _prevState = null;

  /// Private reference to the value of [state] for the upcoming render cycle.
  ///
  /// Useful for ReactJS lifecycle methods [shouldComponentUpdate], [componentWillUpdate] and [componentDidUpdate].
  Map _nextState = null;

  /// Public getter for [_prevState].
  Map get prevState => _prevState;

  /// Public getter for [_nextState].
  ///
  /// If `null`, then [_nextState] is equal to [state] - which is the value that will be returned.
  Map get nextState => _nextState == null ? state : _nextState;

  /// Reference to the value of [props] for the upcoming render cycle.
  ///
  /// Useful for ReactJS lifecycle methods [shouldComponentUpdate], [componentWillReceiveProps], and [componentWillUpdate].
  Map nextProps;

  /// Transfers `Component` [_nextState] to [state], and [state] to [_prevState].
  ///
  /// This is the only way to set the value of [_prevState].
  void transferComponentState() {
    _prevState = state;
    if (_nextState != null) {
      state = _nextState;
    }
    _nextState = new Map.from(state);
  }

  /// Force a call to [render] by calling [setState], which effectively "redraws" the `Component`.
  ///
  /// Optionally accepts a callback that gets called after the component updates.
  ///
  /// [A.k.a "forceUpdate"](https://facebook.github.io/react/docs/react-component.html#forceupdate)
  void redraw([callback()]) {
    setState({}, callback);
  }

  /// Set [_nextState] to provided [newState] value and force a re-render.
  ///
  /// Optionally accepts a callback that gets called after the component updates.
  ///
  /// Also allows [newState] to be used as a transactional `setState` callback.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#setstate>
  void setState(dynamic newState, [callback()]) {
    if (newState is Map) {
      _nextState.addAll(newState);
    } else if (newState is _TransactionalSetStateCallback) {
      _transactionalSetStateCallbacks.add(newState);
    } else if (newState != null) {
      throw new ArgumentError('setState expects its first parameter to either be a Map or a Function that accepts two parameters.');
    }

    if (callback != null) _setStateCallbacks.add(callback);

    _jsRedraw();
  }

  /// Set [_nextState] to provided [newState] value and force a re-render.
  ///
  /// Optionally accepts a callback that gets called after the component updates.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#setstate>
  void replaceState(Map newState, [callback()]) {
    Map nextState = newState == null ? {} : new Map.from(newState);
    _nextState = nextState;
    if (callback != null) _setStateCallbacks.add(callback);

    _jsRedraw();
  }

  /// ReactJS lifecycle method that is invoked once, both on the client and server, immediately before the initial
  /// rendering occurs.
  ///
  /// If you call [setState] within this method, [render] will see the updated state and will be executed only once
  /// despite the [state] value change.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#mounting-componentwillmount>
  void componentWillMount() {}

  /// ReactJS lifecycle method that is invoked once, only on the client _(not on the server)_, immediately after the
  /// initial rendering occurs.
  ///
  /// At this point in the lifecycle, you can access any [ref]s to the children of [rootNode].
  ///
  /// The [componentDidMount] method of child `Component`s is invoked _before_ that of parent `Component`.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#mounting-componentdidmount>
  void componentDidMount() {}

  /// ReactJS lifecycle method that is invoked when a `Component` is receiving [newProps].
  ///
  /// This method is not called for the initial [render].
  ///
  /// Use this as an opportunity to react to a prop transition before [render] is called by updating the [state] using
  /// [setState]. The old props can be accessed via [props].
  ///
  /// Calling [setState] within this function will not trigger an additional [render].
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#updating-componentwillreceiveprops>
  void componentWillReceiveProps(Map newProps) {}

  /// ReactJS lifecycle method that is invoked before rendering when [nextProps] or [nextState] are being received.
  ///
  /// Use this as an opportunity to return false when you're certain that the transition to the new props and state
  /// will not require a component update.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#updating-shouldcomponentupdate>
  bool shouldComponentUpdate(Map nextProps, Map nextState) => true;

  /// ReactJS lifecycle method that is invoked immediately before rendering when [nextProps] or [nextState] are being
  /// received.
  ///
  /// This method is not called for the initial [render].
  ///
  /// Use this as an opportunity to perform preparation before an update occurs.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#updating-componentwillupdate>
  void componentWillUpdate(Map nextProps, Map nextState) {}

  /// ReactJS lifecycle method that is invoked immediately after the `Component`'s updates are flushed to the DOM.
  ///
  /// This method is not called for the initial [render].
  ///
  /// Use this as an opportunity to operate on the [rootNode] (DOM) when the `Component` has been updated as a result
  /// of the values of [prevProps] / [prevState].
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#updating-componentdidupdate>
  void componentDidUpdate(Map prevProps, Map prevState) {}

  /// ReactJS lifecycle method that is invoked immediately before a `Component` is unmounted from the DOM.
  ///
  /// Perform any necessary cleanup in this method, such as invalidating timers or cleaning up any DOM [Element]s that
  /// were created in [componentDidMount].
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#unmounting-componentwillunmount>
  void componentWillUnmount() {}

  /// Invoked once before the `Component` is mounted. The return value will be used as the initial value of [state].
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#getinitialstate>
  Map getInitialState() => {};

  /// Invoked once and cached when [reactComponentClass] is called. Values in the mapping will be set on [props]
  /// if that prop is not specified by the parent component.
  ///
  /// This method is invoked before any instances are created and thus cannot rely on [props]. In addition, be aware
  /// that any complex objects returned by `getDefaultProps` will be shared across instances, not copied.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#getdefaultprops>
  Map getDefaultProps() => {};

  /// __Required.__
  ///
  /// When called, it should examine [props] and [state] and return a single child [Element]. This child [Element] can
  /// be either a virtual representation of a native DOM component (such as [DivElement]) or another composite
  /// `Component` that you've defined yourself.
  ///
  /// See: <https://facebook.github.io/react/docs/react-component.html#render>
  dynamic render();
}

/// Typedef of a transactional [Component.setState] callback.
///
/// See: <https://facebook.github.io/react/docs/react-component.html#setstate>
typedef Map _TransactionalSetStateCallback(Map prevState, Map props);


/// A cross-browser wrapper around the browser's [nativeEvent].
///
/// It has the same interface as the browser's native event, including [stopPropagation] and [preventDefault], except
/// the events work identically across all browsers.
///
/// See: <https://facebook.github.io/react/docs/events.html#syntheticevent>
class SyntheticEvent {
  /// Indicates whether the [Event] bubbles up through the DOM or not.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles>
  final bool bubbles;

  /// Indicates whether the [Event] is cancelable or not.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable>
  final bool cancelable;

  /// Identifies the current target for the event, as the [Event] traverses the DOM.
  ///
  /// It always refers to the [Element] the [Event] handler has been attached to as opposed to [target] which identifies
  /// the [Element] on which the [Event] occurred.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget>
  final /*DOMEventTarget*/ currentTarget;

  bool _defaultPrevented;

  dynamic _preventDefault;

  /// Indicates whether or not [preventDefault] was called on the event.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented>
  bool get defaultPrevented => _defaultPrevented;

  /// Cancels the [Event] if it is [cancelable], without stopping further propagation of the event.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault>
  void preventDefault() {
    _defaultPrevented = true;
    _preventDefault();
  }

  /// Prevents further propagation of the current event.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation>
  final dynamic stopPropagation;

  /// Indicates which phase of the [Event] flow is currently being evaluated.
  ///
  /// Possible values:
  ///
  /// > [Event.CAPTURING_PHASE] (1) - The [Event] is being propagated through the [target]'s ancestor objects. This
  /// process starts with the Window, then [HtmlDocument], then the [HtmlHtmlElement], and so on through the [Element]s
  /// until the [target]'s parent is reached. Event listeners registered for capture mode when
  /// [EventTarget.addEventListener] was called are triggered during this phase.
  ///
  /// > [Event.AT_TARGET] (2) - The [Event] has arrived at the [target]. Event listeners registered for this phase are
  /// called at this time. If [bubbles] is `false`, processing the [Event] is finished after this phase is complete.
  ///
  /// > [Event.BUBBLING_PHASE] (3) - The [Event] is propagating back up through the [target]'s ancestors in reverse
  /// order, starting with the parent, and eventually reaching the containing Window. This is known as bubbling, and
  /// occurs only if [bubbles] is `true`. [Event] listeners registered for this phase are triggered during this process.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase>
  final num eventPhase;

  /// Is `true` when the [Event] was generated by a user action, and `false` when the [Event] was created or modified
  /// by a script or dispatched via [Event.dispatchEvent].
  ///
  /// __Read Only__
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted>
  final bool isTrusted;

  /// Native browser event that [SyntheticEvent] wraps around.
  final /*DOMEvent*/ nativeEvent;

  /// A reference to the object that dispatched the event. It is different from [currentTarget] when the [Event]
  /// handler is called when [eventPhase] is [Event.BUBBLING_PHASE] or [Event.CAPTURING_PHASE].
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/target>
  final /*DOMEventTarget*/ target;

  /// Returns the [Time] (in milliseconds) at which the [Event] was created.
  ///
  /// _Starting with Chrome 49, returns a high-resolution monotonic time instead of epoch time._
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp>
  final num timeStamp;

  /// Returns a string containing the type of event. It is set when the [Event] is constructed and is the name commonly
  /// used to refer to the specific event.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/type>
  final String type;

  SyntheticEvent(
      this.bubbles,
      this.cancelable,
      this.currentTarget,
      this._defaultPrevented,
      this._preventDefault,
      this.stopPropagation,
      this.eventPhase,
      this.isTrusted,
      this.nativeEvent,
      this.target,
      this.timeStamp,
      this.type){}
}

class SyntheticClipboardEvent extends SyntheticEvent {

  final clipboardData;

  SyntheticClipboardEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.clipboardData) : super( bubbles, cancelable, currentTarget, _defaultPrevented,
          _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
          timeStamp, type){}

}

class SyntheticKeyboardEvent extends SyntheticEvent {

  final bool altKey;
  final String char;
  final bool ctrlKey;
  final String locale;
  final num location;
  final String key;
  final bool metaKey;
  final bool repeat;
  final bool shiftKey;
  final num keyCode;
  final num charCode;

  SyntheticKeyboardEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.altKey, this.char, this.charCode, this.ctrlKey,
      this.locale, this.location, this.key, this.keyCode, this.metaKey,
      this.repeat, this.shiftKey) :
        super( bubbles, cancelable, currentTarget, _defaultPrevented,
          _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
          timeStamp, type){}

}

class SyntheticFocusEvent extends SyntheticEvent {

  final /*DOMEventTarget*/ relatedTarget;

  SyntheticFocusEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.relatedTarget) :
        super( bubbles, cancelable, currentTarget, _defaultPrevented,
            _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
            timeStamp, type){}

}

class SyntheticFormEvent extends SyntheticEvent {

  SyntheticFormEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type) : super( bubbles, cancelable, currentTarget, _defaultPrevented,
          _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
          timeStamp, type){}

}

class SyntheticDataTransfer {
  final String dropEffect;
  final String effectAllowed;
  final List files;
  final List<String> types;

  SyntheticDataTransfer(this.dropEffect, this.effectAllowed, this.files, this.types);
}

class SyntheticMouseEvent extends SyntheticEvent {

  final bool altKey;
  final num button;
  final num buttons;
  final num clientX;
  final num clientY;
  final bool ctrlKey;
  final SyntheticDataTransfer dataTransfer;
  final bool metaKey;
  final num pageX;
  final num pageY;
  final /*DOMEventTarget*/relatedTarget;
  final num screenX;
  final num screenY;
  final bool shiftKey;

  SyntheticMouseEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.altKey, this.button, this.buttons, this.clientX, this.clientY,
      this.ctrlKey, this.dataTransfer, this.metaKey, this.pageX, this.pageY, this.relatedTarget,
      this.screenX, this.screenY, this.shiftKey) :
        super( bubbles, cancelable, currentTarget, _defaultPrevented,
            _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
            timeStamp, type){}

}

class SyntheticTouchEvent extends SyntheticEvent {

  final bool altKey;
  final /*DOMTouchList*/ changedTouches;
  final bool ctrlKey;
  final bool metaKey;
  final bool shiftKey;
  final /*DOMTouchList*/ targetTouches;
  final /*DOMTouchList*/ touches;

  SyntheticTouchEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.altKey, this.changedTouches, this.ctrlKey, this.metaKey,
      this.shiftKey, this.targetTouches, this.touches) :
        super( bubbles, cancelable, currentTarget, _defaultPrevented,
            _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
            timeStamp, type){}

}

class SyntheticUIEvent extends SyntheticEvent {

  final num detail;
  final /*DOMAbstractView*/ view;

  SyntheticUIEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.detail, this.view) : super( bubbles, cancelable, currentTarget, _defaultPrevented,
          _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
          timeStamp, type){}

}

class SyntheticWheelEvent extends SyntheticEvent {

  final num deltaX;
  final num deltaMode;
  final num deltaY;
  final num deltaZ;

  SyntheticWheelEvent(bubbles, cancelable, currentTarget, _defaultPrevented,
      _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
      timeStamp, type, this.deltaX, this.deltaMode, this.deltaY, this.deltaZ) : super( bubbles, cancelable, currentTarget, _defaultPrevented,
          _preventDefault, stopPropagation, eventPhase, isTrusted, nativeEvent, target,
          timeStamp, type){}


}

/// Registers [componentFactory] on both client and server.
var registerComponent = (componentFactory, [skipMethods]) {
  throw new Exception('setClientConfiguration must be called before registerComponent.');
};

/// The HTML `<a>` [AnchorElement].
var a;

/// The HTML `<abbr>` [Element].
var abbr;

/// The HTML `<address>` [Element].
var address;

/// The HTML `<area>` [AreaElement].
var area;

/// The HTML `<article>` [Element].
var article;

/// The HTML `<aside>` [Element].
var aside;

/// The HTML `<audio>` [AudioElement].
var audio;

/// The HTML `<b>` [Element].
var b;

/// The HTML `<base>` [BaseElement].
var base;

/// The HTML `<bdi>` [Element].
var bdi;

/// The HTML `<bdo>` [Element].
var bdo;

/// The HTML `<big>` [Element].
var big;

/// The HTML `<blockquote>` [Element].
var blockquote;

/// The HTML `<body>` [BodyElement].
var body;

/// The HTML `<br>` [BRElement].
var br;

/// The HTML `<button>` [ButtonElement].
var button;

/// The HTML `<canvas>` [CanvasElement].
var canvas;

/// The HTML `<caption>` [Element].
var caption;

/// The HTML `<cite>` [Element].
var cite;

/// The HTML `<code>` [Element].
var code;

/// The HTML `<col>` [Element].
var col;

/// The HTML `<colgroup>` [Element].
var colgroup;

/// The HTML `<data>` [Element].
var data;

/// The HTML `<datalist>` [DataListElement].
var datalist;

/// The HTML `<dd>` [Element].
var dd;

/// The HTML `<del>` [Element].
var del;

/// The HTML `<details>` [DetailsElement].
var details;

/// The HTML `<dfn>` [Element].
var dfn;

/// The HTML `<dialog>` [DialogElement].
var dialog;

/// The HTML `<div>` [DivElement].
var div;

/// The HTML `<dl>` [DListElement].
var dl;

/// The HTML `<dt>` [Element].
var dt;

/// The HTML `<em>` [Element].
var em;

/// The HTML `<embed>` [EmbedElement].
var embed;

/// The HTML `<fieldset>` [FieldSetElement].
var fieldset;

/// The HTML `<figcaption>` [Element].
var figcaption;

/// The HTML `<figure>` [Element].
var figure;

/// The HTML `<footer>` [Element].
var footer;

/// The HTML `<form>` [FormElement].
var form;

/// The HTML `<h1>` [HeadingElement].
var h1;

/// The HTML `<h2>` [HeadingElement].
var h2;

/// The HTML `<h3>` [HeadingElement].
var h3;

/// The HTML `<h4>` [HeadingElement].
var h4;

/// The HTML `<h5>` [HeadingElement].
var h5;

/// The HTML `<h6>` [HeadingElement].
var h6;

/// The HTML `<head>` [HeadElement].
var head;

/// The HTML `<header>` [Element].
var header;

/// The HTML `<hr>` [HRElement].
var hr;

/// The HTML `<html>` [HtmlHtmlElement].
var html;

/// The HTML `<i>` [Element].
var i;

/// The HTML `<iframe>` [IFrameElement].
var iframe;

/// The HTML `<img>` [ImageElement].
var img;

/// The HTML `<input>` [InputElement].
var input;

/// The HTML `<ins>` [Element].
var ins;

/// The HTML `<kbd>` [Element].
var kbd;

/// The HTML `<keygen>` [KeygenElement].
var keygen;

/// The HTML `<label>` [LabelElement].
var label;

/// The HTML `<legend>` [LegendElement].
var legend;

/// The HTML `<li>` [LIElement].
var li;

/// The HTML `<link>` [LinkElement].
var link;

/// The HTML `<main>` [Element].
var main;

/// The HTML `<map>` [MapElement].
var map;

/// The HTML `<mark>` [Element].
var mark;

/// The HTML `<menu>` [MenuElement].
var menu;

/// The HTML `<menuitem>` [MenuItemElement].
var menuitem;

/// The HTML `<meta>` [MetaElement].
var meta;

/// The HTML `<meter>` [MeterElement].
var meter;

/// The HTML `<nav>` [Element].
var nav;

/// The HTML `<noscript>` [Element].
var noscript;

/// The HTML `<object>` [ObjectElement].
var object;

/// The HTML `<ol>` [OListElement].
var ol;

/// The HTML `<optgroup>` [OptGroupElement].
var optgroup;

/// The HTML `<option>` [OptionElement].
var option;

/// The HTML `<output>` [OutputElement].
var output;

/// The HTML `<p>` [ParagraphElement].
var p;

/// The HTML `<param>` [ParamElement].
var param;

/// The HTML `<picture>` [PictureElement].
var picture;

/// The HTML `<pre>` [PreElement].
var pre;

/// The HTML `<progress>` [ProgressElement].
var progress;

/// The HTML `<q>` [QuoteElement].
var q;

/// The HTML `<rp>` [Element].
var rp;

/// The HTML `<rt>` [Element].
var rt;

/// The HTML `<ruby>` [Element].
var ruby;

/// The HTML `<s>` [Element].
var s;

/// The HTML `<samp>` [Element].
var samp;

/// The HTML `<script>` [ScriptElement].
var script;

/// The HTML `<section>` [Element].
var section;

/// The HTML `<select>` [SelectElement].
var select;

/// The HTML `<small>` [Element].
var small;

/// The HTML `<source>` [SourceElement].
var source;

/// The HTML `<span>` [SpanElement].
var span;

/// The HTML `<strong>` [Element].
var strong;

/// The HTML `<style>` [StyleElement].
var style;

/// The HTML `<sub>` [Element].
var sub;

/// The HTML `<summary>` [Element].
var summary;

/// The HTML `<sup>` [Element].
var sup;

/// The HTML `<table>` [TableElement].
var table;

/// The HTML `<tbody>` [TableSectionElement].
var tbody;

/// The HTML `<td>` [TableCellElement].
var td;

/// The HTML `<textarea>` [TextAreaElement].
var textarea;

/// The HTML `<tfoot>` [TableSectionElement].
var tfoot;

/// The HTML `<th>` [TableCellElement].
var th;

/// The HTML `<thead>` [TableSectionElement].
var thead;

/// The HTML `<time>` [TimeInputElement].
var time;

/// The HTML `<title>` [TitleElement].
var title;

/// The HTML `<tr>` [TableRowElement].
var tr;

/// The HTML `<track>` [TrackElement].
var track;

/// The HTML `<u>` [Element].
var u;

/// The HTML `<ul>` [UListElement].
var ul;

/// The HTML `<var>` [Element].
///
/// _Named variable because `var` is a reserved word in Dart._
var variable;

/// The HTML `<video>` [VideoElement].
var video;

/// The HTML `<wbr>` [Element].
var wbr;

/// The SVG `<circle>` [CircleElement].
var circle;

/// The SVG `<clipPath>` [ClipPathElement].
var clipPath;

/// The SVG `<defs>` [DefsElement].
var defs;

/// The SVG `<ellipse>` [EllipseElement].
var ellipse;

/// The SVG `<g>` [GElement].
var g;

/// The SVG `<image>` [ImageElement].
var image;

/// The SVG `<line>` [LineElement].
var line;

/// The SVG `<linearGradient>` [LinearGradientElement].
var linearGradient;

/// The SVG `<mask>` [MaskElement].
var mask;

/// The SVG `<path>` [PathElement].
var path;

/// The SVG `<pattern>` [PatternElement].
var pattern;

/// The SVG `<polygon>` [PolygonElement].
var polygon;

/// The SVG `<polyline>` [PolylineElement].
var polyline;

/// The SVG `<radialGradient>` [RadialGradientElement].
var radialGradient;

/// The SVG `<rect>` [RectElement].
var rect;

/// The SVG `<stop>` [StopElement].
var stop;

/// The SVG `<svg>` [SvgSvgElement].
var svg;

/// The SVG `<text>` [TextElement].
var text;

/// The SVG `<tspan>` [TSpanElement].
var tspan;


/// Create React DOM `Component`s by calling the specified [creator].
_createDOMComponents(creator){
  a = creator('a');
  abbr = creator('abbr');
  address = creator('address');
  area = creator('area');
  article = creator('article');
  aside = creator('aside');
  audio = creator('audio');
  b = creator('b');
  base = creator('base');
  bdi = creator('bdi');
  bdo = creator('bdo');
  big = creator('big');
  blockquote = creator('blockquote');
  body = creator('body');
  br = creator('br');
  button = creator('button');
  canvas = creator('canvas');
  caption = creator('caption');
  cite = creator('cite');
  code = creator('code');
  col = creator('col');
  colgroup = creator('colgroup');
  data = creator('data');
  datalist = creator('datalist');
  dd = creator('dd');
  del = creator('del');
  details = creator('details');
  dfn = creator('dfn');
  dialog = creator('dialog');
  div = creator('div');
  dl = creator('dl');
  dt = creator('dt');
  em = creator('em');
  embed = creator('embed');
  fieldset = creator('fieldset');
  figcaption = creator('figcaption');
  figure = creator('figure');
  footer = creator('footer');
  form = creator('form');
  h1 = creator('h1');
  h2 = creator('h2');
  h3 = creator('h3');
  h4 = creator('h4');
  h5 = creator('h5');
  h6 = creator('h6');
  head = creator('head');
  header = creator('header');
  hr = creator('hr');
  html = creator('html');
  i = creator('i');
  iframe = creator('iframe');
  img = creator('img');
  input = creator('input');
  ins = creator('ins');
  kbd = creator('kbd');
  keygen = creator('keygen');
  label = creator('label');
  legend = creator('legend');
  li = creator('li');
  link = creator('link');
  main = creator('main');
  map = creator('map');
  mark = creator('mark');
  menu = creator('menu');
  menuitem = creator('menuitem');
  meta = creator('meta');
  meter = creator('meter');
  nav = creator('nav');
  noscript = creator('noscript');
  object = creator('object');
  ol = creator('ol');
  optgroup = creator('optgroup');
  option = creator('option');
  output = creator('output');
  p = creator('p');
  param = creator('param');
  picture = creator('picture');
  pre = creator('pre');
  progress = creator('progress');
  q = creator('q');
  rp = creator('rp');
  rt = creator('rt');
  ruby = creator('ruby');
  s = creator('s');
  samp = creator('samp');
  script = creator('script');
  section = creator('section');
  select = creator('select');
  small = creator('small');
  source = creator('source');
  span = creator('span');
  strong = creator('strong');
  style = creator('style');
  sub = creator('sub');
  summary = creator('summary');
  sup = creator('sup');
  table = creator('table');
  tbody = creator('tbody');
  td = creator('td');
  textarea = creator('textarea');
  tfoot = creator('tfoot');
  th = creator('th');
  thead = creator('thead');
  time = creator('time');
  title = creator('title');
  tr = creator('tr');
  track = creator('track');
  u = creator('u');
  ul = creator('ul');
  variable = creator('var');
  video = creator('video');
  wbr = creator('wbr');

  // SVG Elements
  circle = creator('circle');
  clipPath = creator('clipPath');
  defs = creator('defs');
  ellipse = creator('ellipse');
  g = creator('g');
  image = creator('image');
  line = creator('line');
  linearGradient = creator('linearGradient');
  mask = creator('mask');
  path = creator('path');
  pattern = creator('pattern');
  polygon = creator('polygon');
  polyline = creator('polyline');
  radialGradient = creator('radialGradient');
  rect = creator('rect');
  stop = creator('stop');
  svg = creator('svg');
  text = creator('text');
  tspan = creator('tspan');
}

/// Set configuration based on functions provided as arguments.
///
/// The arguments are assigned to global variables, and React DOM `Component`s are created by calling
/// [_createDOMComponents] with [domCreator].
setReactConfiguration(domCreator, customRegisterComponent){
  registerComponent = customRegisterComponent;
  // HTML Elements
  _createDOMComponents(domCreator);
}
