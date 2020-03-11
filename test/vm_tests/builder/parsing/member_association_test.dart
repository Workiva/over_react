@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing/member_association.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:test/test.dart';

import '../util.dart';

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

    Iterable<BoilerplateMember> getBoilerplateMembersFor(BoilerplateVersions version) {
      final unit = parseString(content: getBoilerplateString(version: version)).unit;

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
          final component =
              getBoilerplateMembersFor(BoilerplateVersions.v4).whereType<BoilerplateComponent>().first;
          expect(normalizeNameAndRemoveSuffix(component), 'Foo');
        });

        test('BoilerplateProps', () {
          final props =
              getBoilerplateMembersFor(BoilerplateVersions.v3).whereType<BoilerplateProps>().first;
          expect(normalizeNameAndRemoveSuffix(props), 'Foo');
        });

        test('BoilerplatePropsMixin', () {
          final propsMixin =
              getBoilerplateMembersFor(BoilerplateVersions.v4).whereType<BoilerplatePropsMixin>().first;
          expect(normalizeNameAndRemoveSuffix(propsMixin), 'Foo');

          final propsMixinWithMixinInName =
              getBoilerplateMembersFor(BoilerplateVersions.v5).whereType<BoilerplatePropsMixin>().first;
          expect(normalizeNameAndRemoveSuffix(propsMixinWithMixinInName), 'Foo');
        });

        test('BoilerplateState', () {
          final state =
              getBoilerplateMembersFor(BoilerplateVersions.v3).whereType<BoilerplateState>().first;
          expect(normalizeNameAndRemoveSuffix(state), 'Foo');
        });

        test('BoilerplateStateMixin', () {
          final stateMixin =
              getBoilerplateMembersFor(BoilerplateVersions.v4).whereType<BoilerplateStateMixin>().first;
          expect(normalizeNameAndRemoveSuffix(stateMixin), 'Foo');

          final stateMixinWithMixinInName =
              getBoilerplateMembersFor(BoilerplateVersions.v5).whereType<BoilerplateStateMixin>().first;
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
            final propsClass =
                props.firstWhere((props) => normalizeName(props.name.name) == 'SecondFooProps');
            expect(getComponentFor(propsClass, components).name.name, 'SecondFooComponent');
          });

          test('state', () {
            final state =
                states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
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
            final propsClass = props.firstWhere(
                (props) => normalizeName(props.name.name) == 'HowAboutARandomNameForLegacyProps');
            expect(getComponentFor(propsClass, components).name.name,
                'IsThisEvenAComponentNameLegacyComponent');
          });

          test('a props mixin', () {
            final propsMixin =
                propsMixins.firstWhere((props) => props.name.name == 'HowAboutARandomNameForProps');
            expect(getComponentFor(propsMixin, components).name.name,
                'IsThisEvenAComponentNameComponent');
          });
        });

        group('unless the method is passed', () {
          test('a factory', () {
            final factory =
                factories.firstWhere((props) => props.name.name == 'ThisIsABadFactoryName');
            expect(getComponentFor(factory, components), isNull);
          });

          test('state', () {
            final state = states.firstWhere(
                (props) => normalizeName(props.name.name) == 'AVeryRandomNameForLegacyState');
            expect(getComponentFor(state, components), isNull);
          });

          test('a state mixin', () {
            final stateMixin =
                stateMixins.firstWhere((props) => props.name.name == 'AVeryRandomNameForState');
            expect(getComponentFor(stateMixin, components), isNull);
          });
        });
      });
    });

    group('getPropsFor gets the correct props class when passed', () {
      group('when passed', () {
        test('a factory', () {
          final factory = factories.firstWhere((factory) => factory.name.name == 'SecondFoo');
          expect(normalizeName(getPropsFor(factory, props, propsMixins).a.name.name),
              'SecondFooProps');
        });

        test('a component', () {
          final component = components.firstWhere(
              (component) => normalizeName(component.name.name) == 'SecondFooComponent');
          expect(normalizeName(getPropsFor(component, props, propsMixins).a.name.name),
              'SecondFooProps');
        });

        test('state', () {
          final state =
              states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
          expect(
              normalizeName(getPropsFor(state, props, propsMixins).a.name.name), 'SecondFooProps');
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
          expect(normalizeName(getStateFor(factory, states, stateMixins).a.name.name),
              'SecondFooState');
        });

        test('a component', () {
          final component =
              components.firstWhere((components) => components.name.name == 'SecondFooComponent');
          expect(normalizeName(getStateFor(component, states, stateMixins).a.name.name),
              'SecondFooState');
        });

        test('props', () {
          final propsClass =
              props.firstWhere((prop) => normalizeName(prop.name.name) == 'SecondFooProps');
          expect(normalizeName(getStateFor(propsClass, states, stateMixins).a.name.name),
              'SecondFooState');
        });

        test('a props mixin', () {
          final propsClass = propsMixins.first;

          // Sanity check
          expect(propsClass.name.name, 'ThirdFooProps');

          expect(normalizeName(getStateFor(propsClass, states, stateMixins).b.name.name),
              'ThirdFooState');
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
          final component =
              components.firstWhere((components) => components.name.name == 'SecondFooComponent');
          expect(getRelatedName(component), 'SecondFoo');
        });

        group('unless the Boilerplate is a', () {
          group('props', () {
            test('class', () {
              final propsClass =
                  props.firstWhere((prop) => normalizeName(prop.name.name) == 'SecondFooProps');
              expect(getRelatedName(propsClass), isNull);
            });

            test('mixin', () {
              final propsClass = propsMixins.first;
              expect(getRelatedName(propsClass), isNull);
            });
          });

          group('state', () {
            test('class', () {
              final state =
                  states.firstWhere((state) => normalizeName(state.name.name) == 'SecondFooState');
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
