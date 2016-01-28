library abstract_transition_test;

import 'dart:async';
import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../wsd_test_util/validation_util_helpers.dart';

/// Main entry point for AbstractTransition testing
main() {
  group('AbstractTransition', () {
    group('renders with correct initial state when the `initiallyShown` getter returns', () {
      test('true', () {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = true
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
      });

      test('false', () {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
      });
    });

    group('exposes a public API method that', () {
      group('hides the component correctly when it', () {
        test('transitions', () async {
          var renderedInstance = render(Transitioner());
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.hide();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()..transitions = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.hide();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        });
      });

      group('shows the component', () {
        test('transitions', () async {
          var renderedInstance = render(Transitioner()..initiallyShown = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.show();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()
            ..initiallyShown = false
            ..transitions = false
          );
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.hide();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });
      });

      group('toggles the component', () {
        test('transitions', () async {
          var renderedInstance = render(Transitioner());
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()..transitions = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });
      });

      group('toggles the component while it is', () {
        test('hiding', () async {
          var renderedInstance = render(Transitioner());
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });

        test('showing', () async {
          var renderedInstance = render(Transitioner()..initiallyShown = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        });
      });
    });

    group('waits for correct number of `onTransitionEnd` events when `transitionCount` is', () {
      test('1', () async {
        var renderedInstance = render(Transitioner()..transitionCount = 1);
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
      });

      test('2', () async {
        var renderedInstance = render(Transitioner()..transitionCount = 2);
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
      });
    });

    group('calls the appropriate callback(s) when it is', () {
      List calls;

      setUp(() {
        calls = [];
      });

      test('hiding', () async {
        var renderedInstance = render(Transitioner()
          ..willHide = (() => calls.add('willHide'))
          ..didHide = (() => calls.add('didHide'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.hide();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['willHide', 'didHide']));
      });

      test('showing', () async {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
          ..willShow = (() => calls.add('willShow'))
          ..didShow = (() => calls.add('didShow'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.hide();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['willShow', 'didShow']));
      });
    });

    group('calls the appropriate custom lifecyle method(s) when it is', () {
      List calls;

      setUp(() {
        calls = [];
      });

      test('hiding', () async {
        var renderedInstance = render(Transitioner()
          ..onPrepareHide = (() => calls.add('prepareHide'))
          ..onHandleHiding = (() => calls.add('handleHiding'))
          ..onHandleHidden = (() => calls.add('handleHidden'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.hide();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['prepareHide', 'handleHiding', 'handleHidden']));
      });

      test('showing', () async {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
          ..onPrepareShow = (() => calls.add('prepareShow'))
          ..onHandlePreShowing = (() => calls.add('handlePreShowing'))
          ..onHandleShowing = (() => calls.add('handleShowing'))
          ..onHandleShown = (() => calls.add('handleShown'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.hide();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['prepareShow', 'handlePreShowing', 'handleShowing', 'handleShown']));
      });
    });

    group('cancels default behavior when', () {
      test('willHide returns false', () {
        var renderedInstance = render(Transitioner()..willHide = (() => false));
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        transitioner.hide();

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
      });

      test('willShow returns false', () {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
          ..willHide = (() => false)
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

        transitioner.show();

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
      });
    });

    group('validates the', () {
      bool warningsWereEnabled;
      setUp(() {
        warningsWereEnabled = ValidationUtil.WARNINGS_ENABLED;
        ValidationUtil.WARNINGS_ENABLED = false;
        startRecordingValidationWarnings();
      });

      tearDown(() {
        ValidationUtil.WARNINGS_ENABLED = warningsWereEnabled;
        stopRecordingValidationWarnings();
      });

      test('transitionCount prop by', () {
        group('warning when', () {
          test('it is set to 0', () {
            render(Transitioner()..transitionCount = 0);

            verifyValidationWarning('You have set `props.transitionCount` to an invalid option: 0. Instead of setting this prop to 0, override the `transitions` getter to return false.');
          });

          test('it is set to -1', () {
            render(Transitioner()..transitionCount = -1);

            verifyValidationWarning('You have set `props.transitionCount` to an invalid option: -1.');
          });
        });

        test('not warning when it is set to 1', () {
          render(Transitioner()..transitionCount = 0);

          rejectValidationWarning(anything);
        });
      });
    });
  });
}

@Factory()
UiFactory<TransitionerProps> Transitioner;

@Props()
class TransitionerProps extends AbstractTransitionProps {
  Callback onHandlePreShowing;
  Callback onHandleShowing;
  Callback onHandleShown;
  Callback onHandleHiding;
  Callback onHandleHidden;

  Callback onPrepareShow;
  Callback onPrepareHide;

  bool transitions;
  bool initiallyShown;
}

@State()
class TransitionerState extends AbstractTransitionState {}

@Component()
class TransitionerComponent extends AbstractTransitionComponent<TransitionerProps, TransitionerState> {
  @override
  Map getDefaultProps() => (newProps()
    ..transitions = true
    ..initiallyShown = true
  );


  @override
  Element getTransitionDomNode() => getDOMNode();

  @override
  bool get initiallyShown => props.initiallyShown;

  @override
  bool get transitions => props.transitions;

  @override
  render() {
    return Dom.div()();
  }

  @override
  void prepareShow() {
    if (props.onPrepareShow != null) {
      props.onPrepareShow();
    }
  }

  @override
  void prepareHide() {
    if (props.onPrepareHide != null) {
      props.onPrepareHide();
    }
  }

  @override
  void handlePreShowing() {
    super.handlePreShowing();

    if (props.onHandlePreShowing != null) {
      props.onHandlePreShowing();
    }
  }

  @override
  void handleShowing() {
    super.handleShowing();

    if (props.onHandleShowing != null) {
      props.onHandleShowing();
    }
  }

  @override
  void handleShown() {
    super.handleShowing();

    if (props.onHandleShown != null) {
      props.onHandleShown();
    }
  }

  @override
  void handleHiding() {
    super.handleHiding();

    if (props.onHandleHiding != null) {
      props.onHandleHiding();
    }
  }

  @override
  void handleHidden() {
    super.handleHidden();

    if (props.onHandleHidden != null) {
      props.onHandleHidden();
    }
  }
}
