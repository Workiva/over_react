library abstract_transition;

import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/src/ui_core/util/constants_base.dart';
import 'package:web_skin_dart/ui_core.dart';

@AbstractProps()
abstract class AbstractTransitionProps extends UiProps {
  Transition transition;

  /// Optional callback that fires before the [Alert] is dismissed.
  ///
  /// Returning `false` will cancel default behavior, and the [Alert] will remain visible.
  StateWillChangeCallback willDismiss;

  /// Optional callback that fires after the [Alert] is dismissed.
  StateDidChangeCallback didDismiss;

  /// Optional callback that fires before the [Alert] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [Alert] will not appear.
  StateWillChangeCallback willShow;

  /// Optional callback that fires after the [Alert] appears.
  StateDidChangeCallback didShow;
}

@AbstractState()
abstract class AbstractTransitionState extends UiState {
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
    ..transitionPhase = this.initiallyShown ? TransitionPhase.SHOWN : TransitionPhase.DISMISSED
  );

  /// Stream for listening to `transitionend` events on the [AbstractTransitionComponent].
  StreamSubscription _endTransitionSubscription;

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

  /// Begin dismissing the [AbstractTransitionComponent], unless:
  ///   * The [AbstractTransitionComponent] is already dismissed or is in the process of being dismissed.
  ///   * The [AbstractTransitionProps.willDismiss] callback returns `false`.
  void _handleDismiss(react.SyntheticEvent event) {
    if (state.transitionPhase == TransitionPhase.DISMISSING ||
        state.transitionPhase == TransitionPhase.DISMISSED) {
      return;
    }

    if (props.willDismiss != null && props.willDismiss(event, state) == false) {
      // Short-circuit default behavior if the callback cancelled this action by returning 'false'.
      return;
    }

    prepareDismiss();

    setState(newState()
      ..transitionPhase = props.transition != Transition.NONE ? TransitionPhase.DISMISSING : TransitionPhase.DISMISSED
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

  bool get shouldRender =>
      state.transitionPhase != TransitionPhase.DISMISSED;

  bool get isShown =>
      state.transitionPhase == TransitionPhase.SHOWN ||
      state.transitionPhase == TransitionPhase.SHOWING;

  // --------------------------------------------------------------------------
  // Lifecycle Methods
  // --------------------------------------------------------------------------

  @override
  void componentDidUpdate(Map prevProps, Map prevState, rootNode) {
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
        case TransitionPhase.DISMISSING:
          handleDismissing();
          break;
        case TransitionPhase.DISMISSED:
          handleDismissed();
          break;
        case TransitionPhase.SHOWN:
          handleShown();
          break;
      }
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


  /// Method that will be called right before the [AbstractTransitionComponent] begins to dismiss.
  void prepareDismiss() {}

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

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `dismissing` state.
  void handleDismissing() {
    _onNextTransitionEnd(() {
      if (state.transitionPhase == TransitionPhase.DISMISSING) {
        setState(newState()
          ..transitionPhase = TransitionPhase.DISMISSED
        );
      }
    });
  }

  /// Method that will be called when [AbstractTransitionComponent]  first enters the `dismissed` state.
  void handleDismissed() {}


  /// Method that will be called when [AbstractTransitionComponent]  first enters the `shown` state.
  void handleShown() {}

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------

  /// Shows the [AbstractTransitionComponent] by adding the CSS class that invokes a CSS transition.
  void show([react.SyntheticEvent event]) {
    _handleShow(event);
  }

  /// Dismisses the [AbstractTransitionComponent] by removing the CSS class that invokes a CSS transition.
  void dismiss([react.SyntheticEvent event]) {
    _handleDismiss(event);
  }

  /// Toggles the visibility of the [AbstractTransitionComponent] based on the value of [AbstractTransitionState.transitionPhase].
  void toggle([react.SyntheticEvent event]) {
    if (state.transitionPhase == TransitionPhase.SHOWN ||
        state.transitionPhase == TransitionPhase.PRE_SHOWING ||
        state.transitionPhase == TransitionPhase.SHOWING) {
      /// If the [Alert] is shown or in the process of showing, dismiss it.
      _handleDismiss(event);
    } else if (state.transitionPhase == TransitionPhase.DISMISSED ||
        state.transitionPhase == TransitionPhase.DISMISSING) {
      /// If the [Alert] is dismissed or in the process of dismissing, show it.
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
  // TODO: CHANGE THESE NAMES
  /// > SHOWN: The [AbstractTransitionComponent] is done transitioning to a visible / "shown" state.
  SHOWN,
  /// > DISMISSED: The [AbstractTransitionComponent] is done transitioning to a hidden / "dismissed" state.
  DISMISSED,
  /// > DISMISSING: The `in` CSS class has been removed from the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  DISMISSING,
  /// > PRE_SHOWING: The [AbstractTransitionComponent] is mounted in the DOM, ready to be shown, and an `onTransitionEnd` listener is set up.
  PRE_SHOWING,
  /// > SHOWING: The `in` CSS class is added to the [AbstractTransitionComponent], and an `onTransitionEnd` listener is active.
  SHOWING
}
