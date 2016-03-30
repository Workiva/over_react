library ui_core.component_declaration.component_base_test;

import 'dart:html';
import 'dart:js';

import 'package:mockito/mockito.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_base.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_type_checking.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart' show Dom;

main() {
  group('component base:', () {
    group('UiProps', () {
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

          expect(renderedNode.childNodes.length, equals(1));
          expect((renderedNode.childNodes[0] as Text).data, equals(child));
        });

        test('children are set via a list', () {
          var children = ['First Child', 'Second Child'];
          var renderedNode = renderAndGetDom(Dom.div()(children));

          expect(renderedNode.childNodes.length, equals(2));
          expect((renderedNode.childNodes[0] as SpanElement).text, equals(children[0]));
          expect((renderedNode.childNodes[1] as SpanElement).text, equals(children[1]));
        });

        test('children are set via an iterable', () {
          var children = (() sync* {
            yield 'First Child';
            yield 'Second Child';
          })();
          var renderedNode = renderAndGetDom(Dom.div()(children));

          expect(renderedNode.childNodes.length, equals(2));
          expect((renderedNode.childNodes[0] as SpanElement).text, equals('First Child'));
          expect((renderedNode.childNodes[1] as SpanElement).text, equals('Second Child'));
        });

        test('children are set variadically via noSuchMethod', () {
          var firstChild = 'First Child';
          var secondChild = 'Second Child';
          var renderedNode = renderAndGetDom(Dom.div()(firstChild, secondChild));

          expect(renderedNode.childNodes.length, equals(2));
          expect((renderedNode.childNodes[0] as SpanElement).text, equals('First Child'));
          expect((renderedNode.childNodes[1] as SpanElement).text, equals('Second Child'));
        });
      });

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

      test('addProp() adds the given key-value pair', () {
        var props = new TestComponentProps();
        props.addProp('key', 'value');
        expect(props, equals({'key': 'value'}));
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

      group('setTestId (deprecated)', () {
        test('sets the correct value for the `data-test-id` key', () {
          var props = new TestComponentProps();
          props.setTestId('value');

          expect(props, equals({'data-test-id': 'value'}));
        });

        test('sets the correct value for the custom key', () {
          var props = new TestComponentProps();
          props.setTestId('value', key: 'data-custom-id');

          expect(props, equals({'data-custom-id': 'value'}));
        });

        test('does not set the value for the `data-test-id` when inTesting is false', () {
          UiProps.testMode = false;

          var props = new TestComponentProps();
          props.setTestId('value');

          expect(props, equals({}));

          UiProps.testMode = true;
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

    group('UiComponent', () {
      TestComponentComponent component;

      setUp(() {
        component = new TestComponentComponent();
        component.unwrappedProps = {};
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

      test('`tProps` (deprecated) proxies the props getter', () {
        expect(component.tProps, same(component.props));
      });

      test('newProps() returns a new UiProps instance backed by a new Map', () {
        var newProps1 = component.newProps();
        var newProps2 = component.newProps();
        expect(newProps1, const isInstanceOf<TestComponentProps>());
        expect(newProps2, const isInstanceOf<TestComponentProps>());
        expect(newProps1, isNot(same(newProps2)));
      });

      group('copyUnconsumedProps()', () {
        test('copies props, omitting keys from `consumedPropKeys`, as well as reserved react props', () {
          component = new TestComponentComponent(testConsumedPropKeys: [
            ['consumed1', 'consumed2']
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

        test('copies all props when `consumedPropKeys` is null', () {
          component = new TestComponentComponent(testConsumedPropKeys: null);

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

      test('`tState` (deprecated) proxies the props getter', () {
        expect(statefulComponent.tState, same(statefulComponent.state));
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
  final List<List<String>> consumedPropKeys;

  TestComponentComponent({testConsumedPropKeys}) : consumedPropKeys = testConsumedPropKeys;

  render() => false;

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
  render() {}

  @override
  TestStatefulComponentProps typedPropsFactory(Map propsMap) => new TestStatefulComponentProps(propsMap);
  TestStatefulComponentState typedStateFactory(Map state) => new TestStatefulComponentState(state);
}


void mapProxyTests(Map mapProxyFactory(Map proxiedMap)) {
  group('proxies the Map member:', () {
    Map proxy;
    MockMap mock;

    setUp(() {
      mock = new MockMap();
      proxy = mapProxyFactory(mock);
    });

    tearDown(() {
      // Ensure that there were no calls other than the ones we verified explicitly.
      verifyNoMoreInteractions(mock);
    });

    test('operator[]', () {
      when(mock[any]).thenReturn('value');

      expect(proxy['key'], 'value');
      verify(mock['key']);
    });

    test('operator[]=', () {
      when(mock[any] = any).thenReturn('value');

      expect(proxy['key'] = 'value', 'value');
      verify(mock['key'] = 'value');
    });

    test('addAll', () {
      var testMap = {};
      when(mock.addAll(any)).thenReturn('value');

      expect(proxy.addAll(testMap), isNull);
      verify(mock.addAll(argThat(same(testMap))));
    });

    test('clear', () {
      expect(proxy.clear(), isNull);
      verify(mock.clear());
    });

    test('putIfAbsent', () {
      var ifAbsent = () => 'absent';

      expect(proxy.putIfAbsent('key', ifAbsent), isNull);
      verify(mock.putIfAbsent('key', ifAbsent));
    });

    test('containsKey', () {
      when(mock.containsKey(any)).thenReturn(true);

      expect(proxy.containsKey('key'), isTrue);
      verify(mock.containsKey('key'));
    });

    test('containsValue', () {
      when(mock.containsValue(any)).thenReturn(true);

      expect(proxy.containsValue('value'), isTrue);
      verify(mock.containsValue('value'));
    });

    test('forEach', () {
      var callback = (key, value) {};

      expect(proxy.forEach(callback), isNull);
      verify(mock.forEach(callback));
    });

    test('isEmpty', () {
      when(mock.isEmpty).thenReturn(true);

      expect(proxy.isEmpty, isTrue);
      verify(mock.isEmpty);
    });

    test('isNotEmpty', () {
      when(mock.isNotEmpty).thenReturn(true);

      expect(proxy.isNotEmpty, isTrue);
      verify(mock.isNotEmpty);
    });

    test('length', () {
      when(mock.length).thenReturn(1);

      expect(proxy.length, 1);
      verify(mock.length);
    });

    test('keys', () {
      when(mock.keys).thenReturn(['key']);

      expect(proxy.keys, equals(['key']));
      verify(mock.keys);
    });

    test('remove', () {
      expect(proxy.remove('key'), isNull);
      verify(mock.remove('key'));
    });

    test('values', () {
      when(mock.values).thenReturn(['value']);

      expect(proxy.values, equals(['value']));
      verify(mock.values);
    });
  });
}

class MockMap extends Mock implements Map {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class DummyComponent extends react.Component {
  render() {}
}

abstract class TestRegisterComponentClassAlias {}
