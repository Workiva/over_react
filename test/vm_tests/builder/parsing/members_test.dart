@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

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
      final unit = parseString(content: boilerplateStrings[version]).unit;

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
            for (final version in boilerplateStrings.keys) {
              test('${stringKey[version]} component', () {
                final members = getBoilerplateMembersFor(version);
                final component = members.whereType<BoilerplateComponent>().first;
                final componentVersion = resolveVersion(members).version;
                file = SourceFile.fromString(boilerplateStrings[version]);
                collector = ErrorCollector.callback(file,
                    onError: validateCallback, onWarning: validateCallback);

                component.validate(componentVersion, collector);
                expect(validateResults, isEmpty);
              });
            }
          });
        });

        group('throws when', () {
          test('throws when the component is mixin based but does not extend Component2', () {
            final members = parseAndReturnMembers(r'''
            UiFactory<FooProps> Foo = _$Foo;

            mixin FooProps on UiProps {}
  
            mixin FooState on UiState {}
  
            class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
            ''');

            final component = members.whereType<BoilerplateComponent>().first;
            final componentVersion = resolveVersion(members).version;
            file = SourceFile.fromString(boilerplateStrings[VersionOptions.v4]);
            collector = ErrorCollector.callback(file,
                onError: validateCallback, onWarning: validateCallback);

            component.validate(componentVersion, collector);
            expect(validateResults.first, contains('Must extend UiComponent2, not UiComponent.'));
          });

          group('throws when the component is Component2 but uses deprecated lifecycle events', () {
            Map<String, String> legacyLifecycleMethodsMap = {
              'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
              'componentWillMount': 'Use init instead.',
              'componentWillUpdate': 'Use getSnapshotBeforeUpdate instead.',
            };

            const [
              'componentWillReceiveProps',
              'componentWillMount',
              'componentWillUpdate'
            ].forEach((lifecycle) => {
                  test(lifecycle, () {
                    final string = getComponentWithDeprecatedLifecycle(lifecycle);
                    final members = parseAndReturnMembers(string);
                    final component = members.whereType<BoilerplateComponent>().first;
                    final componentVersion = resolveVersion(members).version;
                    file = SourceFile.fromString(string);
                    collector = ErrorCollector.callback(file,
                        onError: validateCallback, onWarning: validateCallback);

                    component.validate(componentVersion, collector);
                    expect(validateResults.first, contains(legacyLifecycleMethodsMap[lifecycle]));
                  })
                });
          });
        });
      });
    });

    group('factory', () {});

    group('BoilerplatePropsOrState', () {});

    group('BoilerplatePropsOrStateMixin', () {});

    group('BoilerplatePropsOrStateMixin', () {});

    group('utils', () {});
  });
}

enum VersionOptions { v2, v3, v4, v5 }

const stringKey = {
  VersionOptions.v2: 'legacy (backwords compat)',
  VersionOptions.v3: 'legacy (Dart2 only)',
  VersionOptions.v4: 'mixin based (abbreviated)',
  VersionOptions.v5: 'mixin based (with class alias)',
};

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

          @Component()
          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
      ''',
  VersionOptions.v3: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          @State()
          class _$FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component()
          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
  VersionOptions.v4: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooProps on UiProps {}

          mixin FooState on UiState {}

          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
        ''',
  VersionOptions.v5: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooPropsMixin on UiProps {}

          class FooProps = UiProps with FooPropsMixin;

          mixin FooStateMixin on UiState {}
          
          class FooState = UiState with FooStateMixin;

          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
        ''',
};

String getComponentWithDeprecatedLifecycle(String lifeCycleMethod) {
  String deprecatedMethod;

  switch (lifeCycleMethod) {
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
      throw ArgumentError(
          'lifecycleMethod should be componentWillReceiveProps, componentWillMount, or componentWillUpdate');
  }

  return '''
  UiFactory<ThirdFooProps> ThirdFoo = _\$ThirdFoo;

  mixin ThirdFooProps on UiProps {}

  mixin ThirdFooState on UiState {}

  class ThirdFooComponent extends UiStatefulComponent2<ThirdFooProps, ThirdFooState>{
    $deprecatedMethod
  }
  ''';
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
