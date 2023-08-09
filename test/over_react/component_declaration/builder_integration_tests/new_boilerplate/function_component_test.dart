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

import 'dart:developer';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'function_component_test.over_react.g.dart';

main() {
  group('uiFunction', () {
    group('with generated props config', () {
      functionComponentTestHelper(Test);
    });

    group('with public generated props config (deprecated)', () {
      functionComponentTestHelper(TestPublic);
    });

    group('with custom PropsFactory', () {
      functionComponentTestHelper(TestCustom, testId: 'testIdCustom');
    });

    group('with no left hand typing', () {
      functionComponentTestHelper(NoLHSTest, testId: 'testIdNoLHS');
    });

    group('with private prefix', () {
      functionComponentTestHelper(_Test, testId: '_testId');
    });

    uiPropsTest(uiFunction(
              (props) => (Dom.div()..addTestId('testId3'))('id: ${props.id}'),
          UiFactoryConfig(),
        ));

    group('throws an error when', () {
      test('config is null', () {
        expect(
            () => uiFunction<TestProps>(
                  (props) => Dom.div()(),
                  null,
                ),
            throwsArgumentError);
      });

      test('props factory is not provided when using custom props class', () {
        expect(
            () => uiFunction<TestProps>(
                  (props) => Dom.div()(),
                  UiFactoryConfig(displayName: 'Foo'),
                ),
            throwsArgumentError);
      });

      test('config not the correct type', () {
        expect(
                () => uiFunction<TestProps>(
                  (props) => Dom.div()(),
              'foo',
            ),
            throwsArgumentError);
      });
    });
  });

  group('uiForwardRef', () {
    group('with generated props config', () {
      functionComponentTestHelper(BasicUiForwardRef);
    });

    group('with custom PropsFactory', () {
      functionComponentTestHelper(CustomUiForwardRef, testId: 'testIdCustom');
    });

    group('with no left hand typing', () {
      functionComponentTestHelper(NoLHSUiForwardRefTest, testId: 'testIdNoLHS');
    });

    group('with private prefix', () {
      functionComponentTestHelper(_UiForwardRef, testId: '_testId');
    });

    uiPropsTest(uiForwardRef(
          (props, ref) => (Dom.div()
              ..addTestId('testId3')
              ..ref = ref
          )('id: ${props.id}'),
      Dom.div.asForwardRefConfig(),
    ));

    group('throws an error when', () {
      test('config is null', () {
        expect(
                () => uiForwardRef<TestProps>(
                  (props, ref) => Dom.div()(),
              null,
            ),
            throwsArgumentError);
      });

      test('props factory is not provided when using custom props class', () {
        expect(
                () => uiForwardRef<TestProps>(
                  (props, ref) => Dom.div()(),
              UiFactoryConfig(displayName: 'Foo'),
            ),
            throwsArgumentError);
      });

      test('config not the correct type', () {
        expect(
                () => uiForwardRef<TestProps>(
                  (props, ref) => Dom.div()(),
              'foo',
            ),
            throwsArgumentError);
      });
    });
  });
}

void uiPropsTest(UiFactory<UiProps> factory) {
  group('with UiProps', () {
    test(
        'renders a component from end to end, successfully reading props via typed getters',
            () {
          final jacket = mount((factory()..id = '1')());
          final node = queryAllByTestId(jacket.mountNode, 'testId3').first;

          expect(node, isA<DivElement>());
          expect(node.text, 'id: 1');
        });

    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        final instance = factory();
        expect(instance, isA<UiProps>());
        expect(instance, isA<Map>());
      });

      test(
          'that returns a new props class implementation instance backed by an existing map',
              () {
            Map existingMap = {'key': 'test'};
            final props = factory(existingMap);

            expect(props.key, equals('test'));

            props.key = 'modified';
            expect(props.key, equals('modified'));
            expect(existingMap['key'], equals('modified'));
          });
    });

    test(
        'generates prop getters/setters with the prop name as the key by default',
            () {
          expect(factory()..key = 'test', containsPair('key', 'test'));
          expect(factory()..id = '2', containsPair('id', '2'));
        });
  });
}

void functionComponentTestHelper(UiFactory<TestProps> factory,
    {String testId = 'testId'}) {
  test(
      'renders a component from end to end, successfully reading props via typed getters',
      () {
    final jacket = mount((factory()
      ..stringProp = '1'
      ..dynamicProp = '2'
      ..untypedProp = '3'
      ..customKeyProp = '4'
      ..customNamespaceProp = '5'
      ..customKeyAndNamespaceProp = '6')());
    final node = queryAllByTestId(jacket.mountNode, testId).first;

    expect(node, isA<DivElement>());

    expect(node.text, 'rendered content');
    expect(node.dataset, containsPair('prop-string-prop', '1'));
    expect(node.dataset, containsPair('prop-dynamic-prop', '2'));
    expect(node.dataset, containsPair('prop-untyped-prop', '3'));
    expect(node.dataset, containsPair('prop-custom-key-prop', '4'));
    expect(node.dataset, containsPair('prop-custom-namespace-prop', '5'));
    expect(
        node.dataset, containsPair('prop-custom-key-and-namespace-prop', '6'));
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
      Map existingMap = {'TestPropsMixin.stringProp': 'test'};
      final props = factory(existingMap);

      expect(props.stringProp, equals('test'));

      props.stringProp = 'modified';
      expect(props.stringProp, equals('modified'));
      expect(existingMap['TestPropsMixin.stringProp'], equals('modified'));
    });
  });

  group('generates prop getters/setters with', () {
    test(
        'the props class name as a namespace and the prop name as the key by default',
        () {
      expect(factory()..stringProp = 'test',
          containsPair('TestPropsMixin.stringProp', 'test'));

      expect(
          factory()..dynamicProp = 2, containsPair('TestPropsMixin.dynamicProp', 2));

      expect(factory()..untypedProp = false,
          containsPair('TestPropsMixin.untypedProp', false));
    });

    test('custom prop keys', () {
      expect(factory()..customKeyProp = 'test',
          containsPair('TestPropsMixin.custom key!', 'test'));
    });

    test('custom prop key namespaces', () {
      expect(factory()..customNamespaceProp = 'test',
          containsPair('custom namespace~~customNamespaceProp', 'test'));
    });

    test('custom prop keys and namespaces', () {
      expect(factory()..customKeyAndNamespaceProp = 'test',
          containsPair('custom namespace~~custom key!', 'test'));
    });
  });

  group('can pass along unconsumed props', () {
    const stringProp = 'a string';
    const anotherProp = 'this should be filtered';
    const className = 'aClassName';

    group('using `addUnconsumedProps`', () {
      TestProps initialProps;
      TestProps secondProps;

      setUp(() {
        initialProps = (factory()
          ..stringProp = stringProp
          ..anotherProp = anotherProp
        );

        secondProps = factory();

        expect(secondProps.stringProp, isNull, reason: 'Test setup sanity check');
        expect(secondProps.anotherProp, isNull, reason: 'Test setup sanity check');
      });

      test('', () {
        secondProps.addUnconsumedProps(initialProps, []);
        expect(secondProps.anotherProp, anotherProp);
        expect(secondProps.stringProp, stringProp);
      });

      test('and consumed props are correctly filtered', () {
        final consumedProps = initialProps.staticMeta.forMixins({TestPropsMixin});
        secondProps.addUnconsumedProps(initialProps, consumedProps);
        expect(secondProps.stringProp, isNull);
        expect(secondProps.anotherProp, anotherProp);
      });
    });

    testPropsToForward(factory: factory, modifyProps: true);
    testPropsToForward(factory: factory, modifyProps: false);

    group('using `addUnconsumedDomProps`', ()
    {
      TestProps initialProps;
      TestProps secondProps;

      setUp(() {
        initialProps = (factory()
          ..stringProp = stringProp
          ..anotherProp = anotherProp
          ..className = className
        );

        secondProps = factory();

        expect(secondProps.className, isNull, reason: 'Test setup sanity check');
      });

      test('', () {
        secondProps.addUnconsumedDomProps(initialProps, []);
        expect(secondProps.stringProp, isNull);
        expect(secondProps.anotherProp, isNull);
        expect(secondProps.className, className);
      });

      test('and consumed props are correctly filtered', () {
        expect(initialProps.className, isNotNull, reason: 'Test setup sanity check');
        secondProps.addUnconsumedDomProps(initialProps, [PropsMeta.forSimpleKey('className')]);
        expect(secondProps.stringProp, isNull);
        expect(secondProps.anotherProp, isNull);
        expect(secondProps.className, isNull);
      });
    });
  });
}

testPropsToForward({UiFactory<TestProps> factory, bool modifyProps = false}) {
  group(modifyProps ? 'using `modifyProps(props.addPropsToForward)`' : 'using `getPropsToForwardProps`', () {
      TestProps initialProps;
      TestPropsMixin secondProps;
      const stringProp = 'stringProp';
      const anotherProp = 'anotherProp';
      const idAttributeValue = 'idAttributeValue';
      const aRandomDataAttributeValue = 'aRandomDataAttributeValue';
      const anAriaLabelPropValue = 'anAriaLabelPropValue';

      setUp(() {
        initialProps = (factory()
          ..stringProp = stringProp
          ..anotherProp = anotherProp
          ..aRandomDataAttribute = aRandomDataAttributeValue
          ..anAriaLabelAlias = anAriaLabelPropValue
          ..id = idAttributeValue
        );

        secondProps = initialProps;
      });

      test('by default excludes props mixin type that it is invoked on', () {
        TestProps unconsumedProps;
         if (modifyProps == true) {
          unconsumedProps = factory()..modifyProps(secondProps.addPropsToForward());
        } else {
          unconsumedProps = factory(secondProps.getPropsToForward());
        }

        expect(unconsumedProps.anotherProp, anotherProp);
        expect(unconsumedProps.stringProp, isNull);
        expect(unconsumedProps.id, idAttributeValue);
      });

      group('and props are correctly filtered', () {
        test('for an empty set', () {
          var unconsumedProps = _propsToForward(exclude: {}, props: initialProps, factory: factory, modifyProps: modifyProps);

          expect(unconsumedProps.stringProp, stringProp);
          expect(unconsumedProps.anotherProp, anotherProp);
          expect(unconsumedProps.id, idAttributeValue);
        });

        test('for a single value in set', () {
          var unconsumedProps = _propsToForward(exclude: {ASecondPropsMixin}, props: initialProps, factory: factory, modifyProps: modifyProps);

          expect(unconsumedProps.stringProp, stringProp);
          expect(unconsumedProps.anotherProp, isNull);
          expect(unconsumedProps.id, idAttributeValue);
        });

        test('for multiple values in set', () {
          var unconsumedProps = _propsToForward(exclude: {ASecondPropsMixin, TestPropsMixin}, props: initialProps, factory: factory, modifyProps: modifyProps);

          expect(unconsumedProps.stringProp, isNull);
          expect(unconsumedProps.anotherProp, isNull);
          expect(unconsumedProps.id, idAttributeValue);
        });

        test('excludes dom attributes that are part of a mixin with `@Accessor` annotations ', () {
          var unconsumedProps = _propsToForward(exclude: {DomAccessorPropsMixin}, props: initialProps, factory: factory, modifyProps: modifyProps);

          expect(unconsumedProps.stringProp, stringProp);
          expect(unconsumedProps.anotherProp, anotherProp);
          expect(unconsumedProps.aRandomDataAttribute, isNull);
          expect(unconsumedProps.anAriaLabelAlias, isNull);
          expect(unconsumedProps.id, idAttributeValue);
        });

        test('for dom only ', () {
          var unconsumedProps = _propsToForward(domOnly: true, props: initialProps, factory: factory, modifyProps: modifyProps);

          expect(unconsumedProps.stringProp, isNull);
          expect(unconsumedProps.anotherProp, isNull);
          expect(unconsumedProps.aRandomDataAttribute, aRandomDataAttributeValue);
          expect(unconsumedProps.anAriaLabelAlias, anAriaLabelPropValue);
          expect(unconsumedProps.id, idAttributeValue);
        });
      });

      test('which throws an error when not providing an exclude argument and the props class is NOT a mixin and `domOnly` is NOT `true`', () {
        debugger();
        expect(() => _propsToForward(exclude: null, props: initialProps, factory: factory, modifyProps: modifyProps),
            throwsArgumentError);
      }, tags: 'ddc');
    });
}

TestProps _propsToForward<T extends UiProps>({UiFactory<TestProps> factory, T props, bool modifyProps = false, Set<Type> exclude, bool domOnly = false }) {
  if (modifyProps == true) {
    return factory()..modifyProps(props.addPropsToForward(exclude: exclude, domOnly: domOnly));
  }
  return factory(props.getPropsToForward(exclude: exclude, domOnly: domOnly));
}

UiFactory<TestProps> BasicUiForwardRef = uiForwardRef(
      (props, ref) {
    return (Dom.div()
      ..ref = ref
      ..addTestId('testId')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$TestConfig, // ignore: undefined_identifier
);

UiFactory<TestProps> CustomUiForwardRef = uiForwardRef(
        (props, ref) {
      return (Dom.div()
        ..ref = ref
        ..addTestId('testIdCustom')
        ..addProp('data-prop-string-prop', props.stringProp)
        ..addProp('data-prop-dynamic-prop', props.dynamicProp)
        ..addProp('data-prop-untyped-prop', props.untypedProp)
        ..addProp('data-prop-custom-key-prop', props.customKeyProp)
        ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
        ..addProp('data-prop-custom-key-and-namespace-prop',
            props.customKeyAndNamespaceProp))('rendered content');
    },
    UiFactoryConfig(
      propsFactory: PropsFactory.fromUiFactory(BasicUiForwardRef),
    )
);

final NoLHSUiForwardRefTest = uiForwardRef<TestProps>(
      (props, ref) {
    return (Dom.div()
      ..ref = ref
      ..addTestId('testIdNoLHS')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$NoLHSTestConfig, // ignore: undefined_identifier
);

UiFactory<TestProps> _UiForwardRef = uiForwardRef(
      (props, ref) {
    return (Dom.div()
      ..ref = ref
      ..addTestId('_testId')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$_TestConfig, // ignore: undefined_identifier
);

UiFactory<TestProps> Test = uiFunction(
  (props) {
    return (Dom.div()
      ..addTestId('testId')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$TestConfig, // ignore: undefined_identifier
);

UiFactory<TestProps> TestPublic = uiFunction(
      (props) {
    return (Dom.div()
      ..addTestId('testId')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  $TestPublicConfig, // ignore: undefined_identifier, deprecated_member_use_from_same_package
);

UiFactory<TestProps> TestCustom = uiFunction(
  (props) {
    return (Dom.div()
      ..addTestId('testIdCustom')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  UiFactoryConfig(
    propsFactory: PropsFactory.fromUiFactory(Test),
  )
);

final NoLHSTest = uiFunction<TestProps>(
  (props) {
    return (Dom.div()
      ..addTestId('testIdNoLHS')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$NoLHSTestConfig, // ignore: undefined_identifier
);

final _Test = uiFunction<TestProps>(
  (props) {
    return (Dom.div()
      ..addTestId('_testId')
      ..addProp('data-prop-string-prop', props.stringProp)
      ..addProp('data-prop-dynamic-prop', props.dynamicProp)
      ..addProp('data-prop-untyped-prop', props.untypedProp)
      ..addProp('data-prop-custom-key-prop', props.customKeyProp)
      ..addProp('data-prop-custom-namespace-prop', props.customNamespaceProp)
      ..addProp('data-prop-custom-key-and-namespace-prop',
          props.customKeyAndNamespaceProp))('rendered content');
  },
  _$_TestConfig, // ignore: undefined_identifier
);

mixin TestPropsMixin on UiProps {
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

mixin ASecondPropsMixin on UiProps {
  String anotherProp;
}

mixin AThirdPropsMixin on UiProps {
  String aPropsFromAThirdMixin;
}

mixin DomAccessorPropsMixin on UiProps {
  @Accessor(key: 'data-random', keyNamespace: '')
  String aRandomDataAttribute;

  @Accessor(key: 'aria-label', keyNamespace: '')
  String anAriaLabelAlias;
}

class TestProps = UiProps with TestPropsMixin, ASecondPropsMixin, AThirdPropsMixin, DomAccessorPropsMixin;
