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
@TestOn('browser')
library with_transition_test;

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart' hide TransitionPropsMixin, $TransitionPropsMixin, AbstractTransitionProps, AbstractTransitionState, AbstractTransitionComponent;
import 'package:over_react/components.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

part 'with_transition_test.over_react.g.dart';

/// Main entry point for WithTransition testing
main() {
  group('WithTransition', () {
    TestJacket<WithTransitionTesterComponent> jacket;
    Element getRootNode() => queryByTestId(jacket.mountNode, 'or.WithTransition.node');
    void expectNodeInTransitionPhase(TransitionPhase phase, {String reason}) {
      expect(
        getRootNode(),
        hasAttr(WithTransitionTesterComponent.attrName, WithTransitionTesterComponent.testAttrByPhase[phase]),
        reason: reason,
      );
    }

    tearDown(() {
      jacket = null;
    });

    group('renders correct initially when props.isShown is', () {
      test('true', () {
        jacket = mount((WithTransitionTester()..isShown = true)());
        expectNodeInTransitionPhase(TransitionPhase.SHOWN);
      });

      test('false', () {
        jacket = mount((WithTransitionTester()..isShown = false)());
        expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
      });
    });

    group('props.isShown', () {
      group('hides the component when changed from true to false', () {
        test('when the component transitions', () async {
          jacket = mount((WithTransitionTester()..isShown = true)());
          expectNodeInTransitionPhase(TransitionPhase.SHOWN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()..isShown = false)());
          expectNodeInTransitionPhase(TransitionPhase.HIDING);

          await Future.delayed(Duration.zero);
          expectNodeInTransitionPhase(TransitionPhase.HIDING,
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(getRootNode());

          expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
        });

        test('when the component does not transition', () {
          jacket = mount((WithTransitionTester()
            ..transitionCount = 0
            ..isShown = true
          )());
          expectNodeInTransitionPhase(TransitionPhase.SHOWN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()
            ..transitionCount = 0
            ..isShown = false
          )());
          expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
        });
      });

      group('shows the component when changed from false to true', () {
        test('when the component transitions', () async {
          jacket = mount((WithTransitionTester()..isShown = false)());
          expectNodeInTransitionPhase(TransitionPhase.HIDDEN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()..isShown = true)());
          expectNodeInTransitionPhase(TransitionPhase.SHOWING);

          await Future.delayed(Duration.zero);
          expectNodeInTransitionPhase(TransitionPhase.SHOWING,
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(getRootNode());

          expectNodeInTransitionPhase(TransitionPhase.SHOWN);
        });

        test('when the component does not transition', () {
          jacket = mount((WithTransitionTester()
            ..transitionCount = 0
            ..isShown = false
          )());
          expectNodeInTransitionPhase(TransitionPhase.HIDDEN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()
            ..transitionCount = 0
            ..isShown = true
          )());
          expectNodeInTransitionPhase(TransitionPhase.SHOWN);
        });
      });

      group('toggles the visibility of the component when it has not yet finished', () {
        test('hiding', () async {
          jacket = mount((WithTransitionTester()..isShown = true)());
          expectNodeInTransitionPhase(TransitionPhase.SHOWN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()..isShown = false)());
          expectNodeInTransitionPhase(TransitionPhase.HIDING);

          jacket.rerender((WithTransitionTester()..isShown = true)());
          expectNodeInTransitionPhase(TransitionPhase.SHOWING);

          await Future.delayed(Duration.zero);
          expectNodeInTransitionPhase(TransitionPhase.SHOWING,
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(getRootNode());
          expectNodeInTransitionPhase(TransitionPhase.SHOWN);
        });

        test('showing', () async {
          jacket = mount((WithTransitionTester()..isShown = false)());
          expectNodeInTransitionPhase(TransitionPhase.HIDDEN, reason: 'test setup sanity check');

          jacket.rerender((WithTransitionTester()..isShown = true)());
          expectNodeInTransitionPhase(TransitionPhase.SHOWING);

          jacket.rerender((WithTransitionTester()..isShown = false)());
          expectNodeInTransitionPhase(TransitionPhase.HIDING);

          await Future.delayed(Duration.zero);
          expectNodeInTransitionPhase(TransitionPhase.HIDING,
              reason: 'should still be waiting for a transition event');

          await triggerTransitionEnd(getRootNode());
          expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
        });
      });

      group('toggles the visibility of the component properly, waiting for correct number of `onTransitionEnd` when the number of transitions', () {
        Future<Null> sharedTests(ReactElement renderedElement, {
          @required int expectedTransitionInCount,
          @required int expectedTransitionOutCount,
        }) async {
          if (expectedTransitionInCount < 0) throw ArgumentError.value(expectedTransitionInCount, 'expectedTransitionInCount', 'must be greater than 0');
          if (expectedTransitionOutCount < 0) throw ArgumentError.value(expectedTransitionOutCount, 'expectedTransitionOutCount', 'must be greater than 0');

          jacket = mount(renderedElement);

          expectNodeInTransitionPhase(TransitionPhase.HIDDEN, reason: 'test setup sanity check');

          jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = true));

          if (expectedTransitionInCount != 0) {
            expectNodeInTransitionPhase(TransitionPhase.SHOWING);

            for (var i = 0; i < expectedTransitionInCount; i++) {
              await Future.delayed(Duration.zero);
              expectNodeInTransitionPhase(TransitionPhase.SHOWING,
                  reason: 'should still be waiting for a transition event');

              await triggerTransitionEnd(getRootNode());
            }
          }

          expectNodeInTransitionPhase(TransitionPhase.SHOWN);

          jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = false));

          if (expectedTransitionOutCount != 0) {
            expectNodeInTransitionPhase(TransitionPhase.HIDING);

            for (var i = 0; i < expectedTransitionOutCount; i++) {
              await Future.delayed(Duration.zero);
              expectNodeInTransitionPhase(TransitionPhase.HIDING,
                  reason: 'should still be waiting for a transition event');

              await triggerTransitionEnd(getRootNode());
            }
          }

          expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
        }

        group('is specified via props.transitionCount and is', () {
          test('less than 0 (should behave like 0)', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = -2)(),
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 0,
            );
          });

          test('null (should behave like the default, 1, for backwards compatibility)', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = null)(),
              expectedTransitionInCount: 1,
              expectedTransitionOutCount: 1,
            );
          });

          test('0', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = 0)(),
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 0,
            );
          });

          test('1', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = 1)(),
              expectedTransitionInCount: 1,
              expectedTransitionOutCount: 1,
            );
          });

          test('2', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = 2)(),
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 2,
            );
          });
        });

        group('is specified via props.transitionCount and', () {
          test('props.transitionInCount', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = 3
              ..transitionInCount = 2)(),
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 3,
            );
          });

          test('props.transitionOutCount', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionCount = 2
              ..transitionOutCount = 3)(),
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 3,
            );
          });
        });

        test('is specified via props.transitionInCount props.transitionOutCount:', () async {
          await sharedTests((WithTransitionTester()
            ..isShown = false
            ..transitionInCount = 2
            ..transitionOutCount = 3)(),
            expectedTransitionInCount: 2,
            expectedTransitionOutCount: 3,
          );
        });

        group('is zero for only one of showing/hiding:', () {
          test('zero for showing', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionInCount = 0
              ..transitionOutCount = 3)(),
              expectedTransitionInCount: 0,
              expectedTransitionOutCount: 3,
            );
          });

          test('zero for hiding', () async {
            await sharedTests((WithTransitionTester()
              ..isShown = false
              ..transitionInCount = 2
              ..transitionOutCount = 0)(),
              expectedTransitionInCount: 2,
              expectedTransitionOutCount: 0,
            );
          });
        });
      });
    });

    group('calls the appropriate callback(s) when it is', () {
      List calls;
      ReactElement elementWithCallbacks;

      setUp(() {
        calls = [];
        elementWithCallbacks = (WithTransitionTester()
          ..onWillHide = (() => calls.add('onWillHide'))
          ..onDidHide = (() => calls.add('onDidHide'))
          ..onWillShow = (() => calls.add('onWillShow'))
          ..onDidShow = (() => calls.add('onDidShow'))
        )();
      });

      tearDown(() {
        elementWithCallbacks = null;
      });

      test('hiding', () async {
        jacket = mount(cloneElement(elementWithCallbacks, WithTransitionTester()..isShown = true));
        expect(calls, isEmpty, reason: 'test setup sanity check');

        jacket.rerender(cloneElement(elementWithCallbacks, WithTransitionTester()..isShown = false));
        await triggerTransitionEnd(getRootNode());

        expect(calls, orderedEquals(['onWillHide', 'onDidHide']));
      });

      test('showing', () async {
        jacket = mount(cloneElement(elementWithCallbacks, WithTransitionTester()..isShown = false));
        expect(calls, isEmpty, reason: 'test setup sanity check');

        jacket.rerender(cloneElement(elementWithCallbacks, WithTransitionTester()..isShown = true));
        await triggerTransitionEnd(getRootNode());

        expect(calls, orderedEquals(['onWillShow', 'onDidShow']));
      });
    });

    group('transition timeout', () {
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

      test('occurs after the duration specified in props.timeoutDuration has elapsed', () async {
        final renderedElement = (WithTransitionTester()
          ..isShown = true
          ..transitionCount = 1
          ..transitionTimeout = const Duration(seconds: 0)
        )();
        jacket = mount(renderedElement);
        expectNodeInTransitionPhase(TransitionPhase.SHOWN, reason: 'test setup sanity check');

        jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = false));

        expectNodeInTransitionPhase(TransitionPhase.HIDING);

        await Future.delayed(Duration.zero);

        expectNodeInTransitionPhase(TransitionPhase.HIDDEN);

        verifyValidationWarning(
          'The number of transitions expected to complete have not completed. Something is most likely wrong.'
        );
      });

      test('does not occur when shown and hidden rapidly', () async {
        final renderedElement = (WithTransitionTester()..isShown = false)();
        jacket = mount(renderedElement);
        jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = true));

        expectNodeInTransitionPhase(TransitionPhase.SHOWING);

        jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = false));

        expectNodeInTransitionPhase(TransitionPhase.HIDING);

        await triggerTransitionEnd(getRootNode());

        expectNodeInTransitionPhase(TransitionPhase.HIDDEN);

        rejectValidationWarning(anything);
      });
    }, tags: 'ddc');

    group('props.childPropsByPhase', () {
      test('properly merges CSS classes with child CSS classes', () {
        jacket = mount((WithTransitionTester()
          ..isShown = true
          ..childPropsByPhase = {
            TransitionPhase.SHOWN: (domProps()..className = 'shown'),
          }
        )());
        expect(getRootNode(), hasExactClasses([
          'shown',
          WithTransitionTesterComponent.childClassName,
        ]));
      });

      test('can be a map with keys for only certain transition phases', () async {
        final renderedElement = (WithTransitionTester()
          ..isShown = true
          ..childPropsByPhase = {
            TransitionPhase.HIDDEN: WithTransitionTesterComponent.childPropsByPhase[TransitionPhase.HIDDEN],
          }
        )();
        jacket = mount(renderedElement);
        expect(getRootNode(),
          isNot(hasAttr(WithTransitionTesterComponent.attrName, WithTransitionTesterComponent.testAttrByPhase[TransitionPhase.SHOWN])),
          reason: 'Test setup sanity check: the "shown" phase should not have a key set within props.childPropsByPhase',
        );

        expect(() => jacket.rerender(cloneElement(renderedElement, WithTransitionTester()..isShown = false)),
            returnsNormally);

        await triggerTransitionEnd(getRootNode());
        expectNodeInTransitionPhase(TransitionPhase.HIDDEN);
      });
    });

    test('preserves consumer refs on the child', () async {
      jacket = mount(WithTransitionTester()());
      await Future.microtask(() {});
      expect(jacket.getDartInstance().consumerChildNodeRef.current, isA<Element>());
    });

    group('throws', () {
      group('when invalid children are provided:', () {
        test('no child', () {
          expect(() => mount(WithTransition()()), throwsPropError_Value([], 'children'));
        });

        test('more than one child', () {
          final child1 = Dom.div()('one');
          final child2 = Dom.div()('two');
          expect(() => mount(WithTransition()(
            child1,
            child2,
          )), throwsPropError_Value([child1, child2], 'children'));
        });

        test('a single child that is not a ReactElement', () {
          const child = 'one';
          expect(() => mount(WithTransition()(child)), throwsPropError_Value([child], 'children'));
        });
      });
    }, tags: 'ddc');
  });
}

UiFactory<WithTransitionTesterProps> WithTransitionTester = _$WithTransitionTester; // ignore: undefined_identifier, invalid_assignment

class WithTransitionTesterProps = UiProps
    with
        WithTransitionPropsMixin,
        TransitionPropsMixin
    implements WithTransitionProps;

class WithTransitionTesterComponent extends UiComponent2<WithTransitionTesterProps> {
  final consumerChildNodeRef = createRef<Element>();

  @override
  get defaultProps => (newProps()
    ..addProps(TransitionPropsMixin.defaultProps)
    ..isShown = true
    ..transitionTimeout = const Duration(seconds: 1)
  );

  @override
  get consumedProps => const [];

  @override
  render() {
    return (WithTransition()
      ..childPropsByPhase = childPropsByPhase
      ..modifyProps(addUnconsumedProps)
    )(
      (Dom.div()
        ..className = childClassName
        ..ref = consumerChildNodeRef
      )(props.children),
    );
  }

  static const childClassName = 'with-transition-tester-child';

  static const testAttrByPhase = {
    TransitionPhase.SHOWN: 'shown',
    TransitionPhase.HIDDEN: 'hidden',
    TransitionPhase.HIDING: 'hiding',
    TransitionPhase.PRE_SHOWING: 'pre-showing',
    TransitionPhase.SHOWING: 'showing',
  };

  static const attrName = AbstractTransitionComponent.transitionPhaseTestAttr;

  static final childPropsByPhase = {
    TransitionPhase.SHOWN: {attrName: testAttrByPhase[TransitionPhase.SHOWN]},
    TransitionPhase.HIDDEN: {attrName: testAttrByPhase[TransitionPhase.HIDDEN]},
    TransitionPhase.HIDING: {attrName: testAttrByPhase[TransitionPhase.HIDING]},
    TransitionPhase.PRE_SHOWING: {attrName: testAttrByPhase[TransitionPhase.PRE_SHOWING]},
    TransitionPhase.SHOWING: {attrName: testAttrByPhase[TransitionPhase.SHOWING]},
  };
}
