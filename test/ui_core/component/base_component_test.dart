library base_component_test;

import 'dart:js';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Main entry point for BaseComponent testing
main() {
  group('ComponentDefinition', () {
    group('renders a DomComponentDefinition with the correct children', () {
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
        var children = (() sync*{
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

    group('renders a BaseComponentDefinition with the correct children when', () {
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
        var children = (() sync*{
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
  });
}

dynamic getJsChildren(JsObject instance) => getJsProps(instance)['children'];

dynamic getDartChildren(JsObject renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}

TestComponentDefinition TestComponent() => new TestComponentDefinition({});

class TestComponentDefinition extends BaseComponentDefinition {
  TestComponentDefinition(Map props) : super(_TestComponentComponentFactory, props);
}

ReactComponentFactory _TestComponentComponentFactory = react.registerComponent(() => new _TestComponent());
class _TestComponent extends BaseComponent<TestComponentDefinition> {
  @override
  render() => false;

  @override
  TestComponentDefinition typedPropsFactory(Map propsMap) => new TestComponentDefinition(propsMap);
}
