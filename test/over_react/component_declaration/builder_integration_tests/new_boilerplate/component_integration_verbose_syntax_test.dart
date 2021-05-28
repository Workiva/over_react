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
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'component_integration_verbose_syntax_test.over_react.g.dart';

main() {
  group('(New boilerplate, verbose syntax) component integration:', () {
    test('renders a component from end to end, successfully reading props via typed getters', () {
      var instance = render((ComponentTest()
        ..stringProp = '1'
        ..dynamicProp = '2'
        ..untypedProp = '3'
        ..customKeyProp = '4'
        ..customNamespaceProp = '5'
        ..customKeyAndNamespaceProp = '6'
      )());
      expect(instance, isNotNull);

      var node = findDomNode(instance)!;
      expect(node.text, 'rendered content');
      expect(node.dataset, containsPair('prop-string-prop', '1'));
      expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
      expect(node.dataset, containsPair('prop-untyped-prop', '3'));
      expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
      expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
      expect(node.dataset, containsPair('prop-custom-key-and-namespace-prop', '6'));
    });

    test('(Dart >= 2.9.0 syntax) renders a component from end to end, successfully reading props via typed getters', () {
      var instance = render((ComponentTest290()
        ..stringProp = '1'
        ..dynamicProp = '2'
        ..untypedProp = '3'
        ..customKeyProp = '4'
        ..customNamespaceProp = '5'
        ..customKeyAndNamespaceProp = '6'
      )());
      expect(instance, isNotNull);

      var node = findDomNode(instance)!;
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
        var instance = ComponentTest();
        expect(instance, isA<ComponentTestProps>());
        expect(instance, isA<Map>());
      });

      test('that returns a new props class implementation instance backed by an existing map', () {
        Map existingMap = {'ComponentTestPropsMixin.stringProp': 'test'};
        var props = ComponentTest(existingMap);

        expect(props.stringProp, equals('test'));

        props.stringProp = 'modified';
        expect(props.stringProp, equals('modified'));
        expect(existingMap['ComponentTestPropsMixin.stringProp'], equals('modified'));
      });
    });

    group('generates prop getters/setters', () {
      test('and throws when set directly with a normal map', () {
        expect(() => render((ComponentTest()..shouldSetPropsDirectly = true)()),
            throwsA(hasToStringValue(contains('Component2.props should never be set directly '
                'in production.'))));
      }, tags: 'ddc');

      test('and does not throw when set directly using a typedJsFactory', () {
        TestJacket jacket = mount((ComponentTest()
        ..shouldSetPropsDirectly = true
        ..shouldUseJsFactory = true)());

        expect(ComponentTest(jacket.getProps()).shouldUseJsFactory, isTrue,
            reason: 'Sanity check to ensure that setting props directly does '
                'not throw.');
      });
    });

    test('omits all props mixed into the props class when forwarding by default', () {
      final builder = ComponentTest()
        ..addProp('extraneous', true)
        ..stringProp = 'test'
        ..dynamicProp = 'test'
        ..untypedProp = 'test'
        ..customKeyProp = 'test'
        ..customNamespaceProp = 'test'
        ..customKeyAndNamespaceProp = 'test'
        ..propsMixinProp = 'test';

      final mixinPropKey = getPropKey<ComponentTestProps>((p) => p.propsMixinProp, ComponentTest);
      expect(builder, containsPair(mixinPropKey, 'test'),
          reason: 'test setup check: mixin prop accessors should write props as expected');

      var shallowInstance = renderShallow(builder());
      var shallowProps = getProps(shallowInstance);
      Iterable<String?> shallowPropKeys = shallowProps.keys.map((key) => key as String?); // ignore: avoid_as

      expect(
          shallowPropKeys.where((key) => !key!.startsWith('data-prop-')),
          unorderedEquals({
            'id',
            'extraneous',
            'children',
          }));
    });
  });
}

UiFactory<ComponentTestProps290Props> ComponentTest290 = castUiFactory(_$ComponentTest290); // ignore: undefined_identifier

class ComponentTestProps290Props = UiProps with ComponentTestPropsMixin, TestPropsMixin;

class ComponentTest290Component extends UiComponent2<ComponentTestProps290Props> {
  @override
  Map get defaultProps => newProps()
    ..id = 'testId'
    ..shouldSetPropsDirectly = false
    ..shouldUseJsFactory = false;

  @override
  render() => (Dom.div()
    ..modifyProps(addUnconsumedProps)
    ..addProp('data-prop-string-prop', props.stringProp)
    ..addProp('data-prop-dynamic-prop', props.dynamicProp)
    ..addProp('data-prop-untyped-prop', props.untypedProp)
    ..addProp('data-prop-custom-key-prop', props.customKeyProp)
    ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
    ..addProp('data-prop-custom-key-and-namespace-prop', props.customKeyAndNamespaceProp)
  )('rendered content');

  @override
  void componentDidMount() {
    if (props.shouldSetPropsDirectly!) {
      if (props.shouldUseJsFactory!) {
        this.props = typedPropsFactoryJs(JsBackedMap());
      } else {
        this.props = {'shouldSetPropsDirectly': false};
      }
    }
  }
}

mixin TestPropsMixin on UiProps {
  dynamic propsMixinProp;
}

// ignore: undefined_identifier, invalid_assignment
UiFactory<ComponentTestProps> ComponentTest = _$ComponentTest;

mixin ComponentTestPropsMixin on UiProps {
  String? stringProp;
  bool? shouldSetPropsDirectly;
  bool? shouldUseJsFactory;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}

class ComponentTestProps = UiProps with ComponentTestPropsMixin, TestPropsMixin;

class ComponentTestComponent extends UiComponent2<ComponentTestProps> {
  @override
  Map get defaultProps => newProps()
    ..id = 'testId'
    ..shouldSetPropsDirectly = false
    ..shouldUseJsFactory = false;

  @override
  render() => (Dom.div()
    ..modifyProps(addUnconsumedProps)
    ..addProp('data-prop-string-prop', props.stringProp)
    ..addProp('data-prop-dynamic-prop', props.dynamicProp)
    ..addProp('data-prop-untyped-prop', props.untypedProp)
    ..addProp('data-prop-custom-key-prop', props.customKeyProp)
    ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
    ..addProp('data-prop-custom-key-and-namespace-prop', props.customKeyAndNamespaceProp)
  )('rendered content');

  @override
  void componentDidMount() {
    if (props.shouldSetPropsDirectly!) {
      if (props.shouldUseJsFactory!) {
        this.props = typedPropsFactoryJs(JsBackedMap());
      } else {
        this.props = {'shouldSetPropsDirectly': false};
      }
    }
  }
}
