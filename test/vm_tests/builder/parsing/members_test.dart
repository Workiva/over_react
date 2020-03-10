@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import '../util.dart';

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

    Iterable<BoilerplateMember> getBoilerplateMembersFor(VersionOptions version) {
      final unit = parseString(content: getBoilerplateStrings(version: version)).unit;

      return BoilerplateMembers.detect(unit).allMembers;
    }

    Iterable<BoilerplateMember> parseAndReturnMembers(String content) {
      final unit = parseString(content: content).unit;

      return BoilerplateMembers.detect(unit).allMembers;
    }

    void runCallbackOnAllComponentTypes(
        Function(BoilerplateComponent component, Iterable<BoilerplateMember> members)
            testableCallback) {
      for (final version in VersionOptions.values) {
        test(stringKey[version], () {
          final members = parseAndReturnMembers(getBoilerplateStrings(version: version));

          testableCallback(members.firstWhereType<BoilerplateComponent>(), members);
        });
      }
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
            getBoilerplateMembersFor(VersionOptions.v2)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v2_legacyBackwardsCompat),
            false);
        expect(
            getBoilerplateMembersFor(VersionOptions.v3)
                .firstWhereType<BoilerplateComponent>()
                .isComponent2(Version.v3_legacyDart2Only),
            false);
        expect(
            getBoilerplateMembersFor(VersionOptions.v4)
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
            for (final version in VersionOptions.values) {
              test('${stringKey[version]} component', () {
                final members = getBoilerplateMembersFor(version);
                final component = members.whereType<BoilerplateComponent>().first;
                final componentVersion = resolveVersion(members).version;
                file = SourceFile.fromString(getBoilerplateStrings(version: version));
                collector = ErrorCollector.callback(file,
                    onError: validateCallback, onWarning: validateCallback);

                component.validate(componentVersion, collector);
                expect(validateResults, isEmpty);
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
            expect(validateResults.length, 1);
            expect(validateResults.first, contains('Must extend UiComponent2, not UiComponent.'));
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
                for (final version in VersionOptions.values)
                  {
                    test('$lifecycle with ${stringKey[version]}', () {
                      // Grab the boilerplate with the deprecated lifecycle method
                      final componentString = getBoilerplateStrings(
                          deprecatedLifecycleMethod: lifecycle, version: version);
                      final members = parseAndReturnMembers(componentString);
                      final component = members.whereType<BoilerplateComponent>().first;
                      final componentVersion = resolveVersion(members).version;
                      file = SourceFile.fromString(componentString);
                      collector = ErrorCollector.callback(file, onError: validateCallback);

                      component.validate(componentVersion, collector);

                      // Warnings should only be logged if the component is a Component2
                      if (component.isComponent2(componentVersion)) {
                        expect(validateResults.length, 1);
                        expect(
                            validateResults.first, contains(legacyLifecycleMethodsMap[lifecycle]));
                      } else {
                        expect(validateResults.length, 0);
                      }
                    })
                  }
              });
        });
      });
    });

    group('factory', () {
      group('hasFactoryAnnotation correctly identifies when a factory', () {
        test('has the annotation', () {});

        test('does not have the annotation', () {});
      });

      group('validate', () {
        group('does not throw when the factory is connect to', () {});

        group('throws when', () {
          test('a Dart 2 only component does not have an annotation', () {});

          test('there is more than one variable', () {});

          test('the factory is not set equal to the generated factory', () {});
        });
      });
    });

    group('BoilerplatePropsOrState', () {});

    group('BoilerplatePropsOrStateMixin', () {});

    group('BoilerplatePropsOrStateMixin', () {});

    group('utils', () {});
  });
}

enum VersionOptions {
  v2,
  v3,
  v4,
  v5,
  v6,
  v7,
  v8,
  v9,
}

const stringKey = {
  VersionOptions.v2: 'legacy (backwords compat)',
  VersionOptions.v3: 'legacy (Dart2 only)',
  VersionOptions.v4: 'mixin based (abbreviated)',
  VersionOptions.v5: 'mixin based (with class alias)',
  VersionOptions.v6: 'legacy (backwords compat - component2)',
  VersionOptions.v7: 'legacy (Dart2 only - component 2)',
  VersionOptions.v8: 'mixin based (abbreviated - with annotations)',
  VersionOptions.v9: 'mixin based (with class alias - with annotations)',
};

String getBoilerplateStrings({@required VersionOptions version, String deprecatedLifecycleMethod}) {
  var deprecatedMethod = '';

  switch (deprecatedLifecycleMethod) {
    case 'componentWillReceiveProps':
      deprecatedMethod = '''
      @override
      componentWillReceiveProps(_){}
      
      ''';
      break;
    case 'componentWillMount':
      deprecatedMethod = '''
      @override
      componentWillMount(){}
      
      ''';
      break;
    case 'componentWillUpdate':
      deprecatedMethod = '''
      @override
      componentWillUpdate(_, __){}
      
      ''';
      break;
    default:
      if (deprecatedLifecycleMethod != null) {
        throw ArgumentError(
            'lifecycleMethod should be componentWillReceiveProps, componentWillMount, or componentWillUpdate');
      }
  }

  switch (version) {
    case VersionOptions.v2:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
      ).source;
    case VersionOptions.v3:
      return OverReactSrc.state(
        backwardsCompatible: false,
        componentBody: deprecatedMethod,
      ).source;
    case VersionOptions.v4:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
      ).source;
    case VersionOptions.v5:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludePropsAlias: true,
      ).source;
    case VersionOptions.v6:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
        componentVersion: 2,
      ).source;
    case VersionOptions.v7:
      return OverReactSrc.state(
        componentBody: deprecatedMethod,
        componentVersion: 2,
        backwardsCompatible: false,
      ).source;
    case VersionOptions.v8:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludeAnnotations: true,
      ).source;
    case VersionOptions.v9:
      return OverReactSrc.mixinBasedBoilerplateState(
        componentBody: deprecatedMethod,
        shouldIncludePropsAlias: true,
        shouldIncludeAnnotations: true,
      ).source;
      break;
    default:
      return '';
  }
}

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

  @Component()
  class FirstFooComponent extends UiStatefulComponent<FirstFooProps, FooState>{}
  
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

  class ThirdFooComponent extends UiStatefulComponent2<ThirdFooProps, ThirdFooState>{}

  // -------------------------- Version.v4_mixinBased --------------------------
  // But with extended props / state aliase syntax
  UiFactory<FourthFooProps> FourthFoo = _$FourthFoo;

  mixin FourthFooPropsMixin on UiProps {}

  class FourthFooProps = UiProps with FourthFooPropsMixin;

  mixin FourthFooStateMixin on UiState {}
  
  class FourthFooState = UiState with FourthFooStateMixin;

  class FourthFooComponent extends UiStatefulComponent2<FourthFooProps, FourthFooState>{}
  
  // -------------------------- Version.v4_mixinBased --------------------------
  // But with dissassociated names to force grouping logic to utilize generics
  UiFactory<HowAboutARandomNameForProps> ThisIsABadFactoryName = _$IsThisEvenAComponentName;

  mixin HowAboutARandomNameForProps on UiProps {}

  mixin AVeryRandomNameForState on UiState {}

  class IsThisEvenAComponentNameComponent extends UiStatefulComponent2<HowAboutARandomNameForProps, AVeryRandomNameForState>{}
''';
