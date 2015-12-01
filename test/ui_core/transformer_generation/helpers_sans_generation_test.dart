library ui_core.transformer_generation.helpers_sans_generation_test;

import 'dart:js';

import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/transformer_generation/helpers_sans_generation.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart' show Dom;

main() {
  group('transformation generation helpers (sans generation):', () {
    group('renders a DOM component with the correct children when', () {
      test('a single child is passed in', () {
        var child = 'Only child';
        var renderedInstance = render(Dom.div()(child));

        expect(getJsChildren(renderedInstance), equals(child));
      });

      test('children are set via a list', () {
        var children = ['First Child', 'Second Child'];
        var renderedInstance = render(Dom.div()(children));

        expect(getJsChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsChildren(renderedInstance), equals(children));
      });

      test('children are set via an iterable', () {
        var children = (() sync* {
          yield 'First Child';
          yield 'Second Child';
        })();
        var renderedInstance = render(Dom.div()(children));

        expect(getJsChildren(renderedInstance), new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsChildren(renderedInstance), orderedEquals(children));
      });

      test('children are set variadically via noSuchMethod', () {
        var firstChild = 'First Child';
        var secondChild = 'Second Child';
        var renderedInstance = render(Dom.div()(firstChild, secondChild));

        expect(getJsChildren(renderedInstance), new isInstanceOf<JsArray>(), reason: 'Should not be a Dart Object');
        expect(getJsChildren(renderedInstance), equals([firstChild, secondChild]));
      });
    });

    group('renders a composite Dart component with the correct children when', () {
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

        expect(getJsChildren(renderedInstance), new isInstanceOf<JsArray>(), reason: 'Should not be a Dart Object');
        expect(getJsChildren(renderedInstance), equals([firstChild, secondChild]));
      });
    });

    group('UiComponent', () {
      TestComponentComponent component;

      setUp(() {
        component = new TestComponentComponent();
        component.unwrappedProps = {};
      });

      group('props', () {
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
    });

    group('UiStatefulComponent', () {
      TestStatefulComponentComponent statefulComponent;

      setUp(() {
        statefulComponent = new TestStatefulComponentComponent();
        statefulComponent.unwrappedState = {};
      });

      group('state', () {
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
    });
  });
}

dynamic getJsChildren(JsObject instance) => getJsProps(instance)['children'];

dynamic getDartChildren(JsObject renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}


UiFactory<TestComponentProps> TestComponent = ([Map props]) => new TestComponentProps(props);

class TestComponentProps extends UiProps with MapViewMixin {
  @override final Function componentFactory = _TestComponentComponentFactory;
  @override final Map props;

  TestComponentProps([Map props]) : this.props = props ?? ({});
}

ReactComponentFactory _TestComponentComponentFactory = registerComponent(() => new TestComponentComponent());
class TestComponentComponent extends UiComponent<TestComponentProps> {
  render() {}

  @override
  TestComponentProps typedPropsFactory(Map propsMap) => new TestComponentProps(propsMap);
}


UiFactory<TestStatefulComponentProps> TestStatefulComponent = ([Map props]) => new TestStatefulComponentProps(props);

class TestStatefulComponentProps extends UiProps with MapViewMixin {
  @override final Function componentFactory = _TestStatefulComponentComponentFactory;
  @override final Map props;

  TestStatefulComponentProps([Map props]) : this.props = props ?? ({});
}

class TestStatefulComponentState extends UiState with MapViewMixin {
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

