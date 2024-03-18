import 'package:over_react_analyzer_plugin/src/diagnostic/unsafe_required_prop_access.dart';
import 'package:test/test.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  group('UnsafeRequiredPropAccess', () {
    late UnsafeRequiredPropAccessTest testBase;

    setUp(() async {
      testBase = UnsafeRequiredPropAccessTest();
      await testBase.setUp();
    });

    tearDown(() async {
      await testBase.tearDown();
    });

    group('does not warn for optional props', () {
      test('declared in a custom props mixin', () async {
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=Dart*/ r'''
          test(HasRequiredProps props) {
            props.optionalProp;
            props.optionalDynamicProp;
          }
        '''));
      });

      test('declared in UbiquitousDomPropsMixin', () async {
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=Dart*/ r'''
          test(HasRequiredProps props) {
            props.id;
            props.children;
            props.onClick;
          }
        '''));
      });

      test('in different parent nodes and syntaxes', () async {
        // Keep this in sync with the similar 'in different parent nodes and syntaxes' test
        // within the `warns for unsafe prop accesses` group below.
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
          test(HasRequiredProps props) {
            // Nested in property access
            props.optionalProp.hashCode;
            (props.optionalProp).hashCode;
            
            // Nested in method call
            props.optionalProp.toString(); 
            (props.optionalProp).toString();
            
            // Target is an arbitrary expression
            (props).optionalProp;
            HasRequired().optionalProp;
            
            // Nested in cascade
            props..optionalProp;  
            props..optionalProp.hashCode;  
            props..optionalProp.toString();
            
            // Compound assignment
            props.optionalProp ??= "";
          }
        '''));
      });
    });

    group('warns for unsafe late required prop accesses', () {
      group('on arbitrary props objects:', () {
        test('basic cases', () async {
          final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
            test(HasRequiredProps props) {
              print(props.requiredProp);
              print(props.optionalProp);
            }
          ''');

          expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
            testBase
                .isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp#'))
                .havingMessage(contains("Accessing required prop 'requiredProp' on a potentially incomplete")),
          ]);
        });

        test('in different parent nodes and syntaxes', () async {
          // Keep this in sync with the similar 'in different parent nodes and syntaxes' test
          // within the `does not warn for optional props` group above.
          final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
            test(HasRequiredProps props) {
              // Nested in property access
              props.requiredProp.hashCode;
              (props.requiredProp).hashCode;
              
              // Nested in method call
              props.requiredProp.toString(); 
              (props.requiredProp).toString();
              
              // Target is an arbitrary expression
              (props).requiredProp;
              HasRequired().requiredProp;
              
              // Nested in cascade
              props..requiredProp;  
              props..requiredProp.hashCode;  
              props..requiredProp.toString();
              
              // Compound assignment
              props.requiredProp += "";
            }
          ''');

          final createSelection = testBase.createSelection;
          final isAnErrorUnderTest = testBase.isAnErrorUnderTest;
          expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props.#requiredProp#.hashCode;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, '(props.#requiredProp#).hashCode;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props.#requiredProp#.toString();')),
            isAnErrorUnderTest(locatedAt: createSelection(source, '(props.#requiredProp#).toString();')),
            isAnErrorUnderTest(locatedAt: createSelection(source, '(props).#requiredProp#;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'HasRequired().#requiredProp#;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props..#requiredProp#;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props..#requiredProp#.hashCode;')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props..#requiredProp#.toString();')),
            isAnErrorUnderTest(locatedAt: createSelection(source, 'props.#requiredProp# += "";'), hasFix: false),
          ]);
        });
      });

      group('inside a component', () {
        test('', () async {
          final source = testBase.newSourceWithPrefix(componentSource(ComponentType.uiFunction, componentBody: r'''
            test(HasRequiredProps otherProps) {
              print(otherProps.requiredProp);
            }
          '''));

          expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
            testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'otherProps.#requiredProp#')),
          ]);
        });

        test('when shadowing `props`', () async {
          final source = testBase.newSourceWithPrefix(componentSource(ComponentType.uiFunction, componentBody: r'''
            // Statically access props so we know it's being shadowed in this test setup.
            // If it's not, we'll get a built-in analysis error that will fail the test.
            print(props.requiredProp);
            
            // Shadow `props` with another variable of the same name.
            test(HasRequiredProps props) {
              print(props.requiredProp + "");
            }
          '''));
          expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
            testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp# + ""')),
          ]);
        });
      });

      test('and suggests a fix to use getRequiredPropOrNull', () async {
        final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
          test(HasRequiredProps props) {
            print(props.requiredProp);
          }
        ''');
        final fix = await testBase.expectSingleErrorFix(testBase.createSelection(source, 'props.#requiredProp#'));
        expect(fix.fixes.single.change.message, "Use 'getRequiredPropOrNull' to safely access the prop.");
        final fixedSource = testBase.applyErrorFixes(fix, source);
        expect(fixedSource.contents.data, contains(/*language=dart*/ r'''
          test(HasRequiredProps props) {
            print(props.getRequiredPropOrNull((p) => p.requiredProp));
          }
        '''));
      });
    });

    group('warns based on the top-level directory,', () {
      Future<void> sharedTest({
        required String topLevelDirectory,
        required bool expectError,
      }) async {
        final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
          test(HasRequiredProps props) {
            print(props.requiredProp);
          }
        ''', topLevelDirectory: topLevelDirectory);

        if (expectError) {
          expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
            testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp#')),
          ]);
        } else {
          await testBase.expectNoErrors(source);
        }
      }

      group('warning for', () {
        test('lib', () => sharedTest(topLevelDirectory: 'lib', expectError: true));
        test('example', () => sharedTest(topLevelDirectory: 'example', expectError: true));
        test('web', () => sharedTest(topLevelDirectory: 'web', expectError: true));
        test('other directories', () => sharedTest(topLevelDirectory: 'other_directory', expectError: true));
      });

      group('not warning for', () {
        test('test', () => sharedTest(topLevelDirectory: 'test', expectError: false));
      });
    });

    group('does not warn for non-prop accesses:', () {
      test('fields on non-prop classes', () async {
        await testBase.expectNoErrors(testBase.newSource(/*language=Dart*/ r'''
          // End with "Props" because we short-circuit on types that end with props.
          class NotProps {
            String? someField;
            // This declaration is identical to that of a required prop,
            // but it isn't one.
            late String lateField;
          }
          
          test(NotProps notProps) {
            notProps.lateField;
            notProps.someField;
            notProps.hashCode;
          }
        '''));
      });

      test('static fields on props objects', () async {
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=Dart*/ r'''
          mixin HasStaticMembersProps {
            static late String lateStaticField;
            static String staticField = '';
          }
          
          test() {
            HasStaticMembersProps.lateStaticField;
            HasStaticMembersProps.staticField;
          }
        '''));
      });

      test('required prop references in doc comments', () async {
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=Dart*/ r'''
          /// Test doc comment with reference to: [HasRequiredProps.requiredProp]
          test(HasRequiredProps props) {}
        '''));
      });
    });

    group('does not warn for safe accesses of late required props:', () {
      group('a component\'s own props', () {
        test('within a uiFunction', () async {
          await testBase
              .expectNoErrors(testBase.newSourceWithPrefix(componentSource(ComponentType.uiFunction, componentBody: r'''
            print(props.requiredProp);
            print(props.optionalProp);
          ''')));
        });

        test('within a uiForwardRef', () async {
          await testBase.expectNoErrors(
              testBase.newSourceWithPrefix(componentSource(ComponentType.uiForwardRef, componentBody: r'''
            print(props.requiredProp);
            print(props.optionalProp);
          ''')));
        });

        test('within a class component', () async {
          await testBase
              .expectNoErrors(testBase.newSourceWithPrefix(componentSource(ComponentType.component2, componentBody: r'''
            render() {
              print(props.requiredProp);
              print(props.optionalProp);
              _renderHelper();
            }
            _renderHelper() {
              print(props.requiredProp);
              print(props.optionalProp);
            }
          ''')));
        });
      });

      test('within utility method callbacks', () async {
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ '''
          test1(HasRequiredProps props) {
            // UiProps methods
            print(props.getPropKey((p) => p.requiredProp));
            print(props.containsProp((p) => p.requiredProp));
            print(props.getRequiredProp((p) => p.requiredProp, orElse: () => ''));
            print(props.getRequiredPropOrNull((p) => p.requiredProp));
          }
          
          testTopLevel(HasRequiredProps props) {
            // Top-level functions  
            print(getPropKey<HasRequiredProps>((p) => p.requiredProp, HasRequired));
          }
          
          ${componentSource(ComponentType.component2, componentBody: r'''
            render() {
              // UiComponent methods
              print(keyForProp((p) => p.requiredProp));
              // `this.` is necessary to avoid top-level getPropKey taking precedence.
              print(this.getPropKey((p) => p.requiredProp)); // ignore: deprecated_member_use
            }
          ''')}
        '''));
      });

      group('when gated by a containsProp check -', () {
        test('simple if-check', () async {
          await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
            test(HasRequiredProps props) {
              if (props.containsProp((p) => p.requiredProp)) {
                print(props.requiredProp);
              }
            }
          '''));
        });

        test('simple else-if-check', () async {
          await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
            test(HasRequiredProps props, bool otherCondition) {
              if (otherCondition) {
                print('other condition');
              } else if (props.containsProp((p) => p.requiredProp)) {
                print(props.requiredProp);
              }
            }
          '''));
        });

        group('simple if-check `&&` another condition:', () {
          test('left-hand condition', () async {
            await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props, bool otherCondition) {
                if (props.containsProp((p) => p.requiredProp) && otherCondition) {
                  print(props.requiredProp);
                }
              }
            '''));
          });

          test('right-hand condition', () async {
            await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props, bool otherCondition) {
                if (otherCondition && props.containsProp((p) => p.requiredProp)) {
                  print(props.requiredProp);
                }
              }
            '''));
          });

          test('more than two `&&`s', () async {
            await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props, bool otherCondition) {
                if (otherCondition && props.containsProp((p) => p.requiredProp) && otherCondition) {
                  print(props.requiredProp);
                }
              }
            '''));
          });
        });

        group('except when the containsProp check', () {
          test('is for a different prop', () async {
            final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props) {
                if (props.containsProp((p) => p.optionalProp)) {
                  print(props.requiredProp);
                }
              }
            ''');
            expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
              testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp#')),
            ]);
          });

          test('is on a different object', () async {
            final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props1, HasRequiredProps props2) {
                if (props1.containsProp((p) => p.requiredProp)) {
                  print(props2.requiredProp);
                }
              }
            ''');
            expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
              testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props2.#requiredProp#')),
            ]);
          });

          test('is not definitely true', () async {
            final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props, bool otherCondition) {
                if (props.containsProp((p) => p.requiredProp) || otherCondition) {
                  print(props.requiredProp);
                }
              }
            ''');
            expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
              testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp#')),
            ]);
          });

          test('is negated', () async {
            final source = testBase.newSourceWithPrefix(/*language=dart*/ r'''
              test(HasRequiredProps props) {
                if (!props.containsProp((p) => p.requiredProp)) {
                  print(props.requiredProp);
                }
              }
            ''');
            expect(await testBase.getAllErrors(source, includeOtherCodes: true), [
              testBase.isAnErrorUnderTest(locatedAt: testBase.createSelection(source, 'props.#requiredProp#')),
            ]);
          });
        });
      });

      // FIXME add tests for other lifecycle methods here or above

      test('within certain component lifecycle methods', () async {
        // FIXME clarify that even unsafe accesses aren't linted
        await testBase.expectNoErrors(testBase.newSourceWithPrefix(/*language=dart*/ r'''
          abstract class TestComponent2 extends UiComponent2<HasRequiredProps> {
            get propTypes => {
              keyForProp((p) => p.requiredProp): (props, _) {
                print(typedPropsFactory(props).requiredProp);
                return null;
              },
            };
            @override componentDidUpdate(prevProps, _, [__]) { print(typedPropsFactory(prevProps).requiredProp); }  
            @override getDerivedStateFromProps(nextProps, _) { print(typedPropsFactory(nextProps).requiredProp); return {}; }  
            @override getSnapshotBeforeUpdate(prevProps, _)  { print(typedPropsFactory(prevProps).requiredProp); return null; }  
            @override shouldComponentUpdate(nextProps, _)    { print(typedPropsFactory(nextProps).requiredProp); return true; }
          }
          
          abstract class TestComponent1 extends UiComponent<HasRequiredProps> {
            // Just test UiComponent-specific methods
            @override componentWillReceiveProps(nextProps)               { print(typedPropsFactory(nextProps).requiredProp); super.componentWillReceiveProps(nextProps); }  
            @override componentWillReceivePropsWithContext(nextProps, _) { print(typedPropsFactory(nextProps).requiredProp); }  
            @override componentWillUpdate(prevProps, _, [__])            { print(typedPropsFactory(prevProps).requiredProp); }  
            @override shouldComponentUpdateWithContext(nextProps, _, __) { print(typedPropsFactory(nextProps).requiredProp); return true; }
          }
        '''));
      });
    });
  });
}

class UnsafeRequiredPropAccessTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => UnsafeRequiredPropAccessDiagnostic.code;

  @override
  get fixKindUnderTest => UnsafeRequiredPropAccessDiagnostic.fixKind;

  Source newSourceWithPrefix(String sourceFragment, {String topLevelDirectory = 'lib'}) =>
      newSource(sourcePrefix + sourceFragment, topLevelDirectory: topLevelDirectory);
}

const sourcePrefix = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

// ignore_for_file: unused_local_variable

UiFactory<HasRequiredProps> HasRequired = castUiFactory(_$HasRequired);

mixin HasRequiredProps on UiProps {
  late String requiredProp;
  String? optionalProp;
  dynamic optionalDynamicProp;
}
''';

String componentSource(ComponentType componentType, {required String componentBody, String componentName = 'Test'}) {
  final propsName = '${componentName}Props';

  final buffer = StringBuffer()..writeln('class $propsName = UiProps with HasRequiredProps;');
  switch (componentType) {
    case ComponentType.component2:
      buffer.writeln('UiFactory<$propsName> $componentName = castUiFactory(_\$$componentName);');
      buffer.writeln('class ${componentName}Component extends UiComponent2<$propsName> {');
      buffer.writeln(componentBody);
      buffer.writeln('}');
      break;
    case ComponentType.uiFunction:
      buffer.writeln('UiFactory<$propsName> $componentName = uiFunction((props) {');
      buffer.writeln(componentBody);
      buffer.writeln('}, _\$${componentName}Config);');
      break;
    case ComponentType.uiForwardRef:
      buffer.writeln('UiFactory<$propsName> $componentName = uiForwardRef((props, ref) {');
      buffer.writeln(componentBody);
      buffer.writeln('}, _\$${componentName}Config);');
      break;
  }
  return buffer.toString();
}

enum ComponentType {
  component2,
  uiFunction,
  uiForwardRef,
}
