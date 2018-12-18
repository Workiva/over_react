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

import 'package:dart2_constant/core.dart' as d2c;
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

// ignore: uri_has_not_been_generated
part 'abstract_transition_test.over_react.g.dart';

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

          await new Future.delayed(d2c.Duration.zero);
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

          await new Future.delayed(d2c.Duration.zero);
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

          await new Future.delayed(d2c.Duration.zero);
          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(transitioner.getTransitionDomNode());

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.toggle();

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

          await new Future.delayed(d2c.Duration.zero);
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

          await new Future.delayed(d2c.Duration.zero);
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

      group('shows and hides the component properly, waiting for correct number of `onTransitionEnd` when the number of transitions', () {
        Future<Null> sharedTests(renderedInstance, {@required int expectedTransitionInCount, @required int expectedTransitionOutCount}) async {
          if (expectedTransitionInCount < 0) throw new ArgumentError.value(expectedTransitionInCount, 'expectedTransitionInCount', 'must be greater than 0');
          if (expectedTransitionOutCount < 0) throw new ArgumentError.value(expectedTransitionOutCount, 'expectedTransitionOutCount', 'must be greater than 0');

          TransitionerComponent transitioner = getDartComponent(renderedInstance);

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));

          transitioner.show();

          if (expectedTransitionInCount != 0) {
            expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING));

            for (var i = 0; i < expectedTransitionInCount; i++) {
              await new Future.delayed(d2c.Duration.zero);
              expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWING),
                  reason: 'should still be waiting for a transition event');

              await triggerTransitionEnd(transitioner.getTransitionDomNode());
            }
          }

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.SHOWN));

          transitioner.hide();

          if (expectedTransitionOutCount != 0) {
            expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING));

            for (var i = 0; i < expectedTransitionOutCount; i++) {
              await new Future.delayed(d2c.Duration.zero);
              expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDING),
                  reason: 'should still be waiting for a transition event');

              await triggerTransitionEnd(transitioner.getTransitionDomNode());
            }
          }

          expect(transitioner.state.transitionPhase, equals(TransitionPhase.HIDDEN));
        }

        group('is specified via props.transitionCount and is', () {
          test('less than 0 (should behave like 0)', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = -2
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 0,
            );
          });

          test('null (should behave like the default, 1, for backwards compatibility)', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = null
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 1,
              expectedTransitionOutCount: 1,
            );
          });

          test('0', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = 0
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 0,
            );
          });

          test('1', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = 1
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 1,
              expectedTransitionOutCount: 1,
            );
          });

          test('2', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = 2
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 2,
            );
          });
        });

        group('is specified via props.transitionCount and', () {
          test('props.transitionInCount', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = 3
              ..transitionInCount = 2
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 3,
            );
          });

          test('props.transitionOutCount', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionCount = 2
              ..transitionOutCount = 3
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 3,
            );
          });
        });

        test('is specified via props.transitionInCount props.transitionOutCount:', () async {
          var renderedInstance = render(Transitioner()
            ..initiallyShown = false
            ..transitionInCount = 2
            ..transitionOutCount = 3
          );
          await sharedTests(renderedInstance,
            expectedTransitionInCount: 2,
            expectedTransitionOutCount: 3,
          );
        });

        group('is zero for only one of showing/hiding:', () {
          test('zero for showing', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionInCount = 0
              ..transitionOutCount = 3
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 3,
            );
          });

          test('zero for hiding', () async {
            var renderedInstance = render(Transitioner()
              ..initiallyShown = false
              ..transitionInCount = 2
              ..transitionOutCount = 0
            );
            await sharedTests(renderedInstance,
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 0,
            );
          });
        });
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

    group('time out', () {
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

      test('occurs after the duration specified in timeoutDuration has elapsed', () async {
        var renderedInstance = render(Transitioner()
          ..transitionCount = 1
          ..transitionTimeout = const Duration(seconds: 0)
        );

        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        expect(transitioner.state.transitionPhase, TransitionPhase.SHOWN);

        transitioner.hide();

        expect(transitioner.state.transitionPhase, TransitionPhase.HIDING);

        await new Future.delayed(d2c.Duration.zero);

        expect(transitioner.state.transitionPhase, TransitionPhase.HIDDEN);

        verifyValidationWarning(
          'The number of transitions expected to complete have not completed. Something is most likely wrong.'
        );
      });

      test('does not occur when shown and hidden rapidly', () async {
        var renderedInstance = render(Transitioner()..initiallyShown = false);

        TransitionerComponent transitioner = getDartComponent(renderedInstance);

        transitioner.show();

        expect(transitioner.state.transitionPhase, TransitionPhase.SHOWING);

        transitioner.hide();

        expect(transitioner.state.transitionPhase, TransitionPhase.HIDING);

        await new Future.microtask(() {});

        expect(transitioner.state.transitionPhase, TransitionPhase.HIDDEN);

        rejectValidationWarning(anything);
      });
    }, testOn: '!js');

    test('does not set hidden state when not mounted', () async {
      var renderedInstance = render(Transitioner());
      TransitionerComponent transitioner = getDartComponent(renderedInstance);
      transitioner.setState(transitioner.newState()..transitionPhase = TransitionPhase.HIDING);

      transitioner.handleHiding();
      transitioner.componentWillUnmount();
      await triggerTransitionEnd(transitioner.getTransitionDomNode());

      expect(transitioner.transitionPhasesSet, orderedEquals([TransitionPhase.HIDING]));
    });

    group('getTransitionTestAttributes returns attributes that indicate the state of the transition in component', () {
      const transitionPhaseTestAttr = AbstractTransitionComponent.transitionPhaseTestAttr;

      group('when the transition state is', () {
        test('PRE_SHOWING', () async {
          // Have to use MutationObserver since setting the state to PRE_SHOWING
          // synchronously updates the state to SHOWING.
          var transitionAttrMutations = <List<String>>[];

          // List<dynamic> is being used to work around a Dart HTML internals issue in the DDC
          var observer = new MutationObserver((List<dynamic> records, observer) {
            for (var record in records) {
              if (record.attributeName != transitionPhaseTestAttr) continue;
              transitionAttrMutations.add([
                record.oldValue,
                // ignore: avoid_as
                (record.target as Element).attributes[record.attributeName],
              ]);
            }
          });
          addTearDown(observer.disconnect);

          var jacket = mount<TransitionerComponent>(Transitioner()(), attachedToDocument: true);
          observer.observe(jacket.getNode(), attributes: true, attributeOldValue: true);

          var component = jacket.getDartInstance();
          component.setState(component.newState()..transitionPhase = TransitionPhase.PRE_SHOWING);

          // Wait for MutationObserver callback to fire.
          await new Future(() {});

          expect(transitionAttrMutations, contains(equals(
              // We can't catch the overlay getting its attribute changed to `pre-showing` for some reason,
              // so we'll just have to verify that the old value used to be `pre-showing`.
              ['pre-showing', 'showing']
          )));
        });

        test('SHOWING', () {
          var jacket = mount<TransitionerComponent>(Transitioner()());
          var component = jacket.getDartInstance();

          component.setState(component.newState()..transitionPhase = TransitionPhase.SHOWING);

          expect(jacket.getNode(), hasAttr(transitionPhaseTestAttr, 'showing'));
        });

        test('SHOWN', () {
          var jacket = mount<TransitionerComponent>(Transitioner()());

          expect(jacket.getNode(), hasAttr(transitionPhaseTestAttr, 'shown'));
        });

        test('HIDING', () {
          var jacket = mount<TransitionerComponent>(Transitioner()());
          var component = jacket.getDartInstance();

          component.setState(component.newState()..transitionPhase = TransitionPhase.HIDING);

          expect(jacket.getNode(), hasAttr(transitionPhaseTestAttr, 'hiding'));
        });

        test('HIDDEN', () {
          var jacket = mount<TransitionerComponent>(Transitioner()());
          var component = jacket.getDartInstance();

          component.setState(component.newState()..transitionPhase = TransitionPhase.HIDDEN);

          expect(jacket.getNode(), hasAttr(transitionPhaseTestAttr, 'hidden'));
        });
      });

      test('unless test mode is disabled', () {
        disableTestMode();
        addTearDown(enableTestMode);

        var jacket = mount<TransitionerComponent>(Transitioner()());

        expect(jacket.getNode().attributes, isNot(contains(transitionPhaseTestAttr)));
      });
    });
  });
}

@Factory()
// ignore: undefined_identifier
UiFactory<TransitionerProps> Transitioner = $Transitioner;

@Props()
class _$TransitionerProps extends AbstractTransitionProps {
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
class _$TransitionerState extends AbstractTransitionState {}

@Component()
class TransitionerComponent extends AbstractTransitionComponent<TransitionerProps, TransitionerState> {
  @override
  Map getDefaultProps() => (newProps()
    ..addProps(super.getDefaultProps())
    ..hasTransition = true
    ..initiallyShown = true
    ..transitionTimeout = const Duration(seconds: 1)
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
    return (Dom.div()
      ..addProps(getTransitionTestAttributes())
    )();
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

  List<TransitionPhase> transitionPhasesSet = [];

  @override
  void setState(dynamic newState, [callback()]) {
    super.setState(newState, callback);
    transitionPhasesSet.add(newState.transitionPhase);
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TransitionerProps extends _$TransitionerProps with _$TransitionerPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTransitionerProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TransitionerState extends _$TransitionerState with _$TransitionerStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForTransitionerState;
}
