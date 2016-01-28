library abstract_transition;

import 'dart:async';
import 'dart:html';

import 'package:web_skin_dart/ui_core.dart';

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
  Callback willHide;

  /// Optional callback that fires after the [AbstractTransitionComponent] is hidden.
  Callback didHide;

  /// Optional callback that fires before the [AbstractTransitionComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will not appear.
  Callback willShow;

  /// Optional callback that fires after the [AbstractTransitionComponent] appears.
  Callback didShow;
}

@AbstractState()
abstract class AbstractTransitionState extends UiState {
  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionState.SHOWN] : [TransitionState.HIDDEN]
  TransitionPhase transitionPhase;
}

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

  /// Returns whether the Element return by [getTransitionDomNode] will have a transition event.
  bool get transitions => true;

  // --------------------------------------------------------------------------
  // Private Utility Methods
  // --------------------------------------------------------------------------

  /// Begin showing the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already shown or is in the process of showing.
  ///   * The [AbstractTransitionProps.willShow] callback returns `false`.
  void _handleShow() {
    if (isOrWillBeShown) {
      return;
    }

    if (props.willShow != null && props.willShow() == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareShow();

    setState(newState()
      ..transitionPhase = transitions ? TransitionPhase.PRE_SHOWING : TransitionPhase.SHOWN
    );
  }

  /// Begin hiding the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already hidden or is in the process of being hidden.
  ///   * The [AbstractTransitionProps.willHide] callback returns `false`.
  void _handleHide() {
    if (isOrWillBeHidden) {
      return;
    }

    if (props.willHide != null && props.willHide() == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareHide();

    setState(newState()
      ..transitionPhase = transitions ? TransitionPhase.HIDING : TransitionPhase.HIDDEN
    );
  }

  /// Listens for the next `transitionend` event and invokes a callback after
  /// the event is dispatched.
  void onNextTransitionEnd(complete()) {
    if (props.transitionCount <= 0) {
      var warningMessage = 'You have set `props.transitionCount` to an invalid option: ${props.transitionCount}.';

      if (props.transitionCount == 0) {
        warningMessage += ' Instead of setting this prop to 0, override the `transitions` getter to return false.';
      }

      assert(ValidationUtil.warn(warningMessage));

      return;
    }

    _endTransitionSubscription = getTransitionDomNode()?.onTransitionEnd?.skip(props.transitionCount - 1)?.take(1)?.listen((_) {
      complete();
    });
  }

  void _cancelTransitionEventListener() {
    _endTransitionSubscription?.cancel();
    _endTransitionSubscription = null;
  }

  void _handleTransitionPhase(TransitionPhase phase) {
    switch (phase) {
      case TransitionPhase.PRE_SHOWING:
        handlePreShowing();
        break;
      case TransitionPhase.SHOWING:
        handleShowing();
        break;
      case TransitionPhase.HIDING:
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

  bool get shouldRender =>
      state.transitionPhase != TransitionPhase.HIDDEN;

  bool get isShown =>
      state.transitionPhase == TransitionPhase.SHOWN ||
      state.transitionPhase == TransitionPhase.SHOWING;

  bool get isOrWillBeHidden =>
      state.transitionPhase == TransitionPhase.HIDING ||
      state.transitionPhase == TransitionPhase.HIDDEN;

  bool get isOrWillBeShown =>
      state.transitionPhase == TransitionPhase.PRE_SHOWING ||
      state.transitionPhase == TransitionPhase.SHOWING ||
      state.transitionPhase == TransitionPhase.SHOWN;

  // --------------------------------------------------------------------------
  // Lifecycle Methods
  // --------------------------------------------------------------------------

  @override
  void componentDidMount(rootNode) {
    _handleTransitionPhase(state.transitionPhase);
  }

  @override
  void componentDidUpdate(Map prevProps, Map prevState, rootNode) {
    var tPrevState = typedStateFactory(prevState);

    if (tPrevState.transitionPhase != state.transitionPhase) {
      if (state.transitionPhase != TransitionPhase.SHOWING) {
        // Allows the AbstractTransitionComponent to handle state changes that interrupt state
        // changes waiting on transitionend events.
        _cancelTransitionEventListener();
      }

      _handleTransitionPhase(state.transitionPhase);
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

    // Force a repaint by accessing `offsetHeight` so that the 'in' class is guaranteed to trigger a transition when it is applied
    getTransitionDomNode()?.offsetHeight;

    setState(newState()
      ..transitionPhase = TransitionPhase.SHOWING
    );
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `showing` state.
  void handleShowing() {}

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `hiding` state.
  void handleHiding() {
    onNextTransitionEnd(() {
      if (state.transitionPhase == TransitionPhase.HIDING) {
        setState(newState()
          ..transitionPhase = TransitionPhase.HIDDEN
        );
      }
    });
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `hidden` state.
  void handleHidden() {
    if (props.didHide != null) {
      props.didHide();
    }
  }


  /// Method that will be called when [AbstractTransitionComponent]  first enters the `shown` state.
  void handleShown() {
    if (props.didShow != null) {
      props.didShow();
    }
  }

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------

  /// Shows the [AbstractTransitionComponent] by adding the CSS class that invokes a CSS transition.
  void show([dynamic payload]) {
    _handleShow();
  }

  /// Hides the [AbstractTransitionComponent] by removing the CSS class that invokes a CSS transition.
  void hide([dynamic payload]) {
    _handleHide();
  }

  /// Toggles the visibility of the [AbstractTransitionComponent] based on the value of [AbstractTransitionState.transitionPhase].
  void toggle([dynamic payload]) {
    if (isOrWillBeShown) {
      /// If the [AbstractTransitionComponent] is shown or in the process of showing, hide it.
      hide(payload);
    } else if (isOrWillBeHidden) {
      /// If the [AbstractTransitionComponent] is hidden or in the process of hiding, show it.
      show(payload);
    }
  }
}

/// The transition phase of the [AbstractTransitionComponent].
enum TransitionPhase {
  /// > SHOWN: The [AbstractTransitionComponent] is done transitioning to a visible / "shown" state.
  SHOWN,
  /// > HIDDEN: The [AbstractTransitionComponent] is done transitioning to a hidden state.
  HIDDEN,
  /// > HIDING: The `in` CSS class has been removed from the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  HIDING,
  /// > PRE_SHOWING: The [AbstractTransitionComponent] is mounted in the DOM, ready to be shown, and an `onTransitionEnd` listener is set up.
  PRE_SHOWING,
  /// > SHOWING: The `in` CSS class is added to the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  SHOWING
}
