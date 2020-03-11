@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import 'parsing_helpers.dart';

main() {
  group('members -', () {
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

    Iterable<BoilerplateMember> parseAndReturnMembers(String content) {
      final unit = parseString(content: content).unit;

      return BoilerplateMembers.detect(unit).allMembers;
    }

    setUp(() {
      members = getAllExampleBoilerplateMembers();
      components = getExampleBoilerplateComponents();
      factories = getExampleBoilerplateFactories();
      props = getExampleBoilerplateProps();
      states = getExampleBoilerplateState();
      propsMixins = getExampleBoilerplatePropsMixins();
      stateMixins = getExampleBoilerplateStateMixins();
    });

    group('component', () {
      BoilerplateComponent legacyBackwardCompatComponent;
      BoilerplateComponent legacyComponent;
      BoilerplateComponent newBoilerplateComponent;

      setUp(() {
        legacyBackwardCompatComponent =
            components.firstWhere((component) => component.name.name == 'FirstFooComponent');
        legacyComponent =
            components.firstWhere((component) => component.name.name == 'SecondFooComponent');
        newBoilerplateComponent =
            components.firstWhere((component) => component.name.name == 'ThirdFooComponent');
      });

      test('propsGenericArg returns the correct props class', () {
        expect(
            legacyBackwardCompatComponent.propsGenericArg.typeNameWithoutPrefix, 'FirstFooProps');
        expect(legacyComponent.propsGenericArg.typeNameWithoutPrefix, 'SecondFooProps');
        expect(newBoilerplateComponent.propsGenericArg.typeNameWithoutPrefix, 'ThirdFooProps');
      });

      group('annotation getters return the correct value -', () {
        test('hasAnnotation', () {
          expect(legacyBackwardCompatComponent.hasAnnotation, true);
          expect(legacyComponent.hasAnnotation, true);
          expect(newBoilerplateComponent.hasAnnotation, false);
        });

        test('hasComponent1OrAbstractAnnotation', () {
          expect(legacyBackwardCompatComponent.hasComponent1OrAbstractAnnotation, true);
          expect(legacyComponent.hasComponent1OrAbstractAnnotation, false);
          expect(newBoilerplateComponent.hasComponent1OrAbstractAnnotation, false);
        });

        test('hasComponent2OrAbstractAnnotation', () {
          expect(legacyBackwardCompatComponent.hasComponent2OrAbstractAnnotation, false);
          expect(legacyComponent.hasComponent2OrAbstractAnnotation, true);
          expect(newBoilerplateComponent.hasComponent2OrAbstractAnnotation, false);
        });
      });

      test('isComponent2 returns the correct value', () {
        expect(
            getBoilerplateMembersFor(BoilerplateVersions.v2)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v2_legacyBackwardsCompat),
            false);
        expect(
            getBoilerplateMembersFor(BoilerplateVersions.v3)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v3_legacyDart2Only),
            false);
        expect(
            getBoilerplateMembersFor(BoilerplateVersions.v4)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v4_mixinBased),
            true);
      });

      group('validate', () {
        ErrorCollector collector;
        SourceFile file;
        var validateResults = <String>[];

        void validateCallback(String message, [SourceSpan span]) {
          validateResults.add(message);
        }

        tearDown(() {
          validateResults = <String>[];
          file = null;
          collector = null;
        });

        group('does not throw when', () {
          group('the component is a', () {
            for (final version in BoilerplateVersions.values) {
              test('${versionDescriptions[version]} component', () {
                final members = getBoilerplateMembersFor(version);
                final component = members.whereType<BoilerplateComponent>().first;
                final componentVersion = resolveVersion(members).version;
                file = SourceFile.fromString(getBoilerplateString(version: version));
                collector = ErrorCollector.callback(file,
                    onError: validateCallback, onWarning: validateCallback);

                component.validate(componentVersion, collector);
                expect(validateResults, []);
              });
            }
          });
        });

        group('throws when', () {
          test('the component is mixin based but does not extend Component2', () {
            final members = parseAndReturnMembers(r'''
            UiFactory<FooProps> Foo = _$Foo;

            mixin FooProps on UiProps {}
  
            mixin FooState on UiState {}
  
            class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
            ''');

            final component = members.whereType<BoilerplateComponent>().first;
            final componentVersion = resolveVersion(members).version;
            file = SourceFile.fromString(r'''
            UiFactory<FooProps> Foo = _$Foo;

            mixin FooProps on UiProps {}
  
            mixin FooState on UiState {}
  
            class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
            ''');
            collector = ErrorCollector.callback(file,
                onError: validateCallback, onWarning: validateCallback);

            component.validate(componentVersion, collector);
            expect(validateResults, [contains('Must extend UiComponent2, not UiComponent.')]);
          });
        });

        // Group that ensures that iterates over the deprecated lifecycles and all
        // versions of the boilerplate, checking for errors where necessary.
        group('detects deprecated lifecycles correctly', () {
          Map<String, String> legacyLifecycleMethodsMap = {
            'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
            'componentWillMount': 'Use init instead.',
            'componentWillUpdate': 'Use getSnapshotBeforeUpdate instead.',
          };

          // Loop over the deprecated lifecycle methods
          legacyLifecycleMethodsMap.keys.forEach((lifecycle) => {
                // Loop through every version of the boilerplate
                for (final version in BoilerplateVersions.values)
                  {
                    test('$lifecycle with ${versionDescriptions[version]}', () {
                      // Grab the boilerplate with the deprecated lifecycle method
                      final componentString = getBoilerplateString(
                          deprecatedLifecycleMethod: lifecycle, version: version);
                      final members = parseAndReturnMembers(componentString);
                      final component = members.whereType<BoilerplateComponent>().first;
                      final componentVersion = resolveVersion(members).version;
                      file = SourceFile.fromString(componentString);
                      collector = ErrorCollector.callback(file, onError: validateCallback);

                      component.validate(componentVersion, collector);

                      // Warnings should only be logged if the component is a Component2
                      if (component.isComponent2(componentVersion)) {
                        expect(validateResults, [
                          contains(legacyLifecycleMethodsMap[lifecycle]),
                        ]);
                      } else {
                        expect(validateResults, []);
                      }
                    })
                  }
              });
        });
      });
    });

    group('factory', () {
      group(
          'hasFactoryAnnotation correctly identifies when a factory whether or not an annotation is present',
          () {
        for (final version in BoilerplateVersions.values) {
          test('${versionDescriptions[version]}', () {
            final componentString = getBoilerplateString(version: version);
            final members = parseAndReturnMembers(componentString);
            final factory = members.whereType<BoilerplateFactory>().first;

            if (![BoilerplateVersions.v4, BoilerplateVersions.v5].contains(version)) {
              expect(factory.hasFactoryAnnotation, isTrue);
            } else {
              expect(factory.hasFactoryAnnotation, isFalse);
            }
          });
        }
      });

      group('validate', () {
        ErrorCollector collector;
        SourceFile file;
        var validateResults = <String>[];

        void validateCallback(String message, [SourceSpan span]) {
          validateResults.add(message);
        }

        tearDown(() {
          validateResults = <String>[];
          file = null;
          collector = null;
        });

        group('does not throw for', () {
          for (final version in BoilerplateVersions.values) {
            test(versionDescriptions[version], () {
              final componentString = getBoilerplateString(version: version);
              final members = parseAndReturnMembers(componentString);
              final factory = members.whereType<BoilerplateFactory>().first;
              file = SourceFile.fromString(componentString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              factory.validate(resolveVersion(members).version, collector);

              expect(validateResults, []);
            });
          }
        });

        group('throws when', () {
          test('a Dart 2 only component does not have an annotation', () {
            const boilerplateString = r'''
              UiFactory<FooProps> Foo = _$Foo;
              
              @Component() class FooComponent {}
              
              @Props()
              class _$FooProps {}
              
              @State()
              class _$FooState {}
            ''';

            file = SourceFile.fromString(boilerplateString);
            collector = ErrorCollector.callback(file, onError: validateCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final factory = members.whereType<BoilerplateFactory>().first;

            factory.validate(resolveVersion(members).version, collector);
            expect(validateResults, [
              contains('Legacy boilerplate factories must be annotated with `@Factory()`'),
            ]);
          });

          test('there is more than one variable', () {
            const boilerplateString = r'''
              @Factory()
              UiFactory<FooProps> Foo = _$Foo, _$Bar;
              
              @Component() class FooComponent {}
              
              @Props()
              class _$FooProps {}
              
              @State()
              class _$FooState {}
            ''';

            file = SourceFile.fromString(boilerplateString);
            collector = ErrorCollector.callback(file, onError: validateCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final factory = members.whereType<BoilerplateFactory>().first;

            factory.validate(resolveVersion(members).version, collector);
            expect(validateResults, [
              contains('Factory declarations must be a single variable.'),
            ]);
          });

          test('the factory is not set equal to the generated factory', () {
            const boilerplateString = r'''
              @Factory()
              UiFactory<FooProps> Foo = Bar;
              
              @Component() class FooComponent {}
              
              @Props()
              class _$FooProps {}
              
              @State()
              class _$FooState {}
            ''';

            file = SourceFile.fromString(boilerplateString);
            collector = ErrorCollector.callback(file, onError: validateCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final factory = members.whereType<BoilerplateFactory>().first;

            factory.validate(resolveVersion(members).version, collector);
            expect(validateResults, [
              contains('Should be: `${factory.name.name} = _\$${factory.name.name}`'),
            ]);
          });
        });
      });
    });

    group('BoilerplatePropsOrState', () {
      ErrorCollector collector;
      SourceFile file;
      var validateResults = <String>[];

      void validateCallback(String message, [SourceSpan span]) {
        validateResults.add(message);
      }

      tearDown(() {
        validateResults = <String>[];
        file = null;
        collector = null;
      });

      group('validate', () {
        group('does not throw for', () {
          var classesDetected = 0;
          // The number of classes in VersionOptions that would not have BoilerplatePropsOrState
          // classes. This would be new boilerplate components that do not have have props or state
          // class aliases.
          const numberOfMixinBasedClasses = 2;

          for (final version in BoilerplateVersions.values) {
            test(versionDescriptions[version], () {
              final boilerplateString = getBoilerplateString(version: version);
              final members = parseAndReturnMembers(boilerplateString);
              final propsOrStateClasses = members.whereType<BoilerplatePropsOrState>();

              if (propsOrStateClasses.isNotEmpty) {
                final propsOrStateClass = propsOrStateClasses.first;
                file = SourceFile.fromString(boilerplateString);
                collector = ErrorCollector.callback(file, onError: validateCallback);

                propsOrStateClass.validate(resolveVersion(members).version, collector);

                expect(validateResults, []);
                classesDetected++;
              }
            });
          }

          test('', () {
            expect(classesDetected, BoilerplateVersions.values.length - numberOfMixinBasedClasses);
          });
        });

        group('throws when', () {
          group('the props class is v4_mixinBased and', () {
            test('the props name does not match the class name', () {
              const boilerplateString = r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;

                @Props()
                class _$FooProps {}

                @State()
                class _$FooState {}

                @Component2()
                class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;

              props.validate(Version.v4_mixinBased, collector);
              expect(validateResults.length, 1);
              expect(
                  validateResults.first,
                  contains(
                      '${props.propsOrStateClassString} implementations must extend directly from ${props.propsOrStateBaseClassString}'));

              validateResults = <String>[];
              state.validate(Version.v4_mixinBased, collector);
              expect(validateResults.length, 1);
              expect(
                  validateResults.first,
                  contains(
                      '${state.propsOrStateClassString} implementations must extend directly from ${state.propsOrStateBaseClassString}'));
            });

            test('is a class declaration with members', () {
              const boilerplateString = r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;

                @Props()
                class _$FooProps extends UiProps {
                  String barProps = 'baz';
                }

                @State()
                class _$FooState extends UiState {
                  String barState = 'baz';
                }

                @Component2()
                class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;

              props.validate(Version.v4_mixinBased, collector);
              expect(validateResults, [
                contains(
                    '${props.propsOrStateClassString} implementations must not declare any ${props.propsOrStateFieldsName} or other members.'),
              ]);

              validateResults = <String>[];
              state.validate(Version.v4_mixinBased, collector);
              expect(validateResults, [
                contains(
                    '${state.propsOrStateClassString} implementations must not declare any ${state.propsOrStateFieldsName} or other members.'),
              ]);
            });

            test('the class is abstract', () {
              const boilerplateString = r'''
                @AbstractProps()
                abstract class _$AbstractFooProps extends UiProps {}
                
                @AbstractState()
                abstract class _$AbstractFooState extends UiState {}
                
                @AbstractComponent() 
                abstract class AbstractFooComponent {}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;

              props.validate(Version.v4_mixinBased, collector);
              expect(validateResults, [
                contains(
                    '${props.propsOrStateClassString} implementations must not be abstract, as they cannot be extended.'),
              ]);

              validateResults = <String>[];
              state.validate(Version.v4_mixinBased, collector);
              expect(validateResults, [
                contains(
                    '${state.propsOrStateClassString} implementations must not be abstract, as they cannot be extended.'),
              ]);
            });
          });

          group('the props class is v2_legacyBackwordsCompat and', () {
            test('the name is private source prefixed but has no companion', () {
              const boilerplateString = r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;

                @Props()
                class _$FooProps {}

                @State()
                class _$FooState {}

                @Component2()
                class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;

              props.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, [contains('Should have companion class')]);

              validateResults = <String>[];
              state.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, [contains('Should have companion class')]);
            });
          });

          group('the props class is v2_legacyBackwordsCompat or v3_legacyDart2Only and', () {
            test('the node is not a ClassOrMixinDeclaration', () {
              const boilerplateString = r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;
  
                mixin FooPropsMixin on UiProps {}
                
                @Props()
                class _$FooProps = UiProps with FooPropsMixin;
      
                mixin FooStateMixin on UiState {}
                
                @State()
                class _$FooState = UiState with FooStateMixin;
      
                @Component2()
                class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;
              const errorMessage =
                  'Legacy boilerplate must use classes or mixins, and not shorthand class declaration';

              props.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, contains(errorMessage));

              validateResults = <String>[];
              state.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, contains(errorMessage));

              validateResults = <String>[];
              props.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, contains(errorMessage));

              validateResults = <String>[];
              state.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, contains(errorMessage));
            });

            test('the name does not start with a private prefix', () {
              const boilerplateString = r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;
  
                mixin FooPropsMixin on UiProps {}
                
                @Props()
                class FooProps = UiProps with FooPropsMixin;
      
                mixin FooStateMixin on UiState {}
                
                @State()
                class FooState = UiState with FooStateMixin;
      
                @Component2()
                class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
              ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplateProps>().first;
              final state = members.whereType<BoilerplateState>().first;
              final propsError = 'The class `${props.name.name}` does not start with `_\$`';
              final stateError = 'The class `${state.name.name}` does not start with `_\$`';

              props.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, anyElement(contains(propsError)));

              validateResults = <String>[];
              state.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, anyElement(contains(stateError)));

              validateResults = <String>[];
              props.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, anyElement(contains(propsError)));

              validateResults = <String>[];
              state.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, anyElement(contains(stateError)));
            });
          });
        });
      });
    });

    group('BoilerplatePropsOrStateMixin', () {
      ErrorCollector collector;
      SourceFile file;
      var validateResults = <String>[];

      void validateCallback(String message, [SourceSpan span]) {
        validateResults.add(message);
      }

      tearDown(() {
        validateResults = <String>[];
        file = null;
        collector = null;
      });

      group('validate', () {
        group('does not throw for', () {
          var classesDetected = 0;
          // The number of classes in VersionOptions that are mixin based. This
          // includes those that have class aliases.
          const numberOfMixinBasedClasses = 4;

          for (final version in BoilerplateVersions.values) {
            test(versionDescriptions[version], () {
              final boilerplateString = getBoilerplateString(version: version);
              final members = parseAndReturnMembers(boilerplateString);
              final propsOrStateMixins = members.whereType<BoilerplatePropsOrStateMixin>();

              if (propsOrStateMixins.isNotEmpty) {
                final propsOrStateClass = propsOrStateMixins.first;
                file = SourceFile.fromString(boilerplateString);
                collector = ErrorCollector.callback(file, onError: validateCallback);

                propsOrStateClass.validate(resolveVersion(members).version, collector);

                expect(validateResults, []);
                classesDetected++;
              }
            });
          }

          test('', () {
            expect(classesDetected, numberOfMixinBasedClasses);
          });
        });

        group('throws when', () {
          group('the version is v4_mixinBased', () {
//              test('and the props classes are not `on` the corresponding superclass', () {
//                const boilerplateString = r'''
//                  UiFactory<FooProps> Foo = _$Foo;
//
//                  mixin FooPropsMixin on UiProps {}
//
//                  class FooProps = UiProps with FooPropsMixin;
//
//                  mixin FooStateMixin on UiState {}
//
//                  class FooState = UiState with FooStateMixin;
//
//                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
//                ''';
//
//                file = SourceFile.fromString(boilerplateString);
//                collector = ErrorCollector.callback(file, onError: validateCallback);
//
//                final members = parseAndReturnMembers(boilerplateString);
//                final props = members.whereType<BoilerplatePropsMixin>().first;
//                final state = members.whereType<BoilerplateStateMixin>().first;
//
//                props.validate(Version.v4_mixinBased, collector);
//                expect(validateResults.length, 1);
//                expect(validateResults, contains('UiProps mixins must be `on UiProps`'));
//
//                validateResults = <String>[];
//                state.validate(Version.v4_mixinBased, collector);
//                expect(validateResults.length, 1);
//                expect(validateResults, contains('UiState mixins must be `on UiState`'));
//              });

            test('and the props or state classes are not mixins', () {
              const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @PropsMixin()
                  class _$FooPropsMixin extends UiProps {}
  
                  @StateMixin()
                  class _$FooStateMixin extends UiState {}
  
                  @Component2()
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
                ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplatePropsMixin>().first;
              final state = members.whereType<BoilerplateStateMixin>().first;

              props.validate(Version.v4_mixinBased, collector);
              expect(validateResults, ['props mixins must be mixins']);

              validateResults = <String>[];
              state.validate(Version.v4_mixinBased, collector);
              expect(validateResults, ['state mixins must be mixins']);
            });
          });

          group('the version is v2_legacyBackwardsCompat or v3_legacyDart2Only', () {
            test('and the props or state classes have the mixin annotation', () {
              const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @Props()
                  mixin FooProps on UiProps {
                    Map get props;
                  }
  
                  @State()
                  mixin FooState on UiState {
                    Map get state;
                  }
  
                  @Component2()
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
                ''';

              file = SourceFile.fromString(boilerplateString);
              collector = ErrorCollector.callback(file, onError: validateCallback);

              final members = parseAndReturnMembers(boilerplateString);
              final props = members.whereType<BoilerplatePropsMixin>().first;
              final state = members.whereType<BoilerplateStateMixin>().first;
              const propsError =
                  'Legacy boilerplate Props mixins must be annotated with `@PropsMixin()`';
              const stateError =
                  'Legacy boilerplate State mixins must be annotated with `@StateMixin()`';

              props.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, [propsError]);

              validateResults = <String>[];
              state.validate(Version.v2_legacyBackwardsCompat, collector);
              expect(validateResults, [stateError]);

              validateResults = <String>[];
              props.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, [propsError]);

              validateResults = <String>[];
              state.validate(Version.v3_legacyDart2Only, collector);
              expect(validateResults, [stateError]);
            });
          });
        });
      });
    });

    group('utils', () {
      ErrorCollector collector;
      SourceFile file;
      var errorList = <String>[];
      var warnList = <String>[];

      void onErrorCallback(String message, [SourceSpan span]) {
        errorList.add(message);
      }

      void onWarnCallback(String message, [SourceSpan span]) {
        warnList.add(message);
      }

      tearDown(() {
        errorList = <String>[];
        warnList = <String>[];
        file = null;
        collector = null;
      });

      group('checkForMetaPresence', () {
        group('does not throw an error when', () {
          test('there is no meta field', () {
            const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @Props()
                  mixin FooProps on UiProps {}
  
                  @State()
                  mixin FooState on UiState {}
  
                  @Component2()
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
                ''';

            file = SourceFile.fromString(boilerplateString);
            collector =
                ErrorCollector.callback(file, onError: onErrorCallback, onWarning: onWarnCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final props = members.whereType<BoilerplatePropsMixin>().first;

            checkForMetaPresence(props.node, collector);
            expect(errorList, []);
            expect(warnList, []);
          });
        });

        group('warns when', () {
          test('the meta field is static', () {
            const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @Props()
                  mixin FooProps on UiProps {
                    static const String meta = 'string';
                  }
  
                  @State()
                  mixin FooState on UiState {}
  
                  @Component2()
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
                ''';

            file = SourceFile.fromString(boilerplateString);
            collector =
                ErrorCollector.callback(file, onError: onErrorCallback, onWarning: onWarnCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final props = members.whereType<BoilerplatePropsMixin>().first;

            checkForMetaPresence(props.node, collector);
            expect(errorList, []);
            expect(warnList, [
              stringContainsInOrder(['Static class member `meta` is declared in FooProps']),
            ]);
          });
        });

        group('throws an errors when', () {
          test('meta is present', () {
            const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @Props()
                  mixin FooProps on UiProps {
                    String meta;
                  }
  
                  @State()
                  mixin FooState on UiState {}
  
                  @Component2()
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
                ''';

            file = SourceFile.fromString(boilerplateString);
            collector =
                ErrorCollector.callback(file, onError: onErrorCallback, onWarning: onWarnCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final props = members.whereType<BoilerplatePropsMixin>().first;

            checkForMetaPresence(props.node, collector);
            expect(errorList, [
              stringContainsInOrder(['Non-static class member `meta` is declared in FooProps']),
            ]);
            expect(warnList, []);
          });
        });
      });

      group('validateMetaField', () {
        group('throws an errors when', () {
          test('the companion has the wrong meta type', () {
            const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  @Component() 
                  class FooComponent {}
                  
                  @Props()
                  class _$FooProps {}
                  
                  class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
                  
                    static const StateMeta meta = _$metaForFooProps;
                  }
                  
                  @State()
                  class _$FooState {}
                  
                  class FooState extends _$FooState with _$FooStateAccessorsMixin {
                  
                    static const PropsMeta meta = _$metaForFooState;
                  }
                ''';

            file = SourceFile.fromString(boilerplateString);
            collector =
                ErrorCollector.callback(file, onError: onErrorCallback, onWarning: onWarnCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final props = members.whereType<BoilerplateProps>().first;
            final state = members.whereType<BoilerplateState>().first;

            validateMetaField(props.companion, 'PropsMeta', collector);
            expect(errorList, [
              stringContainsInOrder(
                  ['Static meta field in accessor class must be of type `PropsMeta`']),
            ]);

            errorList = <String>[];
            validateMetaField(state.companion, 'StateMeta', collector);
            expect(errorList, [
              stringContainsInOrder(
                  ['Static meta field in accessor class must be of type `StateMeta`']),
            ]);
          });

          test('the initializer is incorrect', () {
            const boilerplateString = r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  @Component() 
                  class FooComponent {}
                  
                  @Props()
                  class _$FooProps {}
                  
                  class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
                  
                    static const PropsMeta meta = _$metaForAPizza;
                  }
                  
                  @State()
                  class _$FooState {}
                  
                  class FooState extends _$FooState with _$FooStateAccessorsMixin {
                  
                    static const StateMeta meta = _$metaForAFlatbread;
                  }
                ''';

            file = SourceFile.fromString(boilerplateString);
            collector =
                ErrorCollector.callback(file, onError: onErrorCallback, onWarning: onWarnCallback);

            final members = parseAndReturnMembers(boilerplateString);
            final props = members.whereType<BoilerplateProps>().first;
            final state = members.whereType<BoilerplateState>().first;

            validateMetaField(props.companion, 'PropsMeta', collector);
            expect(errorList, [
              stringContainsInOrder([
                'Static PropsMeta field in accessor class must be initialized to:`_\$metaForFooProps`'
              ]),
            ]);

            errorList = <String>[];
            validateMetaField(state.companion, 'StateMeta', collector);
            expect(errorList, [
              stringContainsInOrder([
                'Static StateMeta field in accessor class must be initialized to:`_\$metaForFooState`'
              ]),
            ]);
          });
        });
      });
    });
  });
}
