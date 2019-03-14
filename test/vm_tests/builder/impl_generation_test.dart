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

@TestOn('vm')
library impl_generation_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/generation/impl_generation.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';

main() {
  group('ImplGenerator', () {
    ImplGenerator implGenerator;

    MockLogger logger;
    SourceFile sourceFile;
    CompilationUnit unit;
    ParsedDeclarations declarations;

    tearDown(() {
      implGenerator = null;
    });

    void setUpAndParse(String source) {
      logger = new MockLogger();

      sourceFile = new SourceFile.fromString(source);

      unit = parseCompilationUnit(source);
      declarations = new ParsedDeclarations(unit, sourceFile, logger);
      implGenerator = new ImplGenerator(logger, sourceFile);
    }

    void setUpAndGenerate(String source) {
      setUpAndParse(source);

      implGenerator = new ImplGenerator(logger, sourceFile);
      implGenerator.generate(declarations);
    }

    void verifyNoErrorLogs() {
      verifyNever(logger.warning(any));
      verifyNever(logger.severe(any));

      expect(declarations.hasErrors, isFalse);
    }

    void verifyImplGenerationIsValid() {
      var buildOutput = implGenerator.outputContentsBuffer.toString();

      expect(() {
        parseCompilationUnit(buildOutput);
      }, returnsNormally, reason: 'transformed source should parse without errors:\n');
    }

    void generateFromSource(String source) {
      setUpAndParse(source);
      implGenerator.generate(declarations);
    }

    group('generates an implementation that parses correctly', () {
      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();
        verifyImplGenerationIsValid();
      });

      void testImplGeneration(String groupName, {backwardsCompatible: true}) {
        group(groupName, () {
          test('stateful components', () {
            generateFromSource(OverReactSrc.state(backwardsCompatible: backwardsCompatible).source);
          });

          test('component', () {
            generateFromSource(OverReactSrc.props(backwardsCompatible: backwardsCompatible).source);
          });

          group('that subtypes another component, referencing the component class via', () {
            test('a simple identifier', () {
              generateFromSource(OverReactSrc.props(backwardsCompatible: backwardsCompatible, componentAnnotationArg: 'subtypeOf: BarComponent').source);
              expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: \$BarComponentFactory'));
            });

            test('a prefixed identifier', () {
              generateFromSource(OverReactSrc.props(backwardsCompatible: backwardsCompatible, componentAnnotationArg: 'subtypeOf: baz.BarComponent').source);
              expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: baz.\$BarComponentFactory'));
            });
          });

          group('and includes concrete accessors class for', () {
            void testAccessorGeneration(String testName, OverReactSrc ors) {
              group(testName, () {
                bool isProps;
                String className;
                String descriptorType;
                setUp(() {
                  generateFromSource(ors.source);
                  isProps = ors.isProps(ors.annotation);
                  className = isProps ? ors.propsClassName : ors.stateClassName;
                  descriptorType = '${isProps ? 'Prop' : 'State'}Descriptor';
                });

                test('with proper accessors class declaration, retaining type parameters', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      'abstract class _\$${className}AccessorsMixin${ors.typeParamSrc} '
                          'implements _\$$className${ors.typeParamSrcWithoutBounds} {'));
                });

                test('with abstract props/state getter', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains('@override  Map get ${isProps ? 'props' : 'state'};'));
                });

                test('contains props or state descriptors for all fields', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  static const $descriptorType _\$prop__someField___\$$className = const $descriptorType(_\$key__someField___\$$className);\n'
                      '  static const $descriptorType _\$prop__foo___\$$className = const $descriptorType(_\$key__foo___\$$className);\n'
                      '  static const $descriptorType _\$prop__bar___\$$className = const $descriptorType(_\$key__bar___\$$className);\n'
                      '  static const $descriptorType _\$prop__baz___\$$className = const $descriptorType(_\$key__baz___\$$className);\n'));
                });

                test('contains string keys', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  static const String _\$key__someField___\$$className = \'$className.someField\';\n'
                      '  static const String _\$key__foo___\$$className = \'$className.foo\';\n'
                      '  static const String _\$key__bar___\$$className = \'$className.bar\';\n'
                      '  static const String _\$key__baz___\$$className = \'$className.baz\';\n'));
                });

                test('contains list of descriptors', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  static const List<$descriptorType> ${ors.constantListName} = '
                      'const [_\$prop__someField___\$$className, '
                      '_\$prop__foo___\$$className, '
                      '_\$prop__bar___\$$className, '
                      '_\$prop__baz___\$$className];\n'));
                });

                test('contains list of keys', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  static const List<String> ${ors.keyListName} = '
                      'const [_\$key__someField___\$$className, '
                      '_\$key__foo___\$$className, '
                      '_\$key__bar___\$$className, '
                      '_\$key__baz___\$$className];\n'));
                });

                group('with concrete implementations', () {
                  test('', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  String get someField => ${isProps ? 'props' : 'state'}[_\$key__someField___\$$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set someField(String value) => ${isProps ? 'props' : 'state'}[_\$key__someField___\$$className] = value'));
                  });

                  test('for multiple fields declared on same line', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get foo => ${isProps ? 'props' : 'state'}[_\$key__foo___\$$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set foo(bool value) => ${isProps ? 'props' : 'state'}[_\$key__foo___\$$className] = value'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get bar => ${isProps ? 'props' : 'state'}[_\$key__bar___\$$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set bar(bool value) => ${isProps ? 'props' : 'state'}[_\$key__bar___\$$className] = value'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get baz => ${isProps ? 'props' : 'state'}[_\$key__baz___\$$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set baz(bool value) => ${isProps ? 'props' : 'state'}[_\$key__baz___\$$className] = value'));
                  });

                  test('containing links to source', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  /// <!-- Generated from [_\$$className.someField] -->\n'));
                  });

                  test('that carry over annotations', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains(
                        '  @deprecated()\n'
                        '  String get someField => '));
                    expect(implGenerator.outputContentsBuffer.toString(), contains(
                        '  @deprecated()\n'
                        '  set someField(String value) => '));
                  });

                  test('but does not create implementations for non-fields', () {
                    expect(implGenerator.outputContentsBuffer.toString(), isNot(contains('abstractGetter')));
                  });
                });
              });
            }

            void testAccessorGenerationForMixins(String testName, OverReactSrc ors) {
              group(testName, () {
                bool isProps;
                String className;
                String consumableClassName;
                setUp(() {
                  generateFromSource(ors.source);
                  isProps = ors.isProps(ors.annotation);
                  final nameBuilder = isProps ? ors.propsMixinClassName : ors.stateMixinClassName;
                  consumableClassName = '${backwardsCompatible ? '\$' : ''}$nameBuilder';
                  className = '${backwardsCompatible ? '' : '_\$'}$nameBuilder';
                });

                test('with proper accessors class declaration, retaining type parameters', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      'abstract class $consumableClassName${ors.typeParamSrc} '
                          'implements $className${ors.typeParamSrcWithoutBounds} {'));
                });

                test('with abstract props/state getter', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains('@override  Map get ${isProps ? 'props' : 'state'};'));
                });

                group('with concrete implementations', () {
                  test('', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  String get someField => ${isProps ? 'props' : 'state'}[_\$key__someField__$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set someField(String value) => ${isProps ? 'props' : 'state'}[_\$key__someField__$className] = value'));
                  });

                  test('for multiple fields declared on same line', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get foo => ${isProps ? 'props' : 'state'}[_\$key__foo__$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set foo(bool value) => ${isProps ? 'props' : 'state'}[_\$key__foo__$className] = value'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get bar => ${isProps ? 'props' : 'state'}[_\$key__bar__$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set bar(bool value) => ${isProps ? 'props' : 'state'}[_\$key__bar__$className] = value'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  bool get baz => ${isProps ? 'props' : 'state'}[_\$key__baz__$className] ?? null;'));
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  set baz(bool value) => ${isProps ? 'props' : 'state'}[_\$key__baz__$className] = value'));
                  });

                  test('containing links to source', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('  /// <!-- Generated from [$className.someField] -->\n'));
                  });

                  test('that carry over annotations', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains(
                        '  @deprecated()\n'
                        '  String get someField => '));
                    expect(implGenerator.outputContentsBuffer.toString(), contains(
                        '  @deprecated()\n'
                        '  set someField(String value) => '));
                  });

                  test('but does not create implementations for non-fields', () {
                    expect(implGenerator.outputContentsBuffer.toString(), isNot(contains('abstractGetter => ')));
                  });

                  test('and copies over non-field implementations', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('String get abstractGetter;'));
                  });

                  test('and copies over fields marked with `@Accessor(doNotGenerate: true)`', () {
                    expect(implGenerator.outputContentsBuffer.toString(), contains('String _someNonGeneratedField;'));
                  });
                });
              });
            }

            final body = '\n/// Doc comments\n'
                '@deprecated()\n'
                'String someField;\n'
                'bool foo, bar, baz;\n'
                'String get abstractGetter;\n'
                '@Accessor(doNotGenerate: true)\n'
                'String _someNonGeneratedField;\n';
            testAccessorGeneration('abstract props classes which are public without type parameters', OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGeneration('abstract props classes which are private without type parameters', OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGeneration('abstract props classes which are public with type parameters', OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGeneration('abstract props classes which are private with type parameters', OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));

            testAccessorGeneration('abstract state classes which are public without type parameters', OverReactSrc.abstractState(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGeneration('abstract state classes which are private without type parameters', OverReactSrc.abstractState(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGeneration('abstract state classes which are public with type parameters', OverReactSrc.abstractState(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGeneration('abstract state classes which are private with type parameters', OverReactSrc.abstractState(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));

            testAccessorGeneration('props classes which are public without type parameters', OverReactSrc.props(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGeneration('props classes which are private without type parameters', OverReactSrc.props(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGeneration('props classes which are public with type parameters', OverReactSrc.props(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGeneration('props classes which are private with type parameters', OverReactSrc.props(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));

            testAccessorGeneration('state classes which are public without type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGeneration('state classes which are private without type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGeneration('state classes which are public with type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGeneration('state classes which are private with type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));

            testAccessorGenerationForMixins('props mixins which are public without type parameters', OverReactSrc.propsMixin(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGenerationForMixins('props mixins which are private without type parameters', OverReactSrc.propsMixin(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGenerationForMixins('props mixins which are public with type parameters', OverReactSrc.propsMixin(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGenerationForMixins('props mixins which are private with type parameters', OverReactSrc.propsMixin(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));

            testAccessorGenerationForMixins('state mixins which are public without type parameters', OverReactSrc.stateMixin(backwardsCompatible: backwardsCompatible, body: body));
            testAccessorGenerationForMixins('state mixins which are private without type parameters', OverReactSrc.stateMixin(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true));
            testAccessorGenerationForMixins('state mixins which are public with type parameters', OverReactSrc.stateMixin(backwardsCompatible: backwardsCompatible, body: body, typeParameters: true));
            testAccessorGenerationForMixins('state mixins which are private with type parameters', OverReactSrc.stateMixin(backwardsCompatible: backwardsCompatible, body: body, isPrivate: true, typeParameters: true));
          });

          group('and includes the react component factory implementation', () {
            void testReactComponentFactory(String testName, OverReactSrc ors) {
              test(testName, () {
                setUpAndGenerate(ors.source);
                final baseName = ors.baseName;
                expect(implGenerator.outputContentsBuffer.toString(), contains(
                    'final \$${baseName}ComponentFactory = registerComponent(() => new _\$${baseName}Component(),\n'
                    '    builderFactory: $baseName,\n'
                    '    componentClass: ${baseName}Component,\n'
                    '    isWrapper: false,\n'
                    '    parentType: null,\n'
                    '    displayName: \'$baseName\'\n'
                  ');\n'));
              });
            }

            testReactComponentFactory('for a public concrete component class with only props', OverReactSrc.props(backwardsCompatible: backwardsCompatible));
            testReactComponentFactory('for a private concrete component class with only props', OverReactSrc.props(backwardsCompatible: backwardsCompatible, isPrivate: true));
            testReactComponentFactory('for a public concrete component class with props and state', OverReactSrc.state(backwardsCompatible: backwardsCompatible));
            testReactComponentFactory('for a private concrete component class with props and state', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true));
          });

          group('and creates factory initializer implementation', () {
            void testReactComponentFactory(String testName, OverReactSrc ors) {
              test(testName, () {
                setUpAndGenerate(ors.source);
                final baseName = ors.baseName;
                expect(implGenerator.outputContentsBuffer.toString(), contains(
                    '_\$\$${baseName}Props ${ors.factoryInitializer}([Map backingProps]) => new _\$\$${baseName}Props(backingProps);\n'));
              });
            }

            testReactComponentFactory('for a public concrete component class with only props', OverReactSrc.props(backwardsCompatible: backwardsCompatible));
            testReactComponentFactory('for a private concrete component class with only props', OverReactSrc.props(backwardsCompatible: backwardsCompatible, isPrivate: true));
            testReactComponentFactory('for a public concrete component class with props and state', OverReactSrc.state(backwardsCompatible: backwardsCompatible));
            testReactComponentFactory('for a private concrete component class with props and state', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true));
          });

          group('and creates concrete props implementation', () {
            void testConcretePropsGeneration(String testName, OverReactSrc ors) {
              group(testName, () {

                setUp(() {
                  generateFromSource(ors.source);
                });

                test('with the correct class declaration', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      'class _\$\$${ors.baseName}Props${ors.typeParamSrc} '
                      'extends _\$${ors.propsClassName}${ors.typeParamSrcWithoutBounds} '
                      'with _\$${ors.propsClassName}AccessorsMixin${ors.typeParamSrcWithoutBounds} '
                      'implements ${ors.propsClassName}${ors.typeParamSrcWithoutBounds} {'));
                });

                test('with the correct constructor', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  _\$\$${ors.baseName}Props(Map backingMap) : this._props = {} {\n'
                      '     this._props = backingMap ?? {};\n'
                      '  }'));
                });

                test('with props backing map getter', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  Map get props => _props;\n'
                      '  Map _props;'));
                });

                test('overrides `\$isClassGenerated` to return `true`', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  bool get \$isClassGenerated => true;\n'));
                });

                test('overrides `componentFactory` to return the correct component factory', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  ReactComponentFactoryProxy get componentFactory => \$${ors.baseName}ComponentFactory;\n'));
                });

                test('sets the default prop key namespace', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  String get propKeyNamespace => \'${ors.propsClassName}.\';\n'));
                });
              });
            }

            testConcretePropsGeneration('for a public props class without type parameters when no state class is declared', OverReactSrc.props(backwardsCompatible: backwardsCompatible));
            testConcretePropsGeneration('for a public props class with type parameters when no state class is declared', OverReactSrc.props(backwardsCompatible: backwardsCompatible, typeParameters: true));
            testConcretePropsGeneration('for a private props class without type parameters when no state class is declared', OverReactSrc.props(backwardsCompatible: backwardsCompatible, isPrivate: true));
            testConcretePropsGeneration('for a private props class with type parameters when no state class is declared', OverReactSrc.props(backwardsCompatible: backwardsCompatible, isPrivate: true, typeParameters: true));

            testConcretePropsGeneration('for a public props class without type parameters when a state class is declared', OverReactSrc.state(backwardsCompatible: backwardsCompatible));
            testConcretePropsGeneration('for a public props class with type parameters when a state class is declared', OverReactSrc.state(backwardsCompatible: backwardsCompatible, typeParameters: true));
            testConcretePropsGeneration('for a private props class without type parameters when a state class is declared', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true));
            testConcretePropsGeneration('for a private props class with type parameters when a state class is declared', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true, typeParameters: true));
          });

          test('does not include react component factory implementation for abstract component', () {
            setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, needsComponent: true).source);
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains('registerComponent(()')));
          });

          test('for covariant keywords', () {
            final ors = OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, body: 'covariant String foo;');
            generateFromSource(ors.source);
            expect(implGenerator.outputContentsBuffer.toString(), contains('String get foo => props[_\$key__foo___\$${ors.propsClassName}] ?? null;'));
            expect(implGenerator.outputContentsBuffer.toString(), contains('set foo(covariant String value) => props[_\$key__foo___\$${ors.propsClassName}] = value;'));
          });

          group('and creates concrete state implementation', () {
            void testConcretePropsGeneration(String testName, OverReactSrc ors) {
              group(testName, () {
                setUp(() {
                  generateFromSource(ors.source);
                });

                test('with the correct class declaration', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      'class _\$\$${ors.baseName}State${ors.typeParamSrc} '
                      'extends _\$${ors.stateClassName}${ors.typeParamSrcWithoutBounds} '
                      'with _\$${ors.stateClassName}AccessorsMixin${ors.typeParamSrcWithoutBounds} '
                      'implements ${ors.stateClassName}${ors.typeParamSrcWithoutBounds} {'));
                });

                test('with the correct constructor', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  _\$\$${ors.baseName}State(Map backingMap) : this._state = {} {\n'
                      '     this._state = backingMap ?? {};\n'
                      '  }'));
                });

                test('with state backing map getter', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  Map get state => _state;\n'
                      '  Map _state;'));
                });

                test('overrides `\$isClassGenerated` to return `true`', () {
                  expect(implGenerator.outputContentsBuffer.toString(), contains(
                      '  @override\n'
                      '  bool get \$isClassGenerated => true;\n'));
                });
              });
            }

            testConcretePropsGeneration('for a public state class without type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible));
            testConcretePropsGeneration('for a public state class with type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, typeParameters: true));
            testConcretePropsGeneration('for a private state class without type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true));
            testConcretePropsGeneration('for a private state class with type parameters', OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: true, typeParameters: true));
          });
        });
      }

      testImplGeneration(', with backwards compatible boilerplate,', backwardsCompatible: true);

      testImplGeneration(', with Dart 2 only boilerplate,', backwardsCompatible: false);

      group('and generated consumable companion class with Dart 2 only boilerplate', () {
        void testConsumableCompanionGeneration(String testName, OverReactSrc ors) {
          test(testName, () {
            setUpAndGenerate(ors.source);
            final className = ors.isProps(ors.annotation) ? ors.propsClassName : ors.stateClassName;
            final metaStructName = ors.isProps(ors.annotation) ? 'PropsMeta' : 'StateMeta';
            expect(implGenerator.outputContentsBuffer.toString(), contains(
                  'class $className extends _\$$className with _\$${className}AccessorsMixin {\n'
                  '  static const $metaStructName meta = _\$metaFor$className;\n'
                  '}\n'));
          });
        }
        testConsumableCompanionGeneration('for props classes', OverReactSrc.props(backwardsCompatible: false));
        testConsumableCompanionGeneration('for abstract props classes', OverReactSrc.abstractProps(backwardsCompatible: false));
        testConsumableCompanionGeneration('for state classes', OverReactSrc.state(backwardsCompatible: false));
        testConsumableCompanionGeneration('for abstract state classes', OverReactSrc.abstractState(backwardsCompatible: false));
      });

      group('and copies over static fields with Dart 2 only boilerplate', () {
        final fieldDeclarations = [
              'static const String some_string_const = \'some_string_prop\';',
              'static final SomeMapView defaultProps = ',
              'new SomeMapView({})',
              '..item1 = 1',
              '..item2 = \'some_prop\';'
            ];

        final uselessMetaField = 'static const String meta = \'some_string\';';
        final uselessMetaMethod = 'static String get meta => \'some_string\';';

        final fieldDeclarationsWithMetaField = List.from(fieldDeclarations)..add(uselessMetaField);
        final fieldDeclarationsWithMetaMethod = List.from(fieldDeclarations)..add(uselessMetaMethod);

        void testStaticFieldCopying(OverReactSrc ors) {
          setUpAndGenerate(ors.source);
          fieldDeclarations.forEach((piece) {
            expect(implGenerator.outputContentsBuffer.toString().trim(), contains(piece));
          });
        }

        group('for a props class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.props(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.props(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.props(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });

        group('for a state class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.state(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.state(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.state(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });

        group('for a abstract props class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.abstractProps(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.abstractProps(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.abstractProps(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });

        group('for a abstract state class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.abstractState(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.abstractState(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.abstractState(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });

        group('for a props mixin class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.propsMixin(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.propsMixin(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.propsMixin(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });

        group('for a state mixin class', () {
          test('', () {
            testStaticFieldCopying(OverReactSrc.stateMixin(backwardsCompatible: false, body: fieldDeclarations.join('\n')));
          });

          test(', except for static `meta` field', () {
            testStaticFieldCopying(OverReactSrc.stateMixin(backwardsCompatible: false, body: fieldDeclarationsWithMetaField.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaField)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });

          test(', except for static `meta` method', () {
            testStaticFieldCopying(OverReactSrc.stateMixin(backwardsCompatible: false, body: fieldDeclarationsWithMetaMethod.join('\n')));
            expect(implGenerator.outputContentsBuffer.toString(), isNot(contains(uselessMetaMethod)));
            // clear the warning coming from declaration parsing about having static meta
            verify(logger.warning(any));
          });
        });
      });

      group('static meta field', () {
        void testStaticMetaField(String testName, OverReactSrc ors) {
          test(testName, () {
            setUpAndGenerate(ors.source);
            final accessorsClassName = testName.contains('mixin')
                ? '\$${ors.propsOrStateOrMixinClassName}'
                : '_\$${ors
                .propsOrStateOrMixinClassName}AccessorsMixin';
            final propsOrStateOrMixinClassName = ors.propsOrStateOrMixinClassName;
            final annotatedPropsOrStateOrMixinClassName = testName.contains('mixin') ? propsOrStateOrMixinClassName : '_\$$propsOrStateOrMixinClassName';
            final expectedAccessorsMixinClass = 'abstract class $accessorsClassName implements $annotatedPropsOrStateOrMixinClassName';
            final metaStructName = ors.metaStructName(ors.annotation);
            final expectedMetaForInstance = (new StringBuffer()
              ..writeln('const $metaStructName _\$metaFor$propsOrStateOrMixinClassName = const $metaStructName(')
              ..writeln('  fields: $accessorsClassName.${ors.constantListName},')
              ..writeln('  keys: $accessorsClassName.${ors.keyListName},')
              ..writeln(');')
            ).toString();

            expect(implGenerator.outputContentsBuffer.toString(), contains(expectedAccessorsMixinClass));
            expect(implGenerator.outputContentsBuffer.toString(), contains(expectedMetaForInstance));
          });
        }

        testStaticMetaField('props class', OverReactSrc.props());
        testStaticMetaField('state class', OverReactSrc.state());
        testStaticMetaField('props mixin', OverReactSrc.propsMixin());
        testStaticMetaField('state mixin', OverReactSrc.stateMixin());
        testStaticMetaField('abstract props', OverReactSrc.abstractProps());
        testStaticMetaField('abstract state', OverReactSrc.abstractState());
      });
    });

    group('logs an error when', () {
      group('a component class', () {
        test('subtypes itself', () {
          setUpAndGenerate(OverReactSrc.props(backwardsCompatible: false, componentAnnotationArg: 'subtypeOf: FooComponent').source);
          verify(logger.severe(contains('A component cannot be a subtype of itself.')));
        });
      });

      group('a props mixin is', () {
        const String expectedPropsGetterError =
            'Props mixin classes must declare an abstract props getter `Map get props;` '
            'so that they can be statically analyzed properly.';

        test('declared without an abstract `props` getter', () {
          setUpAndGenerate('''
            @PropsMixin()
            abstract class _\$FooPropsMixin {
              var bar;
            }
          ''');
          verify(logger.severe(contains(expectedPropsGetterError)));
        });

        group('declared with a malformed `props` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class _\$FooPropsMixin {
                Map props;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedPropsGetterError)));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class _\$FooPropsMixin {
                NotAMap get props;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedPropsGetterError)));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class _\$FooPropsMixin {
                get props;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedPropsGetterError)));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class _\$FooPropsMixin {
                Map get props => null;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedPropsGetterError)));
          });
        });
      });

      group('a state mixin is', () {
        const String expectedStateGetterError =
            'State mixin classes must declare an abstract state getter `Map get state;` '
            'so that they can be statically analyzed properly.';

        test('declared without an abstract `state` getter', () {
          setUpAndGenerate('''
            @StateMixin()
            abstract class _\$FooStateMixin {
              var bar;
            }
          ''');
          verify(logger.severe(contains(expectedStateGetterError)));
        });

        group('declared with a malformed `state` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class _\$FooStateMixin {
                Map state;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedStateGetterError)));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class _\$FooStateMixin {
                NotAMap get state;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedStateGetterError)));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class _\$FooStateMixin {
                get state;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedStateGetterError)));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class _\$FooStateMixin {
                Map get state => null;

                var bar;
              }
            ''');
            verify(logger.severe(contains(expectedStateGetterError)));
          });
        });
      });

      test('accessors are declared as fields with initializers', () {
        setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: 'var bar = null;').source);
        verify(logger.severe(contains('Fields are stubs for generated setters/getters and should not have initializers.')));
      });

      group('accessors have', () {
        const expectedAccessorErrorMessage = '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
            'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.';

        test('the Accessor and requiredProp annotation', () {
          var body = '''@Accessor()
              @requiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: body).source);
          verify(logger.severe(contains(expectedAccessorErrorMessage)));
        });

        test('the Accessor and nullableRequiredProp annotation', () {
          var body = '''@Accessor()
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: body).source);
          verify(logger.severe(contains(expectedAccessorErrorMessage)));
        });

        test('the requiredProp and nullableRequiredProp annotation', () {
          var body = '''@requiredProp
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: body).source);
          verify(logger.severe(contains(expectedAccessorErrorMessage)));
        });
      });
    });

    group('logs a warning when', () {
      tearDown(() {
        verifyImplGenerationIsValid();
      });

      group('a Component', () {
        test('implements typedPropsFactory', () {
          setUpAndGenerate(OverReactSrc.props(backwardsCompatible: false, componentBody: 'typedPropsFactory(Map backingMap) => {};').source);
          verify(logger.warning(contains('Components should not add their own implementions of typedPropsFactory or typedStateFactory.')));
        });

        test('implements typedStateFactory', () {
          setUpAndGenerate(OverReactSrc.props(backwardsCompatible: false, componentBody: 'typedStateFactory(Map backingMap) => {};').source);
          verify(logger.warning(contains('Components should not add their own implementions of typedPropsFactory or typedStateFactory.')));
        });
      });

      group('comma-separated variables are declared', () {
        const String expectedCommaSeparatedWarning =
            'Note: accessors declared as comma-separated variables will not all be generated '
            'with the original doc comments and annotations; only the first variable will.';

        test('with doc comments', () {
          var body = '''/// Doc comment
              var bar, baz;''';
          setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: body).source);
          verify(logger.warning(contains(expectedCommaSeparatedWarning)));
        });

        test('with annotations', () {
          var body = '''@Annotation()
            var bar, baz;''';
          setUpAndGenerate(OverReactSrc.abstractProps(backwardsCompatible: false, body: body).source);
          verify(logger.warning(contains(expectedCommaSeparatedWarning)));
        });
      });
    });
  });
}

