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

library abstract_transition;

import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';

@AbstractProps()
abstract class AbstractTransitionProps extends UiProps {
  /// Number of transitions to occur within the [AbstractTransitionComponent].
  ///
  /// _If the [AbstractTransitionComponent] does not transition set [AbstractTransitionProps.transition] to [Transition.NONE] rather than setting this to 0._
  ///
  /// Default: 1
  int transitionCount;

  /// Optional callback that fires before the [AbstractTransitionComponent] is hidden.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will remain visible.
  Callback onWillHide;

  /// Optional callback that fires after the [AbstractTransitionComponent] is hidden.
  Callback onDidHide;

  /// Optional callback that fires before the [AbstractTransitionComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will not appear.
  Callback onWillShow;

  /// Optional callback that fires after the [AbstractTransitionComponent] appears.
  Callback onDidShow;
}

@AbstractState()
abstract class AbstractTransitionState extends UiState {
  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionState.SHOWN] : [TransitionState.HIDDEN]
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
abstract class AbstractTransitionComponent<T extends AbstractTransitionProps, S extends AbstractTransitionState> extends UiStatefulComponent<T, S> {
  @override
  Map getDefaultProps() => (newProps()
    ..transitionCount = 1
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

  /// Whether the Element returned by [getTransitionDomNode] will have a transition event.
  bool get hasTransition => true;

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
      ..transitionPhase = hasTransition ? TransitionPhase.PRE_SHOWING : TransitionPhase.SHOWN
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
      ..transitionPhase = hasTransition ? TransitionPhase.HIDING : TransitionPhase.HIDDEN
    );
  }

  /// Listens for the next `transitionend` event and invokes a callback after
  /// the event is dispatched.
  void onNextTransitionEnd(complete()) {
    var skipCount = props.transitionCount - 1;

    if (props.transitionCount <= 0) {
      var warningMessage = 'You have set `props.transitionCount` to an invalid option: ${props.transitionCount}.';

      if (props.transitionCount == 0) {
        warningMessage += ' Instead of setting this prop to 0, override the `hasTransition` getter to return false.';
      }

      assert(ValidationUtil.warn(warningMessage));

      skipCount = 0;
    }

    _transitionEndTimer = new Timer(transitionTimeout, () {
      assert(ValidationUtil.warn(
        'The number of transitions expected to complete have not completed. Something is most likely wrong.'
      ));

      _cancelTransitionEventListener();
      
      complete();
    });

    _endTransitionSubscription = getTransitionDomNode()?.onTransitionEnd?.skip(skipCount)?.take(1)?.listen((_) {
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

  @override
  void componentWillUnmount() {
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

      _cancelTransitionEndTimer();
    } else {
      onNextTransitionEnd(() {
        if (state.transitionPhase == TransitionPhase.HIDING) {
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
