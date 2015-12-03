library ui_core.component_declaration.transformer_integration_tests.stateful_component_integration_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

main() {
  group('transformed stateful component integration:', () {
    test('state class cannot be instantiated directly', () {
      expect(() {
        new StatefulComponentTestState();
      }, throws);
    });

    test('renders a component from end to end', () {
      var renderedInstance = render(StatefulComponentTest()());
      expect(renderedInstance, isNotNull);

      var node = findDomNode(renderedInstance);
      expect(node.text, 'rendered content');
    });

    group('generates state getters/setters with', () {
      StatefulComponentTestComponent component;

      setUp(() {
        var renderedInstance = render(StatefulComponentTest()());
        component = getDartComponent(renderedInstance);
      });

      test('prop keys using the props class name as a namespace and the prop name as the key by default', () {
        expect(component.newState()..stringState = 'test',
            containsPair('StatefulComponentTestState.stringState', 'test'));

        expect(component.newState()..dynamicState = 2,
            containsPair('StatefulComponentTestState.dynamicState', 2));

        expect(component.newState()..untypedState = false,
            containsPair('StatefulComponentTestState.untypedState', false));
      });

      test('custom prop keys', () {
        expect(component.newState()..customKeyState = 'test',
            containsPair('StatefulComponentTestState.custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(component.newState()..customNamespaceState = 'test',
            containsPair('custom namespace~~customNamespaceState', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(component.newState()..customKeyAndNamespaceState = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });
    });
  });
}


@Factory()
UiFactory<StatefulComponentTestProps> StatefulComponentTest;

@Props()
class StatefulComponentTestProps extends UiProps {}

@State()
class StatefulComponentTestState extends UiState {
  String stringState;
  dynamic dynamicState;
  var untypedState;

  @Accessor(key: 'custom key!')
  var customKeyState;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceState;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceState;
}

@Component()
class StatefulComponentTestComponent extends UiStatefulComponent<StatefulComponentTestProps, StatefulComponentTestState> {
  render() => (Dom.div()
    ..addProps(copyUnconsumedProps())
  )('rendered content');
}
