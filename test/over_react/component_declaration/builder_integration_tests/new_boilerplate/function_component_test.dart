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
  group('function component integration:', () {
    test(
        'renders a component from end to end, successfully reading props via typed getters',
        () {
      var instance = render((Test()
        ..stringProp = '1'
        ..dynamicProp = '2'
        ..untypedProp = '3'
        ..customKeyProp = '4'
        ..customNamespaceProp = '5'
        ..customKeyAndNamespaceProp = '6')());
      expect(instance, isNotNull);

      var node = findDomNode(instance);
      expect(node.text, 'rendered content');
      expect(node.dataset, containsPair('prop-string-prop', '1'));
      expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
      expect(node.dataset, containsPair('prop-untyped-prop', '3'));
      expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
      expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
      expect(node.dataset,
          containsPair('prop-custom-key-and-namespace-prop', '6'));
    });

    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        var instance = Test();
        expect(instance, isA<TestProps>());
        expect(instance, isA<Map>());
      });

      test(
          'that returns a new props class implementation instance backed by an existing map',
          () {
        Map existingMap = {'TestProps.stringProp': 'test'};
        var props = Test(existingMap);

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
        expect(Test()..stringProp = 'test',
            containsPair('TestProps.stringProp', 'test'));

        expect(
            Test()..dynamicProp = 2, containsPair('TestProps.dynamicProp', 2));

        expect(Test()..untypedProp = false,
            containsPair('TestProps.untypedProp', false));
      });

      test('custom prop keys', () {
        expect(Test()..customKeyProp = 'test',
            containsPair('TestProps.custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(Test()..customNamespaceProp = 'test',
            containsPair('custom namespace~~customNamespaceProp', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(Test()..customKeyAndNamespaceProp = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });

      test('default props', () {
        expect(Test().componentDefaultProps, equals({'id': 'testId'}));
      });

      test('empty map when no default props set', () {
        expect(Test2().componentDefaultProps, equals({}));
      });

      test(
          'empty map when componentFactory is not ReactDartComponentFactoryProxy',
          () {
        expect(Dom.div().componentDefaultProps, equals({}));
      });
    });

    test('omits props declared in the props class when forwarding by default',
        () {
      var shallowInstance = renderShallow((Test()
        ..addProp('extraneous', true)
        ..stringProp = 'test'
        ..dynamicProp = 'test'
        ..untypedProp = 'test'
        ..customKeyProp = 'test'
        ..customNamespaceProp = 'test'
        ..customKeyAndNamespaceProp = 'test')());

      var shallowProps = getProps(shallowInstance);
      Iterable<String> shallowPropKeys =
          shallowProps.keys.map((key) => key as String); // ignore: avoid_as

      expect(shallowPropKeys.where((key) => !key.startsWith('data-prop-')),
          unorderedEquals(['id', 'extraneous', 'children']));
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

UiFactory<TestProps> Test = uiFunctionComponent(
    (props) {
      return (Dom.div()
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

UiFactory<TestProps> Test2 = uiFunctionComponent((props) {
  return Dom.div()();
}, $Test2PropsConfig);

mixin TestProps on UiProps {
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

//mixin Test2Props on UiProps {}
//
//UiFactory<TestProps> Test2 = uiFunctionComponent((props) => Dom.div()(), null,
//    propsFactory: PropsFactory.fromUiFactory(Test));
//
//final ArgumentErrorTest = uiFunctionComponent<TestProps>(
//    (props) => Dom.div()(), $ArgumentErrorTestPropsConfig,
//    propsFactory: PropsFactory.fromUiFactory(Test));

//
//UiFactory<TestProps> Test2 = uiFunctionComponent((props) {
//  return Dom.div()();
//}, $Test2PropsConfig, initStatics: (statics) {
//  statics.defaultProps = (statics.newProps() ..stringProp = 'default string');
//});

/// SHOULD THROW ERROR
/// UiFactory<BasicPropsMixin> Basic2 = uiFunctionComponent((props) {
///   return Dom.div()(
///     Dom.div()('prop id: ${props.id}'),
///     Dom.div()('default prop testing: ${props.basicProp}'),
///     Dom.div()('default prop testing: ${props.basic1}'),
///     Dom.div()(props.basic3, 'children: ${props.children}'),
///   );
/// }, $Basic2PropsConfig, propsFactory: PropsFactory.fromUiFactory(Basic));
///
/// final Basic2 = uiFunctionComponent<UiProps>((props) {
///   return Dom.div()(
///     Dom.div()('prop id: ${props.id}'),
///   );
/// }, null, propsFactory: PropsFactory.fromUiFactory(Basic));
///
/// UiProps with config
///
/// null config without propsFactory
