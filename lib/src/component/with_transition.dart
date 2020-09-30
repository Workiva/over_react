// Copyright 2020 Workiva Inc.
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

library over_react.abstract_controlled_transition;

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;

part 'with_transition.over_react.g.dart';

/// A wrapper component that hooks into CSS transition(s) present on a single child passed to it.
///
/// For example, say you have an element that "fades" in/out using the `fade` CSS class to apply
/// a CSS `transition`, and an `in` CSS class that - when present - changes the opacity from `0` to `1`.
///
/// Using this component, you can simply toggle the value of [WithTransitionPropsMixin.isShown] from `false` to
/// `true` using your own state to make the node "fade in", and hook into the available prop callbacks like
/// `onDidShow`, `onDidHide` to know when the CSS transition has completed.
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/components.dart' show WithTransition;
///
/// mixin WithTransitionExampleProps on UiProps {
///   bool initiallyShown;
/// }
///
/// UiFactory<WithTransitionExampleProps> WithTransitionExample = uiFunction(
///   (props) {
///     final initiallyShown = props.initiallyShown ?? false;
///
///     final isShown = useState(initiallyShown);
///
///     final classes = ClassNameBuilder.fromProps(props)
///       ..add('fade')
///       ..add('in', isShown.value);
///
///     return Dom.div()(
///       Dom.div()(
///         (Dom.button()
///           ..type = 'button'
///           ..onClick = (useCallback((_) {
///             isShown.setWithUpdater((isShown) => !isShown);
///           }, const []))
///         )('Toggle Visibility'),
///       ),
///       (WithTransition()
///         ..isShown = isShown.value
///         ..onWillShow = () {
///           // Do something that should happen before the CSS transition completes.
///         }
///         ..onDidShow = () {
///           // Do something that shouldn't happen until the CSS transition completes.
///         }
///         ..onWillHide = () {
///           // Do something that should happen before the CSS transition completes.
///         }
///         ..onDidHide = () {
///           // Do something that shouldn't happen until the CSS transition completes.
///         }
///       )(
///         (Dom.div()
///           ..className = classes.toClassName()
///         )(
///           // Some children...
///         ),
///       )
///     );
///   },
///   $WithTransitionExampleConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// __Wrapping around custom components__
///
/// If you want to wrap around another component instead of around a single `Dom` element child as shown in the
/// first example above, you must ensure that the value of `props.ref` is forwarded to the `Element` that has
/// the CSS transition using `uiForwardRef`:
///
/// ```dart
/// import 'package:over_react/over_react.dart';
///
/// mixin CustomChildProps on UiProps {}
///
/// UiFactory<CustomChildProps> CustomChild = uiForwardRef(
///   (props, ref) {
///     return (Dom.div()..ref = ref)(
///       props.children,
///     ),
///   },
///   $CustomChildConfig, // ignore: undefined_identifier
/// );
/// ```
UiFactory<WithTransitionProps> WithTransition = _$WithTransition;

mixin WithTransitionPropsMixin on UiProps {
  /// Controls the visibility of the component.
  ///
  /// * When set to `true` - the component will begin to transition into a visible state.
  /// * When set to `false` - the component will begin to transition into a hidden state.
  ///
  /// > Default: `false`
  ///
  /// > See: [WithTransition] for example usage.
  bool isShown;

  /// An optional map of props to apply to the single child based on the current transition phase.
  ///
  /// This provides you with the ability to add CSS classes / other DOM attributes based on the granular
  /// transition states that are confined within the [WithTransition] component without having to
  /// utilize state change callbacks to update your component's state.
  ///
  /// __NOTE:__ These values will override any prop values set on the child itself if the
  /// key(s) in the `Map` are the same.
  ///
  /// __Example:__
  ///
  /// ```dart
  /// UiFactory<WithTransitionExampleProps> WithTransitionExample = uiFunction(
  ///   (props) {
  ///     final isShown = useState(false);
  ///
  ///     return (WithTransition()
  ///       ..isShown = isShown.value
  ///       ..childPropsByPhase = useMemo(() => {
  ///         TransitionPhase.PRE_SHOWING: domProps()..className = 'before-showing',
  ///         TransitionPhase.SHOWING: domProps()..className = 'showing',
  ///         TransitionPhase.SHOWN: domProps()..className = 'shown',
  ///         TransitionPhase.HIDING: domProps()..className = 'hiding',
  ///         TransitionPhase.HIDDEN: domProps()..className = 'hidden',
  ///       })
  ///     )(
  ///       // The child that has CSS transitions
  ///     );
  ///   },
  ///   $WithTransitionExampleConfig, // ignore: undefined_identifier
  /// );
  /// ```
  Map<TransitionPhase, Map> childPropsByPhase;

  /// The amount of time to wait for a CSS transition to complete before assuming something went wrong
  /// and canceling the subscription.
  ///
  /// If the CSS transition duration on the node is longer than `1s`, you will need to set this to a Duration
  /// that is greater than or equal to the expected CSS duration of the node.
  ///
  /// > Default `const Duration(seconds: 1)`
  Duration transitionTimeout;
}

class WithTransitionProps = UiProps with v2.TransitionPropsMixin, WithTransitionPropsMixin;

mixin WithTransitionState on UiState {
  /// The current transition phase, derived from the current [WithTransitionPropsMixin.isShown] value.
  ///
  /// Do not set directly.
  @protected
  TransitionPhase $transitionPhase;
}

class WithTransitionComponent extends UiStatefulComponent2<WithTransitionProps, WithTransitionState> {
  /// Timer used to determine if a transition timeout has occurred.
  Timer _transitionEndTimer;

  /// Stream for listening to `transitionend` events on the node.
  StreamSubscription _endTransitionSubscription;

  final _transitionNodeRef = createRef<Element>();

  @override
  get defaultProps => (newProps()
    ..addProps(v2.TransitionPropsMixin.defaultProps)
    ..isShown = false
    ..transitionTimeout = const Duration(seconds: 1)
    ..childPropsByPhase = const {
      v2.TransitionPhase.PRE_SHOWING: {},
      v2.TransitionPhase.SHOWING: {},
      v2.TransitionPhase.SHOWN: {},
      v2.TransitionPhase.HIDING: {},
      v2.TransitionPhase.HIDDEN: {},
    }
  );

  @override
  get initialState => (newState()
    ..$transitionPhase = _transitionPhaseDerivedFromProps(props)
  );

  @override
  getDerivedStateFromProps(Map nextProps, Map prevState) {
    final tNextProps = typedPropsFactory(nextProps);
    final tPrevState = typedStateFactory(prevState);
    if (tNextProps.isShown && _isOrWillBeHidden(tPrevState.$transitionPhase)) {
      return _stateToBeginShowing(tNextProps, tPrevState.$transitionPhase);
    } else if (!tNextProps.isShown && _isOrWillBeShown(tPrevState.$transitionPhase)) {
      return _stateToBeginHiding(tNextProps, tPrevState.$transitionPhase);
    }

    return null;
  }

  @override
  void componentDidUpdate(Map prevProps, Map prevState, [dynamic snapshot]) {
    if (state.$transitionPhase == typedStateFactory(prevState).$transitionPhase) return;

    if (state.$transitionPhase != TransitionPhase.SHOWING) {
      // Allows the `WithTransitionComponent` to handle state changes that interrupt state
      // changes waiting on `transitionend` events.
      _cancelTransitionEventListener();
    }

    switch (state.$transitionPhase) {
      case TransitionPhase.PRE_SHOWING:
        _handlePreShowing();
        break;
      case TransitionPhase.SHOWING:
        props.onWillShow?.call();
        break;
      case TransitionPhase.HIDING:
        props.onWillHide?.call();
        _handleHiding();
        break;
      case TransitionPhase.HIDDEN:
        props.onDidHide?.call();
        break;
      case TransitionPhase.SHOWN:
        props.onDidShow?.call();
        break;
    }
  }

  var _isMounted = false;

  @override
  void componentDidMount() {
    _isMounted = true;
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _isMounted = false;
    _cancelTransitionEndTimer();
    _cancelTransitionEventListener();
  }

  @override
  render() {
    assert(_hasSingleValidChild(props));

    final childElement = props.children.single as ReactElement;
    final childProps = domProps(getProps(childElement));
    final phaseProps = props.childPropsByPhase[state.$transitionPhase] ?? const {};
    final phaseClasses = ClassNameBuilder.fromProps(childProps)
      ..addFromProps(phaseProps);

    return cloneElement(childElement, domProps()
      ..addTestId(childProps.getTestId())
      ..addTestId('or.WithTransition.node')
      ..addProps(phaseProps)
      ..className = phaseClasses.toClassName()
      ..ref = chainRefs(childElement.ref, _transitionNodeRef)
    );
  }

  void _cancelTransitionEventListener() {
    _endTransitionSubscription?.cancel();
    _endTransitionSubscription = null;
  }

  void _cancelTransitionEndTimer() {
    _transitionEndTimer?.cancel();
    _transitionEndTimer = null;
  }

  /// Return a state value that will result in the component beginning to show the node
  /// unless the [currentPhase] is already shown or is in the process of showing.
  Map _stateToBeginShowing(WithTransitionProps tProps, TransitionPhase currentPhase) {
    if (_isOrWillBeShown(currentPhase)) return null;

    return newState()
      ..$transitionPhase = _hasTransitionIn(tProps) ? TransitionPhase.PRE_SHOWING : TransitionPhase.SHOWN;
  }

  /// Return a state value that wll result in the component beginning to hide the node
  /// unless the [currentPhase] is already hidden or is in the process of hiding.
  Map _stateToBeginHiding(WithTransitionProps tProps, TransitionPhase currentPhase) {
    if (_isOrWillBeHidden(currentPhase)) return null;

    return newState()
      ..$transitionPhase = _hasTransitionOut(tProps) ? TransitionPhase.HIDING : TransitionPhase.HIDDEN;
  }

  /// Called from `componentDidUpdate` when `state.transitionPhase` is `TransitionPhase.PRE_SHOWING`.
  void _handlePreShowing() {
    onNextTransitionEnd(() {
      if (_isOrWillBeShown(state.$transitionPhase)) {
        setState(newState()..$transitionPhase = TransitionPhase.SHOWN);
      }
    });

    setState(newState()..$transitionPhase = TransitionPhase.SHOWING);
  }

  /// Called from `componentDidUpdate` when `state.transitionPhase` is `TransitionPhase.HIDING`.
  void _handleHiding() {
    onNextTransitionEnd(() {
      if (_isMounted && state.$transitionPhase == TransitionPhase.HIDING) {
        setState(newState()..$transitionPhase = TransitionPhase.HIDDEN);
      }
    });
  }

  /// Listens for the next `transitionend` event and invokes a callback after
  /// the event is dispatched.
  void onNextTransitionEnd(Function() complete) {
    var transitionCount = _isOrWillBeHidden(state.$transitionPhase)
        ? _transitionOutCount(props)
        : _transitionInCount(props);

    _cancelTransitionEventListener();
    _cancelTransitionEndTimer();

    _transitionEndTimer = Timer(props.transitionTimeout, () {
      assert(ValidationUtil.warn(
          'The number of transitions expected to complete have not completed. Something is most likely wrong.',
      ));

      _cancelTransitionEventListener();

      complete();
    });

    _endTransitionSubscription =
        _transitionNodeRef.current?.onTransitionEnd?.skip(transitionCount - 1)?.take(1)?.listen((_) {
      _cancelTransitionEndTimer();

      complete();
    });
  }
}

bool _hasSingleValidChild(WithTransitionProps props) {
  if (props.children.length == 1 && isValidElement(props.children.single)) return true;

  throw PropError.value(props.children, 'children',
      'WithValidation only accepts a single child which must be a valid ReactElement.');
}

TransitionPhase _transitionPhaseDerivedFromProps(WithTransitionProps tProps) =>
    tProps.isShown ? TransitionPhase.SHOWN : TransitionPhase.HIDDEN;

bool _isOrWillBeHidden(TransitionPhase currentPhase) =>
    currentPhase == TransitionPhase.HIDING ||
    currentPhase == TransitionPhase.HIDDEN;

bool _isOrWillBeShown(TransitionPhase currentPhase) =>
    currentPhase == TransitionPhase.PRE_SHOWING ||
    currentPhase == TransitionPhase.SHOWING ||
    currentPhase == TransitionPhase.SHOWN;

/// Returns the value of [v2.TransitionPropsMixin.transitionCount], falling back to `null` for backwards compatibility.
int _getTransitionCount(WithTransitionProps props) => props?.transitionCount ?? 1;

/// Whether transitions are enabled based on the [props] provided.
bool _hasTransition(WithTransitionProps props) => _getTransitionCount(props) > 0;

/// Whether the [Element] rendered by the [WithTransition] component will emit a `transitionend` event when showing.
bool _hasTransitionIn(WithTransitionProps props) => _hasTransition(props) && _transitionInCount(props) > 0;

/// Whether the [Element] rendered by the [WithTransition] component will emit a `transitionend` event when hiding.
bool _hasTransitionOut(WithTransitionProps props) => _hasTransition(props) && _transitionOutCount(props) > 0;

/// The number of `transitionend` events that occur when the [Element]
/// rendered by the [WithTransition] component is shown.
///
/// Defaults to `1` to match previous behavior in the case where `props.transitionCount` is `null`.
int _transitionInCount(WithTransitionProps props) => props?.transitionInCount ?? _getTransitionCount(props);

/// The number of `transitionend` events that occur when the transition node is hidden.
///
/// Defaults to `1` to match previous behavior in the case where `props.transitionCount` is `null`.
int _transitionOutCount(WithTransitionProps props) => props?.transitionOutCount ?? _getTransitionCount(props);
