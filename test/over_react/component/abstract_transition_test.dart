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

library abstract_transition_test;

import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
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

          await new Future.delayed(Duration.ZERO);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()..hasTransition = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.hide();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        });
      });

      group('shows the component correctly when it', () {
        test('transitions', () async {
          var renderedInstance = render(Transitioner()..initiallyShown = false);
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.show();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await new Future.delayed(Duration.ZERO);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING),
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()
            ..initiallyShown = false
            ..hasTransition = false
          );
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.show();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });
      });

      group('toggles the component when it', () {
        test('transitions', () async {
          var renderedInstance = render(Transitioner());
          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

          await new Future.delayed(Duration.ZERO);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await new Future.delayed(Duration.ZERO);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING),
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
        });

        test('does not transition', () {
          var renderedInstance = render(Transitioner()..hasTransition = false);
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

          await new Future.delayed(Duration.ZERO);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING),
              reason: 'should still be waiting for a transition event');

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

          await new Future.microtask(() {});

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN),
              reason: 'Should have transitioned to HIDDEN in a microtask without waiting for a transitionend that may never occur');
        });
      });
    });

    group('waits for correct number of `onTransitionEnd` events when `transitionCount` is', () {
      test('1', () async {
        var renderedInstance = render(Transitioner()..transitionCount = 1);
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        transitioner.hide();

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await new Future.delayed(Duration.ZERO);
        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
            reason: 'should still be waiting for a transition event');

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
      });

      test('2', () async {
        var renderedInstance = render(Transitioner()..transitionCount = 2);
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        transitioner.hide();

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await new Future.delayed(Duration.ZERO);
        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
            reason: 'should still be waiting for a transition event');

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

        await new Future.delayed(Duration.ZERO);
        expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
              reason: 'should still be waiting for a transition event');

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
          ..onWillHide = (() => calls.add('willHide'))
          ..onDidHide = (() => calls.add('didHide'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.hide();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['willHide', 'didHide']));
      });

      test('showing', () async {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
          ..onWillShow = (() => calls.add('willShow'))
          ..onDidShow = (() => calls.add('didShow'))
        );
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.show();

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

        transitioner.show();

        await triggerTransitionEnd(transitioner.getTransitionDomNode());

        expect(calls, orderedEquals(['prepareShow', 'handlePreShowing', 'handleShowing', 'handleShown']));
      });
    });

    group('cancels default behavior when', () {
      test('willHide returns false', () {
        var renderedInstance = render(Transitioner()..onWillHide = (() => false));
        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

        transitioner.hide();

        expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));
      });

      test('willShow returns false', () {
        var renderedInstance = render(Transitioner()
          ..initiallyShown = false
          ..onWillShow = (() => false)
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

      group('transitionCount prop by', () {
        group('warning when', () {
          test('it is set to 0', () async {
            var renderedInstance = render(Transitioner()..transitionCount = 0);

            TransitionerComponent transitioner = getDartComponent(renderedInstance);

            transitioner.hide();

            await triggerTransitionEnd(transitioner.getTransitionDomNode());

            verifyValidationWarning('You have set `props.transitionCount` to an invalid option: 0. Instead of setting this prop to 0, override the `hasTransition` getter to return false.');
          });

          test('it is set to -1', () async {
            var renderedInstance = render(Transitioner()..transitionCount = -1);

            TransitionerComponent transitioner = getDartComponent(renderedInstance);

            transitioner.hide();

            await triggerTransitionEnd(transitioner.getTransitionDomNode());

            verifyValidationWarning('You have set `props.transitionCount` to an invalid option: -1.');
          });
        });

        test('not warning when it is set to 1', () async {
          var renderedInstance = render(Transitioner()..transitionCount = 1);

          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          transitioner.hide();

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          rejectValidationWarning(anything);
        });
      }, testOn: '!js');
    });

    test('times out after the duration specified in timeoutDuration has elapsed', () async {
      startRecordingValidationWarnings();

      var renderedInstance = render(Transitioner()
        ..transitionCount = 1
        ..transitionTimeout = const Duration(seconds: 0)
      );

      TransitionerComponent transitioner = getDartComponent(renderedInstance);

      expect(transitioner.state.transitionPhase, TransitionPhase.SHOWN);

      transitioner.hide();

      await new Future.delayed(Duration.ZERO);

      expect(transitioner.state.transitionPhase, TransitionPhase.HIDING);

      verifyValidationWarning(
        'The number of transitions expected to complete have not completed. Something is most likely wrong.'
      );

      stopRecordingValidationWarnings();
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

  bool hasTransition;
  bool initiallyShown;

  Duration transitionTimeout;
}

@State()
class TransitionerState extends AbstractTransitionState {}

@Component()
class TransitionerComponent extends AbstractTransitionComponent<TransitionerProps, TransitionerState> {
  @override
  Map getDefaultProps() => (newProps()
    ..addProps(super.getDefaultProps())
    ..hasTransition = true
    ..initiallyShown = true
    ..transitionTimeout = const Duration(seconds: 15)
  );


  @override
  Element getTransitionDomNode() => findDomNode(this);

  @override
  bool get initiallyShown => props.initiallyShown;

  @override
  bool get hasTransition => props.hasTransition;

  @override
  Duration get transitionTimeout => props.transitionTimeout;

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
    super.handleShown();

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
