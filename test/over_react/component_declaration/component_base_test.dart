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

library over_react.component_declaration.component_base_test;

import 'dart:async';
import 'dart:collection';
import 'dart:html';

import 'package:over_react/over_react.dart' show Dom, DummyComponent, JsBackedMap, ValidationUtil;
import 'package:over_react_test/over_react_test.dart';
import 'package:over_react/src/component_declaration/component_base.dart';
import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:w_common/disposable.dart';

import '../../test_util/test_util.dart';
import '../shared/map_proxy_tests.dart';

main() {
  void _commonNonInvokedBuilderTests(UiProps builder) {
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

    test('when a single non-invoked builder child is passed in', () {
      expect(() => builder(Dom.div()), throwsArgumentError);
      verifyValidationWarning(contains(
          'It looks like you are trying to use a non-invoked builder as a child.'));
    });

    test('when a list with a non-invoked builder child passed in', () {
      expect(() =>
          builder([
            Dom.div(),
            Dom.p()(),
            Dom.div()
          ]), throwsArgumentError);
      verifyValidationWarning(contains(
          'It looks like you are trying to use a non-invoked builder as a child.'));
    });

    test(
        'except when an iterable with a non-invoked builder child passed in', () {
      var children = (() sync* {
        yield Dom.div();
        yield Dom.p()();
        yield Dom.div();
      })();
      expect(() => builder(children), returnsNormally);
      rejectValidationWarning(anything);
    });

    test('when non-invoked builder children are passed in variadically', () {
      expect(() =>
          builder(
              Dom.div(),
              Dom.p()(),
              Dom.div()
          ), throwsArgumentError);
      verifyValidationWarning(contains(
          'It looks like you are trying to use a non-invoked builder as a child.'));
    });
  }

  void _commonVariadicChildrenTests(UiProps builder) {
    // There are different code paths for 0, 1, 2, 3, 4, 5, 6, and 6+ arguments.
    // Test all of them.
    group('a number of variadic children:', () {
      test('0', () {
        final instance = builder();
        expect(getJsChildren(instance), isNull);
      });

      test('1', () {
        final instance = builder(1);
        expect(getJsChildren(instance), equals(1));
      });

      const firstGeneralCaseVariadicChildCount = 2;
      const maxSupportedVariadicChildCount = 40;
      for (var i = firstGeneralCaseVariadicChildCount; i < maxSupportedVariadicChildCount; i++) {
        final childrenCount = i;
        test('$childrenCount', () {
          final expectedChildren = new List.generate(childrenCount, (i) => i + 1);
          final arguments = <dynamic>[]..addAll(expectedChildren);
          final instance = Function.apply(builder, arguments);
          expect(getJsChildren(instance), expectedChildren);
        });
      }

      test('$maxSupportedVariadicChildCount (and passes static analysis)', () {
        final instance = builder(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40);
        // Generate these instead of hard coding them to ensure the arguments passed into this test match maxSupportedVariadicChildCount
        final expectedChildren = new List.generate(maxSupportedVariadicChildCount, (i) => i + 1);
        expect(getJsChildren(instance), equals(expectedChildren));
      });
    });
  }

  group('component base:', () {
    group('UiProps', () {
      group('warns and throws when rendering a DOM component', () {
        _commonNonInvokedBuilderTests(Dom.div());
      }, testOn: '!js');

      test('warns against setting props directly', () {
        startRecordingValidationWarnings();
        var instance = render(TestComponent()());
        var component = getDartComponent(instance);
        var changeProps = () => component.props['id'] = 'test';
        changeProps();
        verifyValidationWarning(contains('Never mutate this.props directly'));
        stopRecordingValidationWarnings();
      });

      group('renders a DOM component with the correct children when', () {
        _commonVariadicChildrenTests(Dom.div());

        test('no children are passed in', () {
          var renderedNode = renderAndGetDom(Dom.div()());

          expect(renderedNode.childNodes, isEmpty);
        });

        test('children is null', () {
          var renderedNode = renderAndGetDom(Dom.div()(null));

          expect(renderedNode.childNodes, isEmpty);
        });

        test('a single child is passed in', () {
          var child = 'Only child';
          var renderedNode = renderAndGetDom(Dom.div()(child));
          var children = new List<Text>.from(renderedNode.childNodes.where((node) => node.nodeType != Node.COMMENT_NODE));

          expect(children.length, equals(1));
          expect(children[0].data, equals(child));
        });

        test('children are set via a list', () {
          var children = ['First Child', 'Second Child'];
          var renderedNode = renderAndGetDom(Dom.div()(children));
          var childNodes = renderedNode.childNodes.where((node) => node.nodeType != Node.COMMENT_NODE).toList();

          expect(childNodes.length, equals(2));
          expect(childNodes[0].text, equals(children[0]));
          expect(childNodes[1].text, equals(children[1]));
        });

        test('children are set via an iterable', () {
          var children = (() sync* {
            yield 'First Child';
            yield 'Second Child';
          })();
          var renderedNode = renderAndGetDom(Dom.div()(children));
          var childNodes = renderedNode.childNodes.where((node) => node.nodeType != Node.COMMENT_NODE).toList();

          expect(childNodes.length, equals(2));
          expect(childNodes[0].text, equals('First Child'));
          expect(childNodes[1].text, equals('Second Child'));
        });

        test('children are set variadically', () {
          var firstChild = 'First Child';
          var secondChild = 'Second Child';
          var renderedNode = renderAndGetDom(Dom.div()(firstChild, secondChild));
          var children = renderedNode.childNodes.where((node) => node.nodeType != Node.COMMENT_NODE).toList();

          expect(children.length, equals(2));
          expect(children[0].text, equals('First Child'));
          expect(children[1].text, equals('Second Child'));
        });
      });

      group('warns and throws when rendering a Dart composite component', () {
        _commonNonInvokedBuilderTests(Dom.div());
      }, testOn: '!js');

      group('renders a composite Dart component with the correct children when', () {
        _commonVariadicChildrenTests(TestComponent());

        test('no children are passed in', () {

          var renderedInstance = render(TestComponent()());

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), isEmpty);

          expect(getJsChildren(renderedInstance), isNull);
        });

        test('children is null', () {
          var renderedInstance = render(TestComponent()(null));

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), isEmpty);

          expect(getJsChildren(renderedInstance), isNull);
        });

        test('a single child is passed in', () {
          var child = 'Only child';
          var renderedInstance = render(TestComponent()(child));

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals([child]));

          expect(getJsChildren(renderedInstance), equals(child));
        });

        test('children are set via a list', () {
          var children = ['First Child', 'Second Child'];
          var renderedInstance = render(TestComponent()(children));

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals(children));

          expect(getJsChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), equals(children));
        });

        test('children are set via an iterable', () {
          var children = (() sync* {
            yield 'First Child';
            yield 'Second Child';
          })();
          var renderedInstance = render(TestComponent()(children));

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), orderedEquals(children));

          expect(getJsChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), orderedEquals(children));
        });

        test('children are set variadically', () {
          var firstChild = 'First Child';
          var secondChild = 'Second Child';
          var renderedInstance = render(TestComponent()(firstChild, secondChild));

          expect(getDartChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals([firstChild, secondChild]));

          expect(getJsChildren(renderedInstance), const TypeMatcher<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), equals([firstChild, secondChild]));
        });
      });

      group('provides Map functionality:', () {
        test('is a Map', () {
          expect(new TestComponentProps(), const TypeMatcher<Map>());
        });

        test('toString() returns a user-friendly String that includes the key-value pairs', () {
           expect(new TestComponentProps({'key': 'value'}).toString(),
               contains('{key: value}'));
        });

        mapProxyTests((Map backingMap) => new TestComponentProps(backingMap));
      });

      group('addProp()', () {
        test('adds the given key-value pair', () {
          var props = new TestComponentProps();
          props.addProp('key', 'value');
          expect(props, equals({'key': 'value'}));
        });

        test('does nothing when shouldAdd is false', () {
          var props = new TestComponentProps();
          props.addProp('key', 'value', false);

          expect(props, equals({}));
        });
      });

      group('addProps()', () {
        test('merges in the given Map', () {
          var props = new TestComponentProps();
          props['existingKey'] = 'existingValue';

          props.addProps({
            'newKey1': 'newValue1',
            'newKey2': 'newValue2',
          });
          expect(props, equals({
            'existingKey': 'existingValue',
            'newKey1': 'newValue1',
            'newKey2': 'newValue2',
          }));
        });

        test('does nothing when passed null', () {
          var props = new TestComponentProps();
          props.addProp('key', 'value');

          expect(() => props.addProps(null), returnsNormally);

          expect(props, equals({'key': 'value'}));
        });

        test('does nothing when shouldAdd is false', () {
          var props = new TestComponentProps();
          props.addProps({'newKey1': 'newValue1'}, false);

          expect(props, equals({}));
        });
      });

      group('modifyProps()', () {
        test('passes the provided modifier itself', () {
          modifier(Map props) {
            props['className'] = 'modified-class-name';
          }

          var props = new TestComponentProps()
            ..['className'] = 'original-class-name'
            ..['id'] = 'original-id';

          expect(props, equals({
            'className': 'original-class-name',
            'id': 'original-id'
          }));

          props.modifyProps(modifier);

          expect(props, equals({
            'className': 'modified-class-name',
            'id': 'original-id'
          }));
        });

        test('does nothing when passed null', () {
          var props = new TestComponentProps()
            ..['className'] = 'original-class-name';

          expect(() => props.modifyProps(null), returnsNormally);

          expect(props, equals({'className': 'original-class-name'}));
        });

        test('does nothing when shouldModify is false', () {
          modifier(Map props) {
            props['className'] = 'modified-class-name';
          }

          var props = new TestComponentProps()
            ..['className'] = 'original-class-name'
            ..['id'] = 'original-id';

          props.modifyProps(modifier, false);

          expect(props, equals({
            'className': 'original-class-name',
            'id': 'original-id'
          }));
        });
      });

      group('testId', () {
        test('sets the correct value for the `data-test-id` key when setting the testId', () {
          var props = new TestComponentProps();
          props.addTestId('value');

          expect(props, equals({'data-test-id': 'value'}));
        });

        test('does not set the value for the `data-test-id` when inTesting is false', () {
          UiProps.testMode = false;

          var props = new TestComponentProps();
          props.addTestId('value');

          expect(props, equals({}));

          UiProps.testMode = true;
        });

        test('sets the correct value for the `data-test-id` key when adding a testId', () {
          var props = new TestComponentProps();
          props.addTestId('value');

          expect(props, equals({'data-test-id': 'value'}));
        });

        test('sets the correct value for the `data-test-id` key when adding multiple testIds through multiple calls to `addTestId`', () {
          var props = new TestComponentProps();
          props.addTestId('value1');
          props.addTestId('value2');

          expect(props, equals({'data-test-id': 'value1 value2'}));
        });

        test('does not set a value for the `data-test-id` when adding a testId but inTesting is false', () {
          UiProps.testMode = false;

          var props = new TestComponentProps();
          props.addTestId('value');

          expect(props, equals({}));

          UiProps.testMode = true;
        });

        test('does not set a value for the `data-test-id` when adding a `null` testId', () {
          var props = new TestComponentProps();
          props.addTestId(null);

          expect(props, equals({}));
        });
      });
    });

    group('UiState', () {
      group('provides Map functionality:', () {
        test('is a Map', () {
          expect(new TestStatefulComponentState(), const TypeMatcher<Map>());
        });

        test('toString() returns a user-friendly String that includes the key-value pairs', () {
           expect(new TestStatefulComponentState({'key': 'value'}).toString(),
               contains('{key: value}'));
        });

        mapProxyTests((Map backingMap) => new TestStatefulComponentState(backingMap));
      });
    });

    // These tests are here to cover the PropsMapViewMixin, which used to be covered when
    // testing UiProps, but isn't anymore since UiProps uses it as an interface instead
    // to work around DDC issues.
    //
    // If these test classes cause trouble when running in the DDC, just disable these tests in the DDC.
    group('PropsMapViewMixin provides Map functionality:', () {
      mapProxyTests((Map backingMap) => new TestPropsMapViewMixin(backingMap));
    });

    // These tests are here to cover the StateMapViewMixin, which used to be covered when
    // testing UiState, but isn't anymore since UiState uses it as an interface instead
    // to work around DDC issues.
    //
    // If these test classes cause trouble when running in the DDC, just disable these tests in the DDC.
    group('StateMapViewMixin provides Map functionality:', () {
      mapProxyTests((Map backingMap) => new TestStateMapViewMixin(backingMap));
    });

    group('UiComponent', () {
      TestComponentComponent component;

      setUp(() {
        component = new TestComponentComponent();
        component.unwrappedProps = {};
      });

      group('`ref`', () {
        test('should return a reference to the string ref', () {
          var renderedInstance = render(TestComponent()());
          TestComponentComponent component = getDartComponent(renderedInstance);

          // ignore: deprecated_member_use
          expect(component.ref('foo'), isNotNull);
        });
      });

      group('`props`', () {
        group('getter:', () {
          test('returns a UiProps view into the component\'s props map', () {
            expect(component.props, const TypeMatcher<TestComponentProps>());

            expect(component.props, isNot(same(component.unwrappedProps)));

            component.unwrappedProps['testKey'] = 'testValue';
            expect(component.props, containsPair('testKey', 'testValue'));
          });

          test('caches the UiProps object for the same map', () {
            var props1 = component.props;
            var props2 = component.props;
            expect(props1, same(props2));
          });

          test('creates a new UiProps object when the props map changes', () {
            var propsBeforeChange = component.props;
            component.unwrappedProps = {};
            var propsAfterChange = component.props;

            expect(propsBeforeChange, isNot(same(propsAfterChange)));
          });
        });

        group('setter:', () {
          test('sets the unwrapped Map, as react-dart requires it to', () {
            var newBackingMap = {};
            component.props = newBackingMap;
            expect(component.unwrappedProps, same(newBackingMap));
          });
        });
      });

      test('newProps() returns a new UiProps instance backed by a new Map', () {
        var newProps1 = component.newProps();
        var newProps2 = component.newProps();
        expect(newProps1, const TypeMatcher<TestComponentProps>());
        expect(newProps2, const TypeMatcher<TestComponentProps>());
        expect(newProps1, isNot(same(newProps2)));
      });

      group('copyUnconsumedProps()', () {
        test('copies props, omitting keys from `consumedProps`, as well as reserved react props', () {
          component = new TestComponentComponent(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component.props = {
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
          };

          expect(component.copyUnconsumedProps(), equals({
            'unconsumed1': true,
            'unconsumed2': true,
          }));
        });

        test('copies all props when `consumedProps` is null', () {
          component = new TestComponentComponent(testConsumedProps: null);

          component.props = {
            'prop1': true,
            'prop2': true,
          };

          expect(component.copyUnconsumedProps(), equals({
            'prop1': true,
            'prop2': true,
          }));
        });
      });

      group('copyUnconsumedDomProps()', () {
        test('copies props, omitting keys from `consumedPropKeys`, as well as reserved react props', () {
          component = new TestComponentComponent(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component.props = {
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
            'tabIndex': true,
            'className': true,
          };

          expect(component.copyUnconsumedDomProps(), equals({
            'tabIndex': true,
            'className': true,
          }));
        });

        test('copies all props when `consumedPropKeys` is null', () {
          component = new TestComponentComponent(testConsumedProps: null);

          component.props = {
            'prop1': true,
            'prop2': true,
            'tabIndex': true,
            'className': true,
          };

          expect(component.copyUnconsumedDomProps(), equals({
            'tabIndex': true,
            'className': true,
          }));
        });
      });

      test('forwardingClassNameBuilder() returns a new ClassNameBuilder based on the component\'s props', () {
        component.props = {
          'className': 'class-1',
          'classNameBlacklist': 'blacklist-1',
        };

        var classes = component.forwardingClassNameBuilder();
        expect(classes.toClassName(), equals('class-1'));
        expect(classes.toClassNameBlacklist(), equals('blacklist-1'));
      });

      group('calls validateProps in', () {
        test('componentWillMount', () {
          var calls = [];
          var appliedProps;
          var initialProps = {
            'onValidateProps': (Map propsMap) {
              appliedProps = propsMap;
              calls.add('onValidateProps');
            },
          };
          component.props = initialProps;

          component.componentWillMount();

          expect(calls, ['onValidateProps']);
          expect(appliedProps, initialProps);
        });

        test('componentWillReceiveProps', () {
          var calls = [];
          var appliedProps;
          var newProps = {'key': 'value'};
          component.props = {
            'onValidateProps': (Map propsMap) {
              appliedProps = propsMap;
              calls.add('onValidateProps');
            },
          };

          component.componentWillReceiveProps(newProps);

          expect(calls, ['onValidateProps']);
          expect(appliedProps, newProps);
        });
      });

      group('on unmount', () {
        TestComponentComponent component;
        ReactElement instance;
        Duration longDuration = const Duration(milliseconds: 200);
        Duration shortDuration = const Duration(milliseconds: 100);

        setUp(() {
          instance = render(TestComponent()());
          component = getDartComponent(instance);
        });

        Future<Null> unmountAndDisposal() async {
          unmount(instance);
          // Provide timers a window to fire
          await new Future.delayed(longDuration);
        }

        test('should await future before disposing', () async {
          // ignore: close_sinks
          var streamController = new StreamController<String>.broadcast();
          var completer = new Completer<String>();

          // Manage pending future
          component.awaitBeforeDispose(completer.future);

          // Add events to stream
          component.manageDisposer(() async => streamController.add('disposalFuture')); // ignore: deprecated_member_use_from_same_package
          completer.future.then(streamController.add);

          // Perform events out of order
          await unmountAndDisposal();
          completer.complete('awaitedFuture');

          // Ensure events resolve in the correct order
          expect(streamController.stream, emitsInOrder([
            'awaitedFuture',
            'disposalFuture',
          ]));
        });

        test('should complete delayed Future with ObjectDisposedException', () async {
          expect(component.getManagedDelayedFuture(shortDuration,
              expectAsync0(() {}, count: 0, reason: 'Did not expect callback to be invoked.')),
            throwsA(const TypeMatcher<ObjectDisposedException>()));

          await unmountAndDisposal();
        });

        test('should call managed disposer returned by getManagedDisposer', () async {
          var disposerCalled = false;
          var disposer = component.getManagedDisposer(() async => disposerCalled = true);
          expect(disposer, const TypeMatcher<ManagedDisposer>());

          expect(disposerCalled, isFalse);
          await unmountAndDisposal();
          expect(disposerCalled, isTrue);
          expect(disposer.isDisposed, isTrue);
        });

        test('should cancel periodic timer', () async {
          var timer = component.getManagedPeriodicTimer(shortDuration,
            expectAsync1((_) {}, count: 0, reason: 'Did not expect callback to be invoked.'));

          expect(timer.isActive, isTrue);
          await unmountAndDisposal();
          expect(timer.isActive, isFalse);
        });

        test('should cancel timer', () async {
          var timer = component.getManagedTimer(shortDuration,
            expectAsync1((_){}, count: 0, reason: 'Did not expect callback to be invoked.'));

          expect(timer.isActive, isTrue);
          await unmountAndDisposal();
          expect(timer.isActive, isFalse);
        });

        test('should cancel stream subscription returned by listenToStream', () async{
          var streamController = new StreamController<Null>.broadcast();
          // ignore: cancel_subscriptions
          var streamSubscription = component.listenToStream(streamController.stream, expectAsync1((_) {},
              count: 0,
              reason: 'Did not expect event after cancelling subscription'));
          expect(streamSubscription, const TypeMatcher<StreamSubscription>());

          await unmountAndDisposal();

          streamController
            ..add(null)
            ..close();
        });

        test('should dispose managed Disposable returned by manageAndReturnDisposable', () async {
          var disposable = new Disposable();
          expect(component.manageAndReturnDisposable(disposable), same(disposable));
          expect(disposable.isDisposed, isFalse);
          await unmountAndDisposal();
          expect(disposable.isDisposed, isTrue);
        });

        test('should complete uncompleted managed Completer with ObjectDisposedException', () async {
          var completer = new Completer<Null>();
          component.manageCompleter(completer);
          completer.future.catchError(expectAsync1((Object err) {
            expect(err, const TypeMatcher<ObjectDisposedException>());
          }));

          expect(completer.isCompleted, isFalse);
          await unmountAndDisposal();
          expect(completer.isCompleted, isTrue);
        });

        test('should dispose managed Disposable', () async {
          var disposable = new Disposable();
          component.manageDisposable(disposable);
          expect(disposable.isDisposed, isFalse);
          await unmountAndDisposal();
          expect(disposable.isDisposed, isTrue);
        });

        test('should call managed disposers', () async {
          var disposerCalled = false;
          component.manageDisposer(() async => disposerCalled = true); // ignore: deprecated_member_use_from_same_package
          expect(disposerCalled, isFalse);
          await unmountAndDisposal();
          expect(disposerCalled, isTrue);
        });

        test('should close managed StreamController', () async {
          //ignore: close_sinks
          var streamController = new StreamController<Null>.broadcast();
          component.manageStreamController(streamController);
          expect(streamController.isClosed, isFalse);
          await unmountAndDisposal();
          expect(streamController.isClosed, isTrue);
        });

        test('should cancel managed StreamSubscription', () async{
          var streamController = new StreamController<Null>.broadcast();
          // ignore: cancel_subscriptions
          var streamSubscription = streamController.stream
            .listen(expectAsync1((_) {},
              count: 0,
              reason: 'Did not expect event after cancelling subscription'));

          component.manageStreamSubscription(streamSubscription); // ignore: deprecated_member_use_from_same_package
          await unmountAndDisposal();

          streamController
            ..add(null)
            ..close();
        });
      }, timeout: new Timeout(const Duration(milliseconds: 250)));
    });

    group('UiComponent2', () {
      TestComponent2Component component2;

      group('copyUnconsumedProps()', () {
        test('copies props, omitting keys from `consumedProps`, as well as reserved react props', () {
          component2 = new TestComponent2Component(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component2.props = new JsBackedMap.from({
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
          });

          expect(component2.copyUnconsumedProps(), equals({
            'unconsumed1': true,
            'unconsumed2': true,
          }));
        });

        test('copies all props when `consumedProps` is null', () {
          component2 = new TestComponent2Component(testConsumedProps: null);

          component2.props = new JsBackedMap.from({
            'prop1': true,
            'prop2': true,
          });

          expect(component2.copyUnconsumedProps(), equals({
            'prop1': true,
            'prop2': true,
          }));
        });
      });

      group('copyUnconsumedDomProps()', () {
        test('copies props, omitting keys from `consumedPropKeys`, as well as reserved react props', () {
          component2 = new TestComponent2Component(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component2.props = new JsBackedMap.from({
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
            'tabIndex': true,
            'className': true,
          });

          expect(component2.copyUnconsumedDomProps(), equals({
            'tabIndex': true,
            'className': true,
          }));
        });

        test('copies all props when `consumedPropKeys` is null', () {
          component2 = new TestComponent2Component(testConsumedProps: null);

          component2.props = new JsBackedMap.from({
            'prop1': true,
            'prop2': true,
            'tabIndex': true,
            'className': true,
          });

          expect(component2.copyUnconsumedDomProps(), equals({
            'tabIndex': true,
            'className': true,
          }));
        });
      });

      group('addUnconsumedProps()', () {
        test('copies props, omitting keys from `consumedProps`, as well as reserved react props', () {
          component2 = new TestComponent2Component(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component2.props = new JsBackedMap.from({
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
          });

          Map newProps = {};
          component2.addUnconsumedProps(newProps);

          expect(newProps, equals({
            'unconsumed1': true,
            'unconsumed2': true,
          }));
        });

        test('copies all props when `consumedProps` is null', () {
          component2 = new TestComponent2Component(testConsumedProps: null);

          component2.props = new JsBackedMap.from({
            'prop1': true,
            'prop2': true,
          });

          Map newProps = {};
          component2.addUnconsumedProps(newProps);

          expect(newProps, equals({
            'prop1': true,
            'prop2': true,
          }));
        });
      });

      group('addUnconsumedDomProps()', () {
        test('copies props, omitting keys from `consumedPropKeys`, as well as reserved react props', () {
          component2 = new TestComponent2Component(testConsumedProps: [
            const ConsumedProps(const [], const ['consumed1', 'consumed2'])
          ]);

          component2.props = JsBackedMap.from({
            'key': 'testKey',
            'ref': 'testRef',
            'children': [],
            'consumed1': true,
            'consumed2': true,
            'unconsumed1': true,
            'unconsumed2': true,
            'tabIndex': true,
            'className': true,
          });

          Map newProps = {};
          component2.addUnconsumedDomProps(newProps);

          expect(newProps, equals({
            'tabIndex': true,
            'className': true,
          }));
        });

        test('copies all props when `consumedPropKeys` is null', () {
          component2 = new TestComponent2Component(testConsumedProps: null);

          component2.props = JsBackedMap.from({
            'prop1': true,
            'prop2': true,
            'tabIndex': true,
            'className': true,
          });

          Map newProps = {};
          component2.addUnconsumedDomProps(newProps);

          expect(newProps, equals({
            'tabIndex': true,
            'className': true,
          }));
        });
      });
    });

    group('UiStatefulComponent', () {
      TestStatefulComponentComponent statefulComponent;

      setUp(() {
        statefulComponent = new TestStatefulComponentComponent();
        statefulComponent.unwrappedState = {'test': true};
      });

      group('`state`', () {
        group('getter:', () {
          test('returns a UiState view into the component\'s state map', () {
            expect(statefulComponent.state, const TypeMatcher<TestStatefulComponentState>());

            expect(statefulComponent.state, isNot(same(statefulComponent.unwrappedState)));

            statefulComponent.unwrappedState['testKey'] = 'testValue';
            expect(statefulComponent.state, containsPair('testKey', 'testValue'));
          });

          test('caches the UiState object for the same map', () {
            var state1 = statefulComponent.state;
            var state2 = statefulComponent.state;
            expect(state1, same(state2));
          });

          test('creates a new UiState object when the state map changes', () {
            var stateBeforeChange = statefulComponent.state;
            statefulComponent.unwrappedState = {};
            var stateAfterChange = statefulComponent.state;

            expect(stateBeforeChange, isNot(same(stateAfterChange)));
          });

          test('warns against setting state directly', () {
            startRecordingValidationWarnings();
            var changeState = () => statefulComponent.state['test'] = true;
            changeState();
            verifyValidationWarning(contains('Never mutate this.state directly'));
            stopRecordingValidationWarnings();
          });
        });

        group('setter:', () {
          test('sets the unwrapped Map, as react-dart requires it to', () {
            var newBackingMap = {};
            statefulComponent.state = newBackingMap;
            expect(statefulComponent.unwrappedState, same(newBackingMap));
          });
        });
      });

      test('newState() returns a new UiProps instance backed by a new Map', () {
        var newState1 = statefulComponent.newState();
        var newState2 = statefulComponent.newState();
        expect(newState1, const TypeMatcher<TestStatefulComponentState>());
        expect(newState2, const TypeMatcher<TestStatefulComponentState>());
        expect(newState1, isNot(same(newState2)));
      });
    });

    group('registerComponent()', () {
      group('attaches metadata to the specified component class:', () {
        final ComponentFactory dummyComponentFactory = () => new DummyComponent();

        group('`isWrapper`:', () {
          test('true', () {
            var reactComponentFactory = registerComponent(dummyComponentFactory, isWrapper: true);
            var meta = getComponentTypeMeta(reactComponentFactory.type);

            expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
            expect(meta.isWrapper, isTrue);
          });

          test('false', () {
            var reactComponentFactory = registerComponent(dummyComponentFactory, isWrapper: false);
            var meta = getComponentTypeMeta(reactComponentFactory.type);

            expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
            expect(meta.isWrapper, isFalse);
          });
        });

        group('`parentType`:', () {
          test('not specified', () {
            var reactComponentFactory = registerComponent(dummyComponentFactory);
            var meta = getComponentTypeMeta(reactComponentFactory.type);

            expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
            expect(meta.parentType, isNull);
          });

          test('null', () {
            var reactComponentFactory = registerComponent(dummyComponentFactory);
            var meta = getComponentTypeMeta(reactComponentFactory.type);

            expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
            expect(meta.parentType, isNull);
          });

          test('another ReactComponentFactoryProxy', () {
            var parentFactory = registerComponent(dummyComponentFactory);

            var reactComponentFactory = registerComponent(dummyComponentFactory, parentType: parentFactory);
            var meta = getComponentTypeMeta(reactComponentFactory.type);

            expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
            expect(meta.parentType, equals(parentFactory));
          });
        });

        test('displayName', () {
          var reactComponentFactory = registerComponent(dummyComponentFactory, displayName: 'testDisplayName');
          expect(reactComponentFactory.type.displayName, equals('testDisplayName'));
        });

        group('registers a type alias for', () {
          test('`componentClass`', () {
            Type typeAlias = TestRegisterComponentClassAlias;
            var reactComponentFactory = registerComponent(dummyComponentFactory, componentClass: typeAlias);

            expect(getComponentTypeFromAlias(TestRegisterComponentClassAlias), equals(reactComponentFactory.type));
          });

          test('`factory`', () {
            UiFactory factoryAlias = ([_]) => null;
            var reactComponentFactory = registerComponent(dummyComponentFactory, builderFactory: factoryAlias);

            expect(getComponentTypeFromAlias(factoryAlias), equals(reactComponentFactory.type));
          });
        });
      });
    });

    test('registerAbstractComponent registers a type alias for a componentClass', () {
      Type typeAlias = TestRegisterComponentClassAlias;
      var reactComponentFactory = registerAbstractComponent(typeAlias);

      expect(getComponentTypeFromAlias(TestRegisterComponentClassAlias), equals(reactComponentFactory.type));
    });

    test('registerAbstractComponent registers a type alias for a componentClass and parentType', () {
      Type typeAlias = TestRegisterComponentClassAlias;
      var parentFactory = registerComponent(() => new DummyComponent());
      var reactComponentFactory = registerAbstractComponent(typeAlias, parentType: parentFactory);
      var meta = getComponentTypeMeta(reactComponentFactory.type);

      expect(meta, isNot(same(const ComponentTypeMeta.none())), reason: 'should have stored a new meta instance');
      expect(meta.parentType, equals(parentFactory));
      expect(getComponentTypeFromAlias(TestRegisterComponentClassAlias), equals(reactComponentFactory.type));
    });
  });
}

dynamic getJsChildren(instance) => unconvertJsProps(instance)['children'];

dynamic getDartChildren(var renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}

UiFactory<TestComponentProps> TestComponent = ([Map props]) => new TestComponentProps(props);

class TestComponentProps extends UiProps {
  @override final ReactComponentFactoryProxy componentFactory = _TestComponentComponentFactory;
  @override final Map props;

  TestComponentProps([Map props]) : this.props = props ?? ({});
}

final _TestComponentComponentFactory = registerComponent(() => new TestComponentComponent());
class TestComponentComponent extends UiComponent<TestComponentProps> {
  @override
  final List<ConsumedProps> consumedProps;

  TestComponentComponent({List<ConsumedProps> testConsumedProps}) : consumedProps = testConsumedProps;

  @override
  render() => (Dom.div()..ref = 'foo')();

  @override
  TestComponentProps typedPropsFactory(Map propsMap) => new TestComponentProps(propsMap);

  @override
  void validateProps(Map appliedProps) {
    super.validateProps(appliedProps);

    if (props['onValidateProps'] != null) props['onValidateProps'](appliedProps);
  }
}

class TestComponent2Props extends UiProps {
  @override final ReactComponentFactoryProxy componentFactory = _TestComponentComponentFactory;
  TestComponent2Props(JsBackedMap backingMap)
      : this._props = new JsBackedMap() {
    this._props = backingMap ?? new JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

class TestComponent2Component extends UiComponent2<TestComponent2Props> {

  @override
  final List<ConsumedProps> consumedProps;

  @override
  TestComponent2Props get props => typedPropsFactory(super.props);

  TestComponent2Component({List<ConsumedProps> testConsumedProps}) :
        consumedProps = testConsumedProps;

  @override
  render() => (Dom.div()..ref = 'foo')();

  @override
  TestComponent2Props typedPropsFactory(Map propsMap) => new
  TestComponent2Props(propsMap);

  @override
  TestComponent2Props typedPropsFactoryJs(Map propsMap) => new
  TestComponent2Props(propsMap);
}

UiFactory<TestStatefulComponentProps> TestStatefulComponent = ([Map props]) => new TestStatefulComponentProps(props);

class TestStatefulComponentProps extends UiProps {
  @override final ReactComponentFactoryProxy componentFactory = _TestStatefulComponentComponentFactory;
  @override final Map props;

  TestStatefulComponentProps([Map props]) : this.props = props ?? ({});
}

class TestStatefulComponentState extends UiState {
  @override final Map state;

  TestStatefulComponentState([Map state]) : this.state = state ?? ({});
}

final _TestStatefulComponentComponentFactory = registerComponent(() => new TestStatefulComponentComponent());
class TestStatefulComponentComponent extends UiStatefulComponent<TestStatefulComponentProps, TestStatefulComponentState> {
  @override
  render() {}

  @override
  TestStatefulComponentProps typedPropsFactory(Map propsMap) => new TestStatefulComponentProps(propsMap);
  @override
  TestStatefulComponentState typedStateFactory(Map state) => new TestStatefulComponentState(state);
}

abstract class TestRegisterComponentClassAlias {}

class TestPropsMapViewMixin extends MapBase with MapViewMixin, PropsMapViewMixin implements Map {
  @override
  final Map props;

  TestPropsMapViewMixin(this.props);
}

class TestStateMapViewMixin extends MapBase with MapViewMixin, StateMapViewMixin implements Map {
  @override
  final Map state;

  TestStateMapViewMixin(this.state);
}

class TestUiPropsWithCustomComponentFactory extends UiProps {
  @override
  ReactComponentFactoryProxy componentFactory;

  @override
  final Map props = {};
}
