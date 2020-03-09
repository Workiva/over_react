@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing/member_association.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:test/test.dart';

main() {
  group('Member Association', () {
    BoilerplateMembers members;
    Iterable<BoilerplateFactory> factories;
    Iterable<BoilerplateComponent> components;
    Iterable<BoilerplateProps> props;
    Iterable<BoilerplateState> states;
    Iterable<BoilerplateStateMixin> stateMixins;
    Iterable<BoilerplatePropsMixin> propsMixins;

    BoilerplateMembers getAllExampleBoilerplateMembers() {
      final unit = parseString(content: mockComponentDeclarations).unit;

      return members ??= BoilerplateMembers.detect(unit);
    }

    Iterable<BoilerplateMember> getExampleBoilerplateFactories() {
      return factories ??= (members ?? getAllExampleBoilerplateMembers()).factories;
    }

    Iterable<BoilerplateMember> getExampleBoilerplateComponents() {
      return components ??= (members ?? getAllExampleBoilerplateMembers()).components;
    }

    Iterable<BoilerplateMember> getExampleBoilerplateProps() {
      return props ??= (members ?? getAllExampleBoilerplateMembers()).props;
    }

    Iterable<BoilerplateMember> getExampleBoilerplateState() {
      return states ??= (members ?? getAllExampleBoilerplateMembers()).states;
    }

    Iterable<BoilerplateMember> getExampleBoilerplatePropsMixins() {
      return propsMixins ??= (members ?? getAllExampleBoilerplateMembers()).propsMixins;
    }

    Iterable<BoilerplateMember> getExampleBoilerplateStateMixins() {
      return stateMixins ??= (members ?? getAllExampleBoilerplateMembers()).stateMixins;
    }


    Iterable<BoilerplateMember> getBoilerplateMembersFor(VersionOptions version) {
      final unit = parseString(content: boilerplateStrings[version]).unit;

      return BoilerplateMembers.detect(unit).allMembers;
    }

    group('normalizeName', () {
      test('removes the legacy prefixes from a string', () {
        expect(normalizeName(r'_$Foo'), 'Foo');
        expect(normalizeName(r'_$FooProps'), 'FooProps');
        expect(normalizeName(r'_$FooState'), 'FooState');
      });

      test(r'will always remove the $ and _ symbols at the beginning of the string', () {
        expect(normalizeName(r'$Foo'), 'Foo');
        expect(normalizeName('_Foo'), 'Foo');
      });

      test(r'will not remove the $ and _ symbols at the middle of the string', () {
        expect(normalizeName(r'F$oo'), r'F$oo');
        expect(normalizeName('F_oo'), 'F_oo');

        expect(normalizeName(r'Foo $test'), r'Foo $test');
        expect(normalizeName('Foo _test'), 'Foo _test');
      });
    });

    group('normalizeNameAndRemoveSuffix', () {
      group('and the BoilerplateMember is a', () {
        test('BoilerplateComponent', () {
          final component = getBoilerplateMembersFor(VersionOptions.v4).whereType<BoilerplateComponent>().first;
          expect(normalizeNameAndRemoveSuffix(component), 'Foo');
        });

        test('BoilerplateProps', () {
          final props = getBoilerplateMembersFor(VersionOptions.v3).whereType<BoilerplateProps>().first;
          expect(normalizeNameAndRemoveSuffix(props), 'Foo');
        });

        test('BoilerplatePropsMixin', () {
          final propsMixin = getBoilerplateMembersFor(VersionOptions.v4).whereType<BoilerplatePropsMixin>().first;
          expect(normalizeNameAndRemoveSuffix(propsMixin), 'Foo');

          final propsMixinWithMixinInName = getBoilerplateMembersFor(VersionOptions.v5).whereType<BoilerplatePropsMixin>().first;
          expect(normalizeNameAndRemoveSuffix(propsMixinWithMixinInName), 'Foo');
        });

        test('BoilerplateState', () {
          final state = getBoilerplateMembersFor(VersionOptions.v3).whereType<BoilerplateState>().first;
          expect(normalizeNameAndRemoveSuffix(state), 'Foo');
        });

        test('BoilerplateStateMixin', () {
          final stateMixin = getBoilerplateMembersFor(VersionOptions.v4).whereType<BoilerplateStateMixin>().first;
          expect(normalizeNameAndRemoveSuffix(stateMixin), 'Foo');

          final stateMixinWithMixinInName = getBoilerplateMembersFor(VersionOptions.v5).whereType<BoilerplateStateMixin>().first;
          expect(normalizeNameAndRemoveSuffix(stateMixinWithMixinInName), 'Foo');
        });
      });
    });

    group('getComponentFor retrieves the component by', () {
      setUpAll(() {
        members = getAllExampleBoilerplateMembers();
        components = getExampleBoilerplateComponents();
        factories = getExampleBoilerplateFactories();
        props = getExampleBoilerplateProps();
        states = getExampleBoilerplateState();
        propsMixins = getExampleBoilerplatePropsMixins();
        stateMixins = getExampleBoilerplateStateMixins();

        // Ensure there's more than a single option so when using `getComponentFor`
        // there's more than one option
        expect(components.length, greaterThan(1));
      });

      group('name', () {
        group('when passed', () {
          test('a factory', () {
            final factory = factories.firstWhere((factory) => factory.name.name == 'SecondFoo');
            expect(getComponentFor(factory, components).name.name, 'SecondFooComponent');
          });

          test('props', () {
            final propsClass = props.firstWhere((props) => normalizeName(props.name.name) == 'SecondFooProps');
            expect(getComponentFor(propsClass, components).name.name, 'SecondFooComponent');
          });

          test('state', () {
            final state = states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
            expect(getComponentFor(state, components).name.name, 'SecondFooComponent');
          });

          test('a props mixin', () {
            final propsClass = propsMixins.first;

            // Sanity check
            expect(propsClass.name.name, 'ThirdFooProps');

            expect(getComponentFor(propsClass, components).name.name, 'ThirdFooComponent');
          });

          test('a state mixin', () {
            final stateClass = stateMixins.first;

            // Sanity check
            expect(stateClass.name.name, 'ThirdFooState');

            expect(getComponentFor(stateClass, components).name.name, 'ThirdFooComponent');
          });
        });
      });

      group('generics', () {
        group('when passed', () {
          test('props', () {
            final propsClass = props.firstWhere((props) => normalizeName(props.name.name) == 'HowAboutARandomNameForLegacyProps');
            expect(getComponentFor(propsClass, components).name.name, 'IsThisEvenAComponentNameLegacyComponent');
          });

          test('a props mixin', () {
            final propsMixin = propsMixins.firstWhere((props) => props.name.name == 'HowAboutARandomNameForProps');
            expect(getComponentFor(propsMixin, components).name.name, 'IsThisEvenAComponentNameComponent');
          });
        });

        group('unless the method is passed', () {
          test('a factory', () {
            final factory = factories.firstWhere((props) => props.name.name == 'ThisIsABadFactoryName');
            expect(getComponentFor(factory, components), isNull);
          });

          test('state', () {
            final state = states.firstWhere((props) => normalizeName(props.name.name) == 'AVeryRandomNameForLegacyState');
            expect(getComponentFor(state, components), isNull);
          });

          test('a state mixin', () {
            final stateMixin = stateMixins.firstWhere((props) => props.name.name == 'AVeryRandomNameForState');
            expect(getComponentFor(stateMixin, components), isNull);
          });
        });
      });
    });

    group('getPropsFor gets the correct props class when passed', () {
      group('when passed', () {
        test('a factory', () {
          final factory = factories.firstWhere((factory) => factory.name.name == 'SecondFoo');
          expect(normalizeName(getPropsFor(factory, props, propsMixins).a.name.name), 'SecondFooProps');
        });

        test('a component', () {
          final component = components.firstWhere((component) => normalizeName(component.name.name) == 'SecondFooComponent');
          expect(normalizeName(getPropsFor(component, props, propsMixins).a.name.name), 'SecondFooProps');
        });

        test('state', () {
          final state = states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
          expect(normalizeName(getPropsFor(state, props, propsMixins).a.name.name), 'SecondFooProps');
        });

        test('a state mixin', () {
          final state = stateMixins.first;

          // Sanity check
          expect(state.name.name, 'ThirdFooState');

          expect(getPropsFor(state, props, propsMixins).b.name.name, 'ThirdFooProps');
        });
      });
    });

    group('getStateFor gets the correct props class when passed', () {
      group('when passed', () {
        test('a factory', () {
          final factory = factories.firstWhere((factory) => factory.name.name == 'SecondFoo');
          expect(normalizeName(getStateFor(factory, states, stateMixins).a.name.name), 'SecondFooState');
        });

        test('a component', () {
          final component = components.firstWhere((components) => components.name.name == 'SecondFooComponent');
          expect(normalizeName(getStateFor(component, states, stateMixins).a.name.name), 'SecondFooState');
        });

        test('props', () {
          final propsClass = props.firstWhere((prop) => normalizeName(prop.name.name) == 'SecondFooProps');
          expect(normalizeName(getStateFor(propsClass, states, stateMixins).a.name.name), 'SecondFooState');
        });

        test('a props mixin', () {
          final propsClass = propsMixins.first;

          // Sanity check
          expect(propsClass.name.name, 'ThirdFooProps');

          expect(normalizeName(getStateFor(propsClass, states, stateMixins).b.name.name), 'ThirdFooState');
        });
      });
    });

    group('getRelatedName', () {
      group('returns a related name', () {
        test('for factories', () {
          final factory = factories.firstWhere((factory) => factory.name.name == 'SecondFoo');
          expect(getRelatedName(factory), 'SecondFoo');
        });

        test('for components', () {
          final component = components.firstWhere((components) => components.name.name == 'SecondFooComponent');
          expect(getRelatedName(component), 'SecondFoo');
        });

        group('unless the Boilerplate is a', () {
          group('props', () {
            test('class', () {
              final propsClass = props.firstWhere((prop) => normalizeName(prop.name.name) == 'SecondFooProps');
              expect(getRelatedName(propsClass), isNull);
            });

            test('mixin', () {
              final propsClass = propsMixins.first;
              expect(getRelatedName(propsClass), isNull);
            });
          });

          group('state', () {
            test('class', () {
              final state = states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
              expect(getRelatedName(state), isNull);
            });

            test('mixin', () {
              final stateMixin = stateMixins.first;
              expect(getRelatedName(stateMixin), isNull);
            });
          });
        });
      });
    });
  });
}

enum VersionOptions { v2, v3, v4, v5 }
const boilerplateStrings = {
  VersionOptions.v2: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {}

          @State()
          class _$FooState extends UiState with _$FooStateAccessorsMixin {}

          class FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component2()
          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
      ''',
  VersionOptions.v3: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          @State()
          class _$FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component2()
          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
        ''',
  VersionOptions.v4: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooProps on UiProps {}

          mixin FooState on UiState {}

          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
  VersionOptions.v5: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooPropsMixin on UiProps {}

          class FooProps = UiProps with FooPropsMixin;

          mixin FooStateMixin on UiState {}
          
          class FooState = UiState with FooStateMixin;

          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
};

const mockComponentDeclarations = r'''
  // -------------------------- Version.v2_legacyBackwardsCompat --------------------------
  @Factory()
  UiFactory<FirstFooProps> FirstFoo = _$FirstFoo;

  @Props()
  class _$FirstFooProps extends UiProps {}

  class FirstFooProps extends _$FirstFooProps with _$FirstFooPropsAccessorsMixin {}

  @State()
  class _$FirstFooState extends UiState with _$FirstFooStateAccessorsMixin {}

  class FirstFooState extends _$FirstFooState with _$FirstFooStateAccessorsMixin {}

  @Component2()
  class FirstFooComponent extends UiStatefulComponent2<FirstFooProps, FooState>{}
  
  // -------------------------- Version.v3_legacyDart2Only --------------------------
  @Factory()
  UiFactory<SecondFooProps> SecondFoo = _$SecondFoo;

  @Props()
  class _$SecondFooProps extends UiProps {}

  @State()
  class _$SecondFooState extends _$SecondFooState with _$SecondFooStateAccessorsMixin {}

  @Component2()
  class SecondFooComponent extends UiStatefulComponent2<SecondFooProps, SecondFooState>{}
  
  // -------------------------- Version.v3_legacyDart2Only --------------------------
  // But with dissassociated names to force grouping logic to utilize generics
  @Factory()
  UiFactory<HowAboutARandomNameForLegacyProps> ThisIsABadLegacyFactoryName = _$ThisIsABadLegacyFactoryName;

  @Props()
  class _$HowAboutARandomNameForLegacyProps extends UiProps {}

  @State()
  class _$AVeryRandomNameForLegacyState extends _$AVeryRandomNameForLegacyState with _$AVeryRandomNameForLegacyStateAccessorsMixin {}

  @Component2()
  class IsThisEvenAComponentNameLegacyComponent extends UiStatefulComponent2<HowAboutARandomNameForLegacyProps, AVeryRandomNameForLegacyState>{}
  

  // -------------------------- Version.v4_mixinBased --------------------------
  UiFactory<ThirdFooProps> ThirdFoo = _$ThirdFoo;

  mixin ThirdFooProps on UiProps {}

  mixin ThirdFooState on UiState {}

  class ThirdFooComponent extends UiStatefulComponent<ThirdFooProps, ThirdFooState>{}

  // -------------------------- Version.v4_mixinBased --------------------------
  // But with extended props / state aliase syntax
  UiFactory<FourthFooProps> FourthFoo = _$FourthFoo;

  mixin FourthFooPropsMixin on UiProps {}

  class FourthFooProps = UiProps with FourthFooPropsMixin;

  mixin FourthFooStateMixin on UiState {}
  
  class FourthFooState = UiState with FourthFooStateMixin;

  class FourthFooComponent extends UiStatefulComponent<FourthFooProps, FourthFooState>{}
  
  // -------------------------- Version.v4_mixinBased --------------------------
  // But with dissassociated names to force grouping logic to utilize generics
  UiFactory<HowAboutARandomNameForProps> ThisIsABadFactoryName = _$IsThisEvenAComponentName;

  mixin HowAboutARandomNameForProps on UiProps {}

  mixin AVeryRandomNameForState on UiState {}

  class IsThisEvenAComponentNameComponent extends UiStatefulComponent<HowAboutARandomNameForProps, AVeryRandomNameForState>{}
''';

