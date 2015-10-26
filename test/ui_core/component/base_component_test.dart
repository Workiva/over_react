library base_component_test;

import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../test_util/react_util.dart';

/// Main entry point for BaseComponent testing
main() {
  group('ComponentDefinition', () {
    group('renders a DomComponentDefinition with the correct children', () {
      test('children is null', () {
        var renderedInstance = render(Dom.div()(null));

        expect(getJsProps(renderedInstance)['children'], isNull);
      });

      test('a single child is passed in', () {
        var child = 'Only child';
        var renderedInstance = render(Dom.div()(child));

        expect(getJsProps(renderedInstance)['children'], equals(child));
      });

      test('children are set via a list', () {
        var children = ['First Child', 'Second Child'];
        var renderedInstance = render(Dom.div()(children));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsProps(renderedInstance)['children'], equals(children));
      });

      test('children are set via an iterable', () {
        var children = (() sync*{
          yield 'First Child';
          yield 'Second Child';
        })();
        var renderedInstance = render(Dom.div()(children));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsProps(renderedInstance)['children'], orderedEquals(children));
      });

      test('children are set variadically via noSuchMethod', () {
        var firstChild = 'First Child';
        var secondChild = 'Second Child';
        var renderedInstance = render(Dom.div()(firstChild, secondChild));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<JsArray>(), reason: 'Should not be a Dart Object');
        expect(getJsProps(renderedInstance)['children'], equals([firstChild, secondChild]));
      });
    });

    group('renders a BaseComponentDefinition with the correct children when', () {
      test('children is null', () {
        var renderedInstance = render(TestComponent()(null));

        expect(getProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should still be the Dart Object');
        expect(getProps(renderedInstance)['children'], isEmpty);

        expect(getJsProps(renderedInstance)['children'], isNull);
      });

      test('a single child is passed in', () {
        var child = 'Only child';
        var renderedInstance = render(TestComponent()(child));

        expect(getProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should still be the Dart Object');
        expect(getProps(renderedInstance)['children'], equals([child]));

        expect(getJsProps(renderedInstance)['children'], equals(child));
      });

      test('children are set via a list', () {
        var children = ['First Child', 'Second Child'];
        var renderedInstance = render(TestComponent()(children));

        expect(getProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should still be the Dart Object');
        expect(getProps(renderedInstance)['children'], equals(children));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsProps(renderedInstance)['children'], equals(children));
      });

      test('children are set via an iterable', () {
        var children = (() sync*{
          yield 'First Child';
          yield 'Second Child';
        })();
        var renderedInstance = render(TestComponent()(children));

        expect(getProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should still be the Dart Object');
        expect(getProps(renderedInstance)['children'], orderedEquals(children));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should be a list because lists will be JSified');
        expect(getJsProps(renderedInstance)['children'], orderedEquals(children));
      });

      test('children are set variadically via noSuchMethod', () {
        var firstChild = 'First Child';
        var secondChild = 'Second Child';
        var renderedInstance = render(TestComponent()(firstChild, secondChild));

        expect(getProps(renderedInstance)['children'], new isInstanceOf<List>(), reason: 'Should still be the Dart Object');
        expect(getProps(renderedInstance)['children'], equals([firstChild, secondChild]));

        expect(getJsProps(renderedInstance)['children'], new isInstanceOf<JsArray>(), reason: 'Should not be a Dart Object');
        expect(getJsProps(renderedInstance)['children'], equals([firstChild, secondChild]));
      });
    });
  });
}

TestComponentDefinition TestComponent() => new TestComponentDefinition({});

class TestComponentDefinition extends BaseComponentDefinition {
  TestComponentDefinition(Map props) : super(_TestComponentComponentFactory, props);
}

ReactComponentFactory _TestComponentComponentFactory = react.registerComponent(() => new _TestComponent());
class _TestComponent extends BaseComponent<TestComponentDefinition> {
  @override
  render() {
  }

  @override
  TestComponentDefinition typedPropsFactory(Map propsMap) => new TestComponentDefinition(propsMap);
}
