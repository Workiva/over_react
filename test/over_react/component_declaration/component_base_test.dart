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

import 'dart:html';

import 'package:over_react/over_react.dart' show Dom, DummyComponent, ValidationUtil;
import 'package:over_react/src/component_declaration/component_base.dart';
import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
import '../../wsd_test_util/validation_util_helpers.dart';
import '../shared/map_proxy_tests.dart';

main() {
  group('component base:', () {
    group('UiProps', () {
      group('warns and throws when rendering a DOM component', () {
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
          expect(() => Dom.div()(Dom.div()), throws);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });

        test('when a list with a non-invoked builder child passed in', () {
          expect(() => Dom.div()([
            Dom.div(),
            Dom.p()(),
            Dom.div()
          ]), throwsArgumentError);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });

        test('except when an iterable with a non-invoked builder child passed in', () {
          var children = (() sync* {
            yield Dom.div();
            yield Dom.p()();
            yield Dom.div();
          })();
          expect(() => Dom.div()(children), returnsNormally);
          rejectValidationWarning(anything);
        });

        test('when non-invoked builder children are passed in variadically via noSuchMethod', () {
          expect(() => Dom.div()(
            Dom.div(),
            Dom.p()(),
            Dom.div()
          ), throwsArgumentError);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });
      }, testOn: '!js');

      group('renders a DOM component with the correct children when', () {
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
          List<Text> children = renderedNode.childNodes.where((node) => node.nodeType != Node.COMMENT_NODE).toList();

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

        test('children are set variadically via noSuchMethod', () {
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
          expect(() => TestComponent()(Dom.div()), throwsArgumentError);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });

        test('when a list with a non-invoked builder child passed in', () {
          expect(() => TestComponent()([
            Dom.div(),
            Dom.p()(),
            Dom.div()
          ]), throws);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });

        test('except when an iterable with a non-invoked builder passed in', () {
          var children = (() sync* {
            yield Dom.div();
            yield Dom.p()();
            yield Dom.div();
          })();
          expect(() => TestComponent()(children), returnsNormally);
          rejectValidationWarning(anything);
        });

        test('when non-invoked builder children are passed in variadically via noSuchMethod', () {
          expect(() => TestComponent()(
            Dom.div(),
            Dom.p()(),
            Dom.div()
          ), throwsArgumentError);
          verifyValidationWarning(contains('It looks like you are trying to use a non-invoked builder as a child.'));
        });
      }, testOn: '!js');

      group('renders a composite Dart component with the correct children when', () {
        test('no children are passed in', () {
          var renderedInstance = render(TestComponent()());

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), isEmpty);

          expect(getJsChildren(renderedInstance), isNull);
        });

        test('children is null', () {
          var renderedInstance = render(TestComponent()(null));

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), isEmpty);

          expect(getJsChildren(renderedInstance), isNull);
        });

        test('a single child is passed in', () {
          var child = 'Only child';
          var renderedInstance = render(TestComponent()(child));

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals([child]));

          expect(getJsChildren(renderedInstance), equals(child));
        });

        test('children are set via a list', () {
          var children = ['First Child', 'Second Child'];
          var renderedInstance = render(TestComponent()(children));

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals(children));

          expect(getJsChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), equals(children));
        });

        test('children are set via an iterable', () {
          var children = (() sync* {
            yield 'First Child';
            yield 'Second Child';
          })();
          var renderedInstance = render(TestComponent()(children));

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), orderedEquals(children));

          expect(getJsChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), orderedEquals(children));
        });

        test('children are set variadically via noSuchMethod', () {
          var firstChild = 'First Child';
          var secondChild = 'Second Child';
          var renderedInstance = render(TestComponent()(firstChild, secondChild));

          expect(getDartChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getDartChildren(renderedInstance), equals([firstChild, secondChild]));

          expect(getJsChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
          expect(getJsChildren(renderedInstance), equals([firstChild, secondChild]));
        });
      });

      group('provides Map functionality:', () {
        test('is a Map', () {
          expect(new TestComponentProps(), const isInstanceOf<Map>());
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
          expect(new TestStatefulComponentState(), const isInstanceOf<Map>());
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

          expect(component.ref('foo'), isNotNull);
        });
      });

      group('`props`', () {
        group('getter:', () {
          test('returns a UiProps view into the component\'s props map', () {
            expect(component.props, const isInstanceOf<TestComponentProps>());

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
        expect(newProps1, const isInstanceOf<TestComponentProps>());
        expect(newProps2, const isInstanceOf<TestComponentProps>());
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
    });

    group('UiStatefulComponent', () {
      TestStatefulComponentComponent statefulComponent;

      setUp(() {
        statefulComponent = new TestStatefulComponentComponent();
        statefulComponent.unwrappedState = {};
      });

      group('`state`', () {
        group('getter:', () {
          test('returns a UiState view into the component\'s state map', () {
            expect(statefulComponent.state, const isInstanceOf<TestStatefulComponentState>());

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
        expect(newState1, const isInstanceOf<TestStatefulComponentState>());
        expect(newState2, const isInstanceOf<TestStatefulComponentState>());
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

dynamic getJsChildren(instance) => getJsProps(instance)['children'];

dynamic getDartChildren(var renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}


UiFactory<TestComponentProps> TestComponent = ([Map props]) => new TestComponentProps(props);

class TestComponentProps extends UiProps {
  @override final Function componentFactory = _TestComponentComponentFactory;
  @override final Map props;

  TestComponentProps([Map props]) : this.props = props ?? ({});
}

ReactComponentFactory _TestComponentComponentFactory = registerComponent(() => new TestComponentComponent());
class TestComponentComponent extends UiComponent<TestComponentProps> {
  @override
  final List<ConsumedProps> consumedProps;

  TestComponentComponent({List<ConsumedProps> testConsumedProps}) : consumedProps = testConsumedProps;

  @override
  render() => (Dom.div()..ref = 'foo')();

  @override
  TestComponentProps typedPropsFactory(Map propsMap) => new TestComponentProps(propsMap);
}


UiFactory<TestStatefulComponentProps> TestStatefulComponent = ([Map props]) => new TestStatefulComponentProps(props);

class TestStatefulComponentProps extends UiProps {
  @override final Function componentFactory = _TestStatefulComponentComponentFactory;
  @override final Map props;

  TestStatefulComponentProps([Map props]) : this.props = props ?? ({});
}

class TestStatefulComponentState extends UiState {
  @override final Map state;

  TestStatefulComponentState([Map state]) : this.state = state ?? ({});
}

ReactComponentFactory _TestStatefulComponentComponentFactory = registerComponent(() => new TestStatefulComponentComponent());
class TestStatefulComponentComponent extends UiStatefulComponent<TestStatefulComponentProps, TestStatefulComponentState> {
  @override
  render() {}

  @override
  TestStatefulComponentProps typedPropsFactory(Map propsMap) => new TestStatefulComponentProps(propsMap);
  @override
  TestStatefulComponentState typedStateFactory(Map state) => new TestStatefulComponentState(state);
}

abstract class TestRegisterComponentClassAlias {}

class TestPropsMapViewMixin extends Object with MapViewMixin, PropsMapViewMixin implements Map {
  @override
  final Map props;

  TestPropsMapViewMixin(this.props);
}

class TestStateMapViewMixin extends Object with MapViewMixin, StateMapViewMixin implements Map {
  @override
  final Map state;

  TestStateMapViewMixin(this.state);
}
