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

library over_react.component_declaration.transformer_integration_tests.component_integration_from_part_of_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import 'required_prop_integration_from_part_of_test.dart';
import '../../../test_util/test_util.dart';

main() {
  group('transformed component integration with part of:', () {
    test('component class can be instantiated directly', () {
      var instance;
      expect(() {
        instance = new ComponentInPartComponent();
      }, returnsNormally);
      expect(instance, const isInstanceOf<ComponentInPartComponent>());
    });

    test('renders a component from end to end, successfully reading props via typed getters', () {
      var instance = render((ComponentInPart()
        ..stringProp = '1'
        ..dynamicProp = '2'
        ..untypedProp = '3'
        ..customKeyProp = '4'
        ..customNamespaceProp = '5'
        ..customKeyAndNamespaceProp = '6'
      )());
      expect(instance, isNotNull);

      var node = findDomNode(instance);
      expect(node.text, 'rendered content');
      expect(node.dataset, containsPair('prop-string-prop', '1'));
      expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
      expect(node.dataset, containsPair('prop-untyped-prop', '3'));
      expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
      expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
      expect(node.dataset, containsPair('prop-custom-key-and-namespace-prop', '6'));
    });

    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        var instance = ComponentInPart();
        expect(instance, new isInstanceOf<ComponentInPartProps>());
        expect(instance, new isInstanceOf<Map>());
      });

      test('that returns a new props class implementation instance backed by an existing map', () {
        Map existingMap = {'ComponentInPartProps.stringProp': 'test'};
        var props = ComponentInPart(existingMap);

        expect(props.stringProp, equals('test'));

        props.stringProp = 'modified';
        expect(props.stringProp, equals('modified'));
        expect(existingMap['ComponentInPartProps.stringProp'], equals('modified'));
      });
    });

    group('generates prop getters/setters with', () {
      test('the props class name as a namespace and the prop name as the key by default', () {
        expect(ComponentInPart()..stringProp = 'test',
            containsPair('ComponentInPartProps.stringProp', 'test'));

        expect(ComponentInPart()..dynamicProp = 2,
            containsPair('ComponentInPartProps.dynamicProp', 2));

        expect(ComponentInPart()..untypedProp = false,
            containsPair('ComponentInPartProps.untypedProp', false));

      });

      test('custom prop keys', () {
        expect(ComponentInPart()..customKeyProp = 'test',
            containsPair('ComponentInPartProps.custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(ComponentInPart()..customNamespaceProp = 'test',
            containsPair('custom namespace~~customNamespaceProp', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(ComponentInPart()..customKeyAndNamespaceProp = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });
    });

    test('omits props declared in the @Props() class when forwarding by default', () {
      var shallowInstance = renderShallow((ComponentInPart()
        ..addProp('extraneous', true)
        ..stringProp = 'test'
        ..dynamicProp = 'test'
        ..untypedProp = 'test'
        ..customKeyProp = 'test'
        ..customNamespaceProp = 'test'
        ..customKeyAndNamespaceProp = 'test'
      )());

      var shallowProps = getProps(shallowInstance);
      Iterable<String> shallowPropKeys = shallowProps.keys;

      expect(shallowPropKeys.where((String key) => !key.startsWith('data-prop-')), unorderedEquals(['extraneous', 'children']));
    });

    requiredPropsFromPartOfIntegrationTest();
  });
}

@Factory()
// ignore: undefined_identifier
UiFactory<ComponentInPartProps> ComponentInPart = $ComponentInPart;

@Props()
class ComponentInPartProps extends UiProps {
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

@Component()
class ComponentInPartComponent extends UiComponent<ComponentInPartProps> {
  @override
  render() => (Dom.div()
    ..addProps(copyUnconsumedProps())
    ..addProp('data-prop-string-prop', props.stringProp)
    ..addProp('data-prop-dynamic-prop', props.dynamicProp)
    ..addProp('data-prop-untyped-prop', props.untypedProp)
    ..addProp('data-prop-custom-key-prop', props.customKeyProp)
    ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
    ..addProp('data-prop-custom-key-and-namespace-prop', props.customKeyAndNamespaceProp)
  )('rendered content');
}