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

library over_react.abstract_transition;

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/component_base.dart' as component_base;

// ignore: uri_has_not_been_generated
part 'abstract_transition.over_react.g.dart';

@AbstractProps()
abstract class _$AbstractTransitionProps extends UiProps with 
    TransitionPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $TransitionPropsMixin {}

@AbstractState()
abstract class _$AbstractTransitionState extends UiState {
  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionPhase.SHOWN] : [TransitionPhase.HIDDEN]
  TransitionPhase transitionPhase;
}

/// How to use [AbstractTransitionComponent]:
///
/// * Create props and state the extend [AbstractTransitionProps] and [AbstractTransitionState].
///
///         @Props()
///         class CustomComponentProps extends AbstractTransitionProps {}
///
///         @State()
///         class CustomComponentState extends AbstractTransitionProps {}
///
/// * Have your component extend [AbstractTransitionComponent].
///
///         @Component()
///         class CustomComponent extends AbstractTransitionComponent<CustomComponentProps, CustomComponentState> {}
///
/// * Override [initiallyShown], [getTransitionDomNode] and optionally [hasTransition].
///
/// * Use helper getters to render your component.
///
///         @override
///         render() {
///           if (!shouldRender) {
///             return false;
///           }
///
///           var classes = forwardingClassNameBuilder()
///             ..add('class-to-start-transition', isShown);
///
///           return (Dom.div()
///             ..className = classes.toClassName()
///           )()
///         }
///
/// * Granular lifecycle methods available:
///   * [prepareShow]
///   * [handlePreShowing]
///   * [handleShowing]
///   * [handleShown]
///   * [prepareHide]
///   * [handleHiding]
///   * [handleHidden]
///
/// * API methods that you get for free:
///   * [show]
///   * [hide]
///   * [toggle]
@AbstractComponent()
abstract class AbstractTransitionComponent<T extends AbstractTransitionProps,
                                           S extends AbstractTransitionState>
  extends UiStatefulComponent<T, S> {
  /// The DOM attribute used to indicate the current transition phase,
  /// added in test mode in [getTransitionTestAttributes].
  ///
  /// Possible values:
  ///
  /// - `pre-showing`
  /// - `showing`
  /// - `shown`
  /// - `hiding`
  /// - `hidden`
  static const String transitionPhaseTestAttr = 'data-transition-phase';

  @override
  get consumedProps => const [
    AbstractTransitionProps.meta,
    TransitionPropsMixin.meta,
  ];

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(TransitionPropsMixin.defaultProps)
  );

  @override
  Map getInitialState() => (newState()
    ..transitionPhase = this.initiallyShown ? TransitionPhase.SHOWN : TransitionPhase.HIDDEN
  );

  /// Stream for listening to `transitionend` events on the [AbstractTransitionComponent].
  StreamSubscription _endTransitionSubscription;

  /// Whether the [AbstractTransitionComponent] should be visible initially when mounted.
  bool get initiallyShown;

  /// Returns the DOM node that will transition.
  Element getTransitionDomNode();

  /// Whether transitions are enabled for this component.
  bool get hasTransition => true;

  /// Whether the Element returned by [getTransitionDomNode] will have a transition event when showing.
  bool get hasTransitionIn => hasTransition && transitionInCount > 0;

  /// Whether the Element returned by [getTransitionDomNode] will have a transition event when hiding.
  bool get hasTransitionOut => hasTransition && transitionOutCount > 0;

  /// The number of `transitionend` events that occur when the transition node is shown.
  ///
  /// Defaults to `1` to match previous behavior in the case where `props.transitionCount` is `null`.
  int get transitionInCount => props.transitionInCount ?? props.transitionCount ?? 1;

  /// The number of `transitionend` events that occur when the transition node is hidden.
  ///
  /// Defaults to `1` to match previous behavior in the case where `props.transitionCount` is `null`.
  int get transitionOutCount => props.transitionOutCount ?? props.transitionCount ?? 1;

  /// The duration that can elapse before a transition timeout occurs.
  Duration get transitionTimeout => const Duration(seconds: 1);

  /// Timer used to determine if a transition timeout has occurred.
  Timer _transitionEndTimer;

  // --------------------------------------------------------------------------
  // Private Utility Methods
  // --------------------------------------------------------------------------

  /// Begin showing the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already shown or is in the process of showing.
  ///   * The [AbstractTransitionProps.onWillShow] callback returns `false`.
  void _handleShow() {
    if (isOrWillBeShown) {
      return;
    }

    if (props.onWillShow != null && props.onWillShow() == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareShow();

    setState(newState()
      ..transitionPhase = hasTransitionIn ? TransitionPhase.PRE_SHOWING : TransitionPhase.SHOWN
    );
  }

  /// Begin hiding the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already hidden or is in the process of being hidden.
  ///   * The [AbstractTransitionProps.onWillHide] callback returns `false`.
  void _handleHide() {
    if (isOrWillBeHidden) {
      return;
    }

    if (props.onWillHide != null && props.onWillHide() == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareHide();

    setState(newState()
      ..transitionPhase = hasTransitionOut ? TransitionPhase.HIDING : TransitionPhase.HIDDEN
    );
  }

  /// Listens for the next `transitionend` event and invokes a callback after
  /// the event is dispatched.
  @mustCallSuper
  void onNextTransitionEnd(complete()) {
    var transitionCount = isOrWillBeHidden ? transitionOutCount : transitionInCount;

    _cancelTransitionEventListener();
    _cancelTransitionEndTimer();

    _transitionEndTimer = new Timer(transitionTimeout, () {
      assert(ValidationUtil.warn(
          'The number of transitions expected to complete have not completed. Something is most likely wrong.',
          this
      ));

      _cancelTransitionEventListener();

      complete();
    });

    _endTransitionSubscription = getTransitionDomNode()?.onTransitionEnd?.skip(transitionCount - 1)?.take(1)?.listen((_) {
      _cancelTransitionEndTimer();

      complete();
    });
  }

  void _cancelTransitionEventListener() {
    _endTransitionSubscription?.cancel();
    _endTransitionSubscription = null;
  }

  void _cancelTransitionEndTimer() {
    _transitionEndTimer?.cancel();
    _transitionEndTimer = null;
  }

  /// Whether the [AbstractTransitionComponent] should render.
  ///
  /// If this is false your [render] should return false.
  bool get shouldRender =>
      state.transitionPhase != TransitionPhase.HIDDEN;


  /// Whether the [AbstractTransitionComponent] is in a "visible" state.
  ///
  /// You should add your CSS class that starts a transition based on this value.
  bool get isShown =>
      state.transitionPhase == TransitionPhase.SHOWN ||
      state.transitionPhase == TransitionPhase.SHOWING;

  /// Whether the [AbstractTransitionComponent] is hidden or in the process of hiding.
  bool get isOrWillBeHidden =>
      state.transitionPhase == TransitionPhase.HIDING ||
      state.transitionPhase == TransitionPhase.HIDDEN;

  /// Whether the [AbstractTransitionComponent] is shown or in the process of showing.
  bool get isOrWillBeShown =>
      state.transitionPhase == TransitionPhase.PRE_SHOWING ||
      state.transitionPhase == TransitionPhase.SHOWING ||
      state.transitionPhase == TransitionPhase.SHOWN;

  // --------------------------------------------------------------------------
  // Lifecycle Methods
  // --------------------------------------------------------------------------

  /// Whether the overlay is not guaranteed to transition in response to the current
  /// state change.
  ///
  /// _Stored as variable as workaround for not adding breaking change to [handleHiding] API._
  ///
  /// A transition may not always occur when the state moves from SHOWING to HIDING
  /// if the PRE_SHOWING-->SHOWING-->HIDING transition happens back-to-back.
  ///
  /// Better to not always transition when the user is ninja-toggling a transitionable
  /// component than to break state changes waiting for a transition that will never happen.
  bool _transitionNotGuaranteed = false;

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    _transitionNotGuaranteed = false;

    var tPrevState = typedStateFactory(prevState);

    if (tPrevState.transitionPhase != state.transitionPhase) {
      if (state.transitionPhase != TransitionPhase.SHOWING) {
        // Allows the AbstractTransitionComponent to handle state changes that interrupt state
        // changes waiting on transitionend events.
        _cancelTransitionEventListener();
      }

      switch (state.transitionPhase) {
        case TransitionPhase.PRE_SHOWING:
          handlePreShowing();
          break;
        case TransitionPhase.SHOWING:
          handleShowing();
          break;
        case TransitionPhase.HIDING:
          _transitionNotGuaranteed = tPrevState.transitionPhase == TransitionPhase.SHOWING;
          handleHiding();
          break;
        case TransitionPhase.HIDDEN:
          handleHidden();
          break;
        case TransitionPhase.SHOWN:
          handleShown();
          break;
      }
    }
  }

  var _isUnmounted = false;

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    _isUnmounted = true;
    _cancelTransitionEndTimer();
    _cancelTransitionEventListener();
  }

  // --------------------------------------------------------------------------
  // State Transition Methods
  // --------------------------------------------------------------------------

  /// Method that will be called right before the [AbstractTransitionComponent] begins to show.
  void prepareShow() {}

  /// Method that will be called right before the [AbstractTransitionComponent] begins to hide.
  void prepareHide() {}

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `preShowing` state.
  void handlePreShowing() {
    onNextTransitionEnd(() {
      if (state.transitionPhase == TransitionPhase.SHOWING) {
        setState(newState()
          ..transitionPhase = TransitionPhase.SHOWN
        );
      }
    });

    // Force a repaint by accessing `offsetHeight` so that the changes to CSS classes are guaranteed to trigger a transition when it is applied
    getTransitionDomNode()?.offsetHeight;

    setState(newState()
      ..transitionPhase = TransitionPhase.SHOWING
    );
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `showing` state.
  void handleShowing() {}

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `hiding` state.
  void handleHiding() {
    if (_transitionNotGuaranteed) {
      // No transition will occur, so kick off the state change manually.
      //
      // Do this in a microtask since this state change causes invariant exceptions
      // when OverlayTrigger API methods are called at the same time.
      //
      // TODO: possibly remove microtask once using react-dart 1.0.0
      scheduleMicrotask(() {
        setState(newState()
          ..transitionPhase = TransitionPhase.HIDDEN
        );
      });

      _cancelTransitionEventListener();
      _cancelTransitionEndTimer();
    } else {
      onNextTransitionEnd(() {
        if (!_isUnmounted && state.transitionPhase == TransitionPhase.HIDING) {
          setState(newState()
            ..transitionPhase = TransitionPhase.HIDDEN
          );
        }
      });
    }
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `hidden` state.
  void handleHidden() {
    if (props.onDidHide != null) {
      props.onDidHide();
    }
  }


  /// Method that will be called when [AbstractTransitionComponent]  first enters the `shown` state.
  void handleShown() {
    if (props.onDidShow != null) {
      props.onDidShow();
    }
  }

  /// Returns attributes only available during testing that indicate the state of the transition.
  Map<String, String> getTransitionTestAttributes() {
    if (!component_base.UiProps.testMode) return const {};

    const enumToAttrValue = const <TransitionPhase, String>{
      TransitionPhase.SHOWN: 'shown',
      TransitionPhase.HIDDEN: 'hidden',
      TransitionPhase.HIDING: 'hiding',
      TransitionPhase.PRE_SHOWING: 'pre-showing',
      TransitionPhase.SHOWING: 'showing',
    };

    return {
      transitionPhaseTestAttr: enumToAttrValue[state.transitionPhase],
    };
  }

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------

  /// Shows the [AbstractTransitionComponent] by adding the CSS class that invokes a CSS transition.
  void show() {
    _handleShow();
  }

  /// Hides the [AbstractTransitionComponent] by removing the CSS class that invokes a CSS transition.
  void hide() {
    _handleHide();
  }

  /// Toggles the visibility of the [AbstractTransitionComponent] based on the value of [AbstractTransitionState.transitionPhase].
  void toggle() {
    if (isOrWillBeShown) {
      /// If the [AbstractTransitionComponent] is shown or in the process of showing, hide it.
      hide();
    } else if (isOrWillBeHidden) {
      /// If the [AbstractTransitionComponent] is hidden or in the process of hiding, show it.
      show();
    }
  }
}

/// The transition phase of the [AbstractTransitionComponent].
enum TransitionPhase {
  /// > SHOWN: The [AbstractTransitionComponent] is done transitioning to a visible / "shown" state.
  SHOWN,
  /// > HIDDEN: The [AbstractTransitionComponent] is done transitioning to a hidden state.
  HIDDEN,
  /// > HIDING: The CSS class that triggers transitions has been removed from the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  HIDING,
  /// > PRE_SHOWING: The [AbstractTransitionComponent] is mounted in the DOM, ready to be shown, and an `onTransitionEnd` listener is set up.
  PRE_SHOWING,
  /// > SHOWING: The CSS class that triggers transitions is added to the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  SHOWING
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class AbstractTransitionProps extends _$AbstractTransitionProps with _$AbstractTransitionPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForAbstractTransitionProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class AbstractTransitionState extends _$AbstractTransitionState with _$AbstractTransitionStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForAbstractTransitionState;
}
