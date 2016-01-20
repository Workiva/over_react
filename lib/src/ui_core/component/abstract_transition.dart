library abstract_transition;

import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/src/ui_core/util/constants_base.dart';
import 'package:web_skin_dart/ui_core.dart';

@AbstractProps()
abstract class AbstractTransitionProps extends UiProps {
  /// The type of CSS transition that will be used when the [AbstractTransitonComponent] appears / disappears.
  ///
  /// Default: [Transition.NONE]
  Transition transition;

  /// Optional callback that fires before the [AbstractTransitonComponent] is hidden.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitonComponent] will remain visible.
  StateWillChangeCallback willHide;

  /// Optional callback that fires after the [AbstractTransitonComponent] is hidden.
  StateDidChangeCallback didHide;

  /// Optional callback that fires before the [AbstractTransitonComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitonComponent] will not appear.
  StateWillChangeCallback willShow;

  /// Optional callback that fires after the [AbstractTransitonComponent] appears.
  StateDidChangeCallback didShow;
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
    ..transition = Transition.NONE
  );

  @override
  Map getInitialState() => (newState()
    ..transitionPhase = this.initiallyShown ? TransitionPhase.SHOWN : TransitionPhase.HIDDEN
  );

  /// Stream for listening to `transitionend` events on the [AbstractTransitionComponent].
  StreamSubscription _endTransitionSubscription;

  /// Whether the [AbstractTransitionComponent] should be visible initially when mounted.
  bool get initiallyShown;

  // --------------------------------------------------------------------------
  // Private Utility Methods
  // --------------------------------------------------------------------------

  /// Begin showing the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already shown or is in the process of showing.
  ///   * The [AbstractTransitionProps.willShow] callback returns `false`.
  void _handleShow(react.SyntheticEvent event) {
    if (state.transitionPhase == TransitionPhase.PRE_SHOWING ||
        state.transitionPhase == TransitionPhase.SHOWING ||
        state.transitionPhase == TransitionPhase.SHOWN) {
      return;
    }

    if (props.willShow != null && props.willShow(event, state) == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareShow();

    setState(newState()
      ..transitionPhase = props.transition != Transition.NONE ? TransitionPhase.PRE_SHOWING : TransitionPhase.SHOWN
    );
  }

  /// Begin hiding the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already hidden or is in the process of being hidden.
  ///   * The [AbstractTransitionProps.willHide] callback returns `false`.
  void _handleHide(react.SyntheticEvent event) {
    if (state.transitionPhase == TransitionPhase.HIDING ||
        state.transitionPhase == TransitionPhase.HIDDEN) {
      return;
    }

    if (props.willHide != null && props.willHide(event, state) == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareHide();

    setState(newState()
      ..transitionPhase = props.transition != Transition.NONE ? TransitionPhase.HIDING : TransitionPhase.HIDDEN
    );
  }

  /// Listens for the next `transitionend` event and invokes a callback after
  /// the event is dispatched.
  void _onNextTransitionEnd(complete()) {
    _endTransitionSubscription = getDOMNode().onTransitionEnd.take(1).listen((_) {
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
  void componenWillUnmount() {
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
    _onNextTransitionEnd(() {
      if (state.transitionPhase == TransitionPhase.SHOWING) {
        setState(newState()
          ..transitionPhase = TransitionPhase.SHOWN
        );
      }
    });

    // Force a repaint by accessing `offsetHeight` so that the 'in' class is guaranteed to trigger a transition when it is applied
    getDOMNode().offsetHeight;

    setState(newState()
      ..transitionPhase = TransitionPhase.SHOWING
    );
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `showing` state.
  void handleShowing() {}

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `hiding` state.
  void handleHiding() {
    _onNextTransitionEnd(() {
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
      props.didHide(null, prevState);
    }
  }


  /// Method that will be called when [AbstractTransitionComponent]  first enters the `shown` state.
  void handleShown() {
    if (props.didShow != null) {
      props.didShow(null, prevState);
    }
  }

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------

  /// Shows the [AbstractTransitionComponent] by adding the CSS class that invokes a CSS transition.
  void show([react.SyntheticEvent event]) {
    _handleShow(event);
  }

  /// Hides the [AbstractTransitionComponent] by removing the CSS class that invokes a CSS transition.
  void hide([react.SyntheticEvent event]) {
    _handleHide(event);
  }

  /// Toggles the visibility of the [AbstractTransitionComponent] based on the value of [AbstractTransitionState.transitionPhase].
  void toggle([react.SyntheticEvent event]) {
    if (state.transitionPhase == TransitionPhase.SHOWN ||
        state.transitionPhase == TransitionPhase.PRE_SHOWING ||
        state.transitionPhase == TransitionPhase.SHOWING) {
      /// If the [AbstractTransitionComponent] is shown or in the process of showing, hide it.
      _handleHide(event);
    } else if (state.transitionPhase == TransitionPhase.HIDDEN ||
        state.transitionPhase == TransitionPhase.HIDING) {
      /// If the [AbstractTransitionComponent] is hidden or in the process of hiding, show it.
      _handleShow(event);
    }
  }
}

class Transition extends ClassNameConstant {
  const Transition(String name, String className) : super(name, className);

  /// The [AbstractTransitionComponent] will appear / disappear with no CSS transition.
  ///
  /// [className] value: null
  static const Transition NONE = const Transition('NONE', null);
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
