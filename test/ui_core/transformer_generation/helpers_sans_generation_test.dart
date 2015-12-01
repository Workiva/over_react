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
  });
}

dynamic getJsChildren(JsObject instance) => getJsProps(instance)['children'];

dynamic getDartChildren(JsObject renderedInstance) {
  assert(isDartComponent(renderedInstance));
  return getProps(renderedInstance)['children'];
}


UiFactory<TestComponentProps> TestComponent = ([Map props]) => new TestComponentProps(props);

class TestComponentProps extends UiProps with MapViewMixin {
  @override
  final Function componentFactory = _TestComponentComponentFactory;
  @override
  final Map props;

  TestComponentProps([Map props]) : this.props = props ?? ({});

  @override
  String get propKeyNamespace => null;
}

ReactComponentFactory _TestComponentComponentFactory = registerComponent(() => new TestComponentComponent());
class TestComponentComponent extends UiComponent<TestComponentProps> {
  render() {}

  @override
  TestComponentProps typedPropsFactory(Map propsMap) => new TestComponentProps(propsMap);
}

