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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'function_component_test.over_react.g.dart';

main() {
  group('uiFunctionComponent', () {
    group('with generated props config', () {
      functionComponentTestHelper(Test, testId: 'testId');
    });

    group('with custom PropsFactory', () {
      functionComponentTestHelper(TestCustom, testId: 'testId2');
    });

    group('with UiProps', () {
      UiFactory<UiProps> TestUiProps = uiFunctionComponent(
          (props) => Dom.div()(), null, initStatics: (statics) {
        statics.defaultProps = (statics.newProps()..id = 'testId');
      });

      test(
          'renders a component from end to end, successfully reading props via typed getters',
          () {
        // TODO: figure out how to test rendering of function component
//        final instance = render((TestUiProps()
//          ..key = '1'
//        )());
//        expect(instance, isNotNull);
//
//        final node = findDomNode(instance);
//        expect(node.text, 'rendered content');
//        expect(node.dataset, containsPair('key', '1'));
      });

      group('initializes the factory variable with a function', () {
        test('that returns a new props class implementation instance', () {
          final instance = TestUiProps();
          expect(instance, isA<UiProps>());
          expect(instance, isA<Map>());
        });

        test(
            'that returns a new props class implementation instance backed by an existing map',
            () {
          Map existingMap = {'key': 'test'};
          final props = TestUiProps(existingMap);

          expect(props.key, equals('test'));

          props.key = 'modified';
          expect(props.key, equals('modified'));
          expect(existingMap['key'], equals('modified'));
        });
      });

      group('generates prop getters/setters with', () {
        test(
            'the props class name as a namespace and the prop name as the key by default',
            () {
          expect(TestUiProps()..key = 'test', containsPair('key', 'test'));

          expect(TestUiProps()..id = '2', containsPair('id', '2'));
        });

        test('default props', () {
          expect(TestUiProps().componentDefaultProps, equals({'id': 'testId'}));
        });

        test('empty map if no default props', () {
          UiFactory<UiProps> TestUiProps2 =
              uiFunctionComponent((props) => Dom.div()(), null);
          expect(TestUiProps2().componentDefaultProps, isEmpty);
        });
      });
    });

    test(
        'empty map when componentFactory is not ReactDartComponentFactoryProxy',
        () {
      expect(Dom.div().componentDefaultProps, isEmpty);
    });

    test('empty map when no default props set', () {
      expect(TestNoDefaults().componentDefaultProps, isEmpty);
    });

    group('throws an error when', () {
      test('both propsFactory and config are set', () {
        expect(
            () => uiFunctionComponent<TestProps>(
                  (props) => Dom.div()(),
                  $TestPropsConfig,
                  propsFactory: PropsFactory.fromUiFactory(Test),
                ),
            throwsArgumentError);
      });

      test('config is not provided when using custom props class', () {
        expect(
            () => uiFunctionComponent<TestProps>(
                  (props) => Dom.div()(),
                  null,
                ),
            throwsArgumentError);
      });
    });
  });
}

void functionComponentTestHelper(UiFactory<TestProps> factory,
    {String testId = ''}) {
  test(
      'renders a component from end to end, successfully reading props via typed getters',
      () {
    // TODO: figure out how to test rendering of function component
//    final instance = render((factory()
//      ..stringProp = '1'
//      ..dynamicProp = '2'
//      ..untypedProp = '3'
//      ..customKeyProp = '4'
//      ..customNamespaceProp = '5'
//      ..customKeyAndNamespaceProp = '6')());
//    expect(instance, isNotNull);
//
//    final node = findDomNode(instance);
//    expect(node.text, 'rendered content');
//    expect(node.dataset, containsPair('prop-string-prop', '1'));
//    expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
//    expect(node.dataset, containsPair('prop-untyped-prop', '3'));
//    expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
//    expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
//    expect(
//        node.dataset, containsPair('prop-custom-key-and-namespace-prop', '6'));
  });

  group('initializes the factory variable with a function', () {
    test('that returns a new props class implementation instance', () {
      final instance = factory();
      expect(instance, isA<TestProps>());
      expect(instance, isA<Map>());
    });

    test(
        'that returns a new props class implementation instance backed by an existing map',
        () {
      Map existingMap = {'TestProps.stringProp': 'test'};
      final props = factory(existingMap);

      expect(props.stringProp, equals('test'));

      props.stringProp = 'modified';
      expect(props.stringProp, equals('modified'));
      expect(existingMap['TestProps.stringProp'], equals('modified'));
    });
  });

  group('generates prop getters/setters with', () {
    test(
        'the props class name as a namespace and the prop name as the key by default',
        () {
      expect(factory()..stringProp = 'test',
          containsPair('TestProps.stringProp', 'test'));

      expect(
          factory()..dynamicProp = 2, containsPair('TestProps.dynamicProp', 2));

      expect(factory()..untypedProp = false,
          containsPair('TestProps.untypedProp', false));
    });

    test('custom prop keys', () {
      expect(factory()..customKeyProp = 'test',
          containsPair('TestProps.custom key!', 'test'));
    });

    test('custom prop key namespaces', () {
      expect(factory()..customNamespaceProp = 'test',
          containsPair('custom namespace~~customNamespaceProp', 'test'));
    });

    test('custom prop keys and namespaces', () {
      expect(factory()..customKeyAndNamespaceProp = 'test',
          containsPair('custom namespace~~custom key!', 'test'));
    });

    test('default props', () {
      expect(factory().componentDefaultProps, equals({'id': testId}));
    });
  });
}

UiFactory<TestProps> Test = uiFunctionComponent(
    (props) {
      return (Dom.div()
        ..ref = props.forwardedRef
        ..addProp('data-prop-string-prop', props.stringProp)
        ..addProp('data-prop-dynamic-prop', props.dynamicProp)
        ..addProp('data-prop-untyped-prop', props.untypedProp)
        ..addProp('data-prop-custom-key-prop', props.customKeyProp)
        ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
        ..addProp('data-prop-custom-key-and-namespace-prop',
            props.customKeyAndNamespaceProp))('rendered content');
    },
    $TestPropsConfig,
    initStatics: (statics) {
      statics.defaultProps = (statics.newProps()..id = 'testId');
    });

UiFactory<TestProps> TestCustom = uiFunctionComponent(
    (props) {
      return (Dom.div()
        ..ref = props.forwardedRef
        ..addProp('data-prop-string-prop', props.stringProp)
        ..addProp('data-prop-dynamic-prop', props.dynamicProp)
        ..addProp('data-prop-untyped-prop', props.untypedProp)
        ..addProp('data-prop-custom-key-prop', props.customKeyProp)
        ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
        ..addProp('data-prop-custom-key-and-namespace-prop',
            props.customKeyAndNamespaceProp))('rendered content');
    },
    null,
    propsFactory: PropsFactory.fromUiFactory(Test),
    initStatics: (statics) {
      statics.defaultProps = (statics.newProps()..id = 'testId2');
    });

UiFactory<TestProps> TestNoDefaults = uiFunctionComponent((props) {
  return Dom.div()();
}, $TestNoDefaultsPropsConfig);

mixin TestProps on UiProps {
  Ref forwardedRef;
  String stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}
