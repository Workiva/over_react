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

@TestOn('vm')
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react/src/component_declaration/annotations.dart';
import 'package:meta/meta.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import '../ast_test_util.dart';
import '../util.dart';
import 'parsing_helpers.dart';

main() {
  group('members -', () {
    BoilerplateMemberHelper mockDeclarationHelper;

    setUp(() {
      mockDeclarationHelper = BoilerplateMemberHelper.withMockDeclarations();
    });

    group('component', () {
      BoilerplateComponent legacyBackwardCompatComponent;
      BoilerplateComponent legacyComponent;
      BoilerplateComponent newBoilerplateComponent;

      setUp(() {
        legacyBackwardCompatComponent = mockDeclarationHelper.components
            .firstWhere((component) => component.name.name == 'FirstFooComponent');
        legacyComponent = mockDeclarationHelper.components
            .firstWhere((component) => component.name.name == 'SecondFooComponent');
        newBoilerplateComponent = mockDeclarationHelper.components
            .firstWhere((component) => component.name.name == 'ThirdFooComponent');
      });

      group('propsGenericArg', () {
        test('returns the correct props class', () {
          expect(
              legacyBackwardCompatComponent.propsGenericArg.typeNameWithoutPrefix, 'FirstFooProps');
          expect(legacyComponent.propsGenericArg.typeNameWithoutPrefix, 'SecondFooProps');
          expect(newBoilerplateComponent.propsGenericArg.typeNameWithoutPrefix, 'ThirdFooProps');
        });

        test('returns null if there is no type arg', () {
          final component = BoilerplateComponent(parseAndGetSingleClassish(r'''
              class FooComponent extends UiComponent {}
          '''), VersionConfidences.none());
          expect(component.propsGenericArg, isNull);
        });
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
            BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v2)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v2_legacyBackwardsCompat),
            false);
        expect(
            BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v3)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v3_legacyDart2Only),
            false);
        expect(
            BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v4)
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
                final members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(version);
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

        group('throws when the component is mixin based but', () {
          test('does not extend Component2', () {
            file = SourceFile.fromString(r'''
            UiFactory<FooProps> Foo = _$Foo;

            mixin FooProps on UiProps {}
  
            mixin FooState on UiState {}
  
            class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
            ''');
            collector = ErrorCollector.callback(file,
                onError: validateCallback, onWarning: validateCallback);

            final members = BoilerplateMemberHelper.parseAndReturnMembers(file.getText(0));

            final component = members.whereType<BoilerplateComponent>().first;
            final componentVersion = resolveVersion(members).version;
            expect(componentVersion, Version.v4_mixinBased, reason: 'test setup check');

            component.validate(componentVersion, collector);
            expect(validateResults, [contains('Must extend UiComponent2, not UiComponent.')]);
          });

          test('has a `@Component()` annotation', () {
            file = SourceFile.fromString(r'''
            UiFactory<FooProps> Foo = _$Foo;

            mixin FooProps on UiProps {}
  
            mixin FooState on UiState {}
  
            @Component()
            class FooComponent extends UiComponent2<FooProps, FooState>{}
            ''');
            collector = ErrorCollector.callback(file,
                onError: validateCallback, onWarning: validateCallback);

            final members = BoilerplateMemberHelper.parseAndReturnMembers(file.getText(0));

            final component = members.whereType<BoilerplateComponent>().first;
            final componentVersion = resolveVersion(members).version;
            expect(componentVersion, Version.v4_mixinBased, reason: 'test setup check');

            component.validate(componentVersion, collector);
            expect(validateResults, [contains('Only @Component2() is supported for this syntax.')]);
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
                      final members =
                          BoilerplateMemberHelper.parseAndReturnMembers(componentString);
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
            final members = BoilerplateMemberHelper.parseAndReturnMembers(componentString);
            final factory = members.whereType<BoilerplateFactory>().first;

            if (![BoilerplateVersions.v4, BoilerplateVersions.v5].contains(version)) {
              expect(factory.hasFactoryAnnotation, isTrue);
            } else {
              expect(factory.hasFactoryAnnotation, isFalse);
            }
          });
        }
      });

      group('propsGenericArg', () {
        test('returns the correct props class', () {
          final factory = BoilerplateFactory(parseAndGetSingleWithType(r'''
              UiFactory<FooProps> Foo = _$Foo;
          '''), VersionConfidences.none());
          expect(factory.propsGenericArg?.typeNameWithoutPrefix, 'FooProps');
        });

        test('returns null if there is no type arg', () {
          final factory = BoilerplateFactory(parseAndGetSingleWithType(r'''
              UiFactory Foo = _$Foo;
          '''), VersionConfidences.none());
          expect(factory.propsGenericArg, isNull);
        });
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
              final members = BoilerplateMemberHelper.parseAndReturnMembers(componentString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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
              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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
              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

              final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

      group('getPropsOrStateAnnotation', () {
        Iterable<BoilerplateMember> members;
        String source;

        tearDown(() {
          members = null;
          source = null;
        });

        setUpAndTestMeta(
            {@required bool isProps,
            @required isAbstract,
            @required String source,
            isMixin = false}) {
          members = BoilerplateMemberHelper.getBoilerplateMembersFromString(source).allMembers;

          BoilerplateMember memberClass = members.firstWhere((member) {
            if (isMixin) {
              return member is BoilerplatePropsOrStateMixin && member.isProps == isProps;
            } else {
              return member is BoilerplatePropsOrState && member.isProps == isProps;
            }
          });

          expect(memberClass, isNotNull, reason: 'Sanity check');

          final annotation = getPropsOrStateAnnotation(isProps, memberClass.node);

          if (isAbstract) {
            if (isProps) {
              expect(annotation is AbstractProps, isTrue);
            } else {
              expect(annotation is AbstractState, isTrue);
            }
          } else {
            if (isProps) {
              expect(annotation is Props, isTrue);
            } else {
              expect(annotation is State, isTrue);
            }
          }

          expect(memberClass.meta.runtimeType, annotation.runtimeType);
        }

        group('and the node is a props or state class -', () {
          setUp(() {
            source = OverReactSrc.state().source;
          });

          test('props', () {
            setUpAndTestMeta(isProps: true, isAbstract: false, source: source);
          });

          test('state', () {
            setUpAndTestMeta(isProps: false, isAbstract: false, source: source);
          });

          group('and the class is abstract -', () {
            test('props', () {
              setUpAndTestMeta(
                  isProps: true, isAbstract: true, source: OverReactSrc.abstractProps().source);
            });

            test('state', () {
              setUpAndTestMeta(
                  isProps: false, isAbstract: true, source: OverReactSrc.abstractState().source);
            });
          });
        });

        group('and the node is a props or state mixin', () {
          setUp(() {
            source = OverReactSrc.mixinBasedBoilerplateState(shouldIncludeAnnotations: true).source;
          });

          test('props', () {
            setUpAndTestMeta(isProps: true, isAbstract: false, isMixin: true, source: source);
          });

          test('state', () {
            setUpAndTestMeta(isProps: false, isAbstract: false, isMixin: true, source: source);
          });

          group('and there are no annotations-', () {
            setUp(() {
              source = OverReactSrc.mixinBasedBoilerplateState().source;
            });

            test('props', () {
              setUpAndTestMeta(isProps: true, isAbstract: false, isMixin: true, source: source);
            });

            test('state', () {
              setUpAndTestMeta(isProps: false, isAbstract: false, isMixin: true, source: source);
            });
          });
        });
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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

            final members = BoilerplateMemberHelper.parseAndReturnMembers(boilerplateString);
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
