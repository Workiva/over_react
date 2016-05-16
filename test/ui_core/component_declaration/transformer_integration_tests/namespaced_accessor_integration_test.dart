library ui_core.component_declaration.transformer_integration_tests.namespaced_accessor_integration_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

main() {
  group('transformed custom namespaced props/state integration:', () {
    group('generates prop getters/setters, when there is a custom key namespace, with', () {
      test('the custom namespace and the prop name as the key by default', () {
        expect(NamespacedAccessorTest()..stringProp = 'test',
            containsPair('custom props class namespace**stringProp', 'test'));

        expect(NamespacedAccessorTest()..dynamicProp = 2,
            containsPair('custom props class namespace**dynamicProp', 2));

        expect(NamespacedAccessorTest()..untypedProp = false,
            containsPair('custom props class namespace**untypedProp', false));
      });

      test('custom prop keys', () {
        expect(NamespacedAccessorTest()..customKeyProp = 'test',
            containsPair('custom props class namespace**custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(NamespacedAccessorTest()..customNamespaceProp = 'test',
            containsPair('custom namespace~~customNamespaceProp', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(NamespacedAccessorTest()..customKeyAndNamespaceProp = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });
    });

    group('generates state getters/setters, when there is a custom key namespace, with', () {
      NamespacedAccessorTestComponent component;

      setUp(() {
        var renderedInstance = render(NamespacedAccessorTest()());
        component = getDartComponent(renderedInstance);
      });

      test('the custom namespace and the state name as the key by default', () {
        expect(component.newState()..stringState = 'test',
            containsPair('custom state class namespace**stringState', 'test'));

        expect(component.newState()..dynamicState = 2,
            containsPair('custom state class namespace**dynamicState', 2));

        expect(component.newState()..untypedState = false,
            containsPair('custom state class namespace**untypedState', false));
      });

      test('custom state keys', () {
        expect(component.newState()..customKeyState = 'test',
            containsPair('custom state class namespace**custom key!', 'test'));
      });

      test('custom state key namespaces', () {
        expect(component.newState()..customNamespaceState = 'test',
            containsPair('custom namespace~~customNamespaceState', 'test'));
      });

      test('custom state keys and namespaces', () {
        expect(component.newState()..customKeyAndNamespaceState = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });
    });

    test('omits props declared in the @Props() class when forwarding by default', () {
      var shallowInstance = renderShallow((NamespacedAccessorTest()
        ..addProp('extraneous', true)
        ..stringProp = 'test'
        ..dynamicProp = 'test'
        ..untypedProp = 'test'
        ..customKeyProp = 'test'
        ..customNamespaceProp = 'test'
        ..customKeyAndNamespaceProp = 'test'
      )());

      var shallowProps = getProps(shallowInstance);

      expect(shallowProps.keys, unorderedEquals(['extraneous', 'children']));
    });
  });
}


@Factory()
UiFactory<NamespacedAccessorTestProps> NamespacedAccessorTest;

@Props(keyNamespace: 'custom props class namespace**')
class NamespacedAccessorTestProps extends UiProps {
  String stringProp;
  dynamic dynamicProp;
  var untypedProp;

  @Accessor(key: 'custom key!')
  var customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  var customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  var customKeyAndNamespaceProp;
}

@State(keyNamespace: 'custom state class namespace**')
class NamespacedAccessorTestState extends UiState {
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
class NamespacedAccessorTestComponent extends UiStatefulComponent<NamespacedAccessorTestProps, NamespacedAccessorTestState> {
  @override
  render() => (Dom.div()
    ..addProps(copyUnconsumedProps())
  )('rendered content');
}
