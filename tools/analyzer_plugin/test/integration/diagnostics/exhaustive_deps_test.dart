
import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:path/path.dart' as p;
import 'package:over_react_analyzer_plugin/src/diagnostic/exhaustive_deps.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_util.dart';
import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';
import '../test_bases/server_plugin_contributor_test_base.dart';
import 'exhaustive_deps_test_cases.dart' as test_cases;

void main() {
  group('ExhaustiveDeps', () {
    String getPreamble([String fileName = 'test.dart']) => '''
// ignore_for_file: unused_import, unused_local_variable
    
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react.dart' as over_react;

part '${fileName.replaceFirst('.dart', '.over_react.g.dart')}';

// Implement APIs not defined in MockSdk
dynamic window;
String jsonEncode(Object object) => 'json';
extension on List {
  set length(int newLength) {}
}

mixin TestProps on UiProps {
  var foo;
  var bar;
  var baz;
  var history;
  var innerRef;
  late List items;
  late num delay;
  late dynamic Function() myEffect;
  late int upperViewHeight;
  var local;
  var activeTab;
  var maybeRef2;
  var prop;
  late dynamic Function() fn1;
  late Function fn2;
  var hello;
  var attribute;
  late Function function;
  late Ref<dynamic> someOtherRefs;
  var color;
  var initY;
  late Function onPlay;
  late Function onPause;
  late bool isEditMode;
  late Function toggleEditMode;
  late Function fetchPodcasts;
  late Function fetchPodcasts2;
  var country;
  var prop1;
  var prop2;
  var section_components;
  late int step;
  var increment;
  late UiFactory Component;
}

// Globals used by multiple test cases
int setInterval(Function callback, [int? duration]) => 0;
void clearInterval(int id) {}
int setTimeout(Function callback, [int? duration]) => 0;
void clearTimeout(int id) {}
Function? fetch;
void useCustomEffect(Function callback, [List? dependencies]) {}
dynamic Function() debounce(Function callback, num? delay) => (() => null);
var global;
dynamic someFunc() => null;

// Classes used by multiple test cases
abstract class Store {
  static Function? subscribe(Function listener) => null;
}
abstract class MutableStore {
  static dynamic get hello => null;
}
class SomeObject {
  final int? id;
  SomeObject({this.id});
}
class ObjectWithWritableField {
  var field;
}
''';

    bool errorFilter(AnalysisError error, {required bool isFromPlugin}) =>
        defaultErrorFilter(error, isFromPlugin: isFromPlugin) &&
        // These are intentionally undefined references
        !(error.code == 'undefined_identifier' && error.message.contains("Undefined name 'unresolved'."));

    Future<HooksExhaustiveDepsDiagnosticTest> setUpTestBase(TestCase testCase) async {
      final additionalHooks = testCase.options
          ?.map((option) => option['additionalHooks'] as String?)
          .whereNotNull()
          .firstOrNull;

      String? analysisYaml;
      if (additionalHooks != null) {
        // Yaml is a superset of JSON, so we can use it where Yaml is expected. And outputting JSON is easier. :)
        // Also, this way, we don't have to worry about escaping strings if we're constructing the yaml ourselves.
        analysisYaml = jsonEncode({
          'over_react': {
            'exhaustive_deps': {
              'additional_hooks': additionalHooks,
            },
          },
        });
      }

      final testBase = HooksExhaustiveDepsDiagnosticTest(analysisOptionsYamlContents: analysisYaml);
      await testBase.setUp();
      addTearDown(testBase.tearDown);
      return testBase;
    }

    ({
      'tests': test_cases.tests,
      'testsFlow': test_cases.testsFlow,
      'testsTypescript': test_cases.testsTypescript,
      'testsTypescriptEslintParserV4': test_cases.testsTypescriptEslintParserV4,
    }).forEach((suiteName, suite) {
      group('$suiteName:', () {
        group('test cases that should pass', () {
          suite['valid']!.forEachIndexed((i, element) {
            final testCase = TestCase.fromJson(element);
            test('valid[$i]${testCase.name == null ? '' : ' - ${testCase.name}'}', () async {
              // When there are test failures, it's useful to have the original source handy for debugging
              // and for searching for the test case object up the test case.
              printOnFailure('Test case source (before adding preamble): ```\n${testCase.code}\n```');

              final testBase = await setUpTestBase(testCase);

              final fileName = testBase.uniqueSourceFileName();
              final source = testBase.newSource(getPreamble(fileName) + testCase.code, path: fileName);
              await testBase.expectNoErrors(source, errorFilter: errorFilter);
            });
          });
        });

        group('test cases that should warn', () {
          suite['invalid']!.forEachIndexed((i, element) {
            final testCase = TestCase.fromJson(element);
            test('invalid[$i]${testCase.name == null ? '' : ' - ${testCase.name}'}', () async {
              // When there are test failures, it's useful to have the original source handy for debugging
              // and for searching for the test case object up the test case.
              printOnFailure('Test case source (before adding preamble): ```\n${testCase.code}\n```');

              final testBase = await setUpTestBase(testCase);

              final expectedErrors = testCase.errors;
              expect(expectedErrors, isNotEmpty);


              final fileName = testBase.uniqueSourceFileName();
              final preamble = getPreamble(fileName);
              final source = testBase.newSource(preamble + testCase.code, path: fileName);
              final errors = await testBase.getAllErrors(source, includeOtherCodes: true, errorFilter: errorFilter);
              expect(errors.dartErrors, isEmpty,
                  reason: 'Expected there to be no errors coming from the analyzer and not the plugin.'
                      ' Ensure your test source is free of unintentional errors, such as syntax errors and missing imports.'
                      ' If errors are expected, set includeOtherErrorCodes:true.');
              expect(
                  errors.pluginErrors,
                  everyElement(
                      AnalysisErrorHavingUtils(isA<AnalysisError>()).havingCode(ExhaustiveDeps.code.name)),
                  reason: 'Expected all errors to match the error & fix kinds under test.');

              /// A mapping of the index of the actual error to the index of te expected error,
              /// so we can validate the appropriate fixes for each below.
              final expectedErrorIndexByActualErrorIndex = <int, int>{};

              {
                final expectedMessages = expectedErrors.map((e) => e['message'] as String).toList();

                // Replace line numbers in messages so we don't have to update them every time the preamble changes.
                // Do this instead of just ignoring line numbers in the messages, since that can lead to ambiguities
                // between similar errors with different line numbers when mapping their indexes below.
                final numPreambleLinesAdded = '\n'.allMatches(preamble).length;
                final actualMessages = errors.map((e) {
                  return e.message.replaceAllMapped(RegExp(r'(at line )(\d+)'), (match) {
                    final lineNumber = int.parse(match[2]!);
                    return '${match[1]}${lineNumber - numPreambleLinesAdded}';
                  });
                }).toList();

                expect(actualMessages, unorderedEquals(expectedMessages));

                expectedMessages.forEachIndexed((expectedIndex, expectedMessage) {
                  final actualIndex = actualMessages.indexOf(expectedMessage);
                  if (expectedErrorIndexByActualErrorIndex.containsKey(actualIndex)) {
                    throw StateError(
                        'The same expected error message occurs twice, preventing us from mapping them unambiguously.'
                        ' Please update the test case to not have two of the exact same error messages.'
                        ' Duplicate message: "$expectedMessage"');
                  }
                  expectedErrorIndexByActualErrorIndex[actualIndex] = expectedIndex;
                });
              }

              // Suggestions
              //           'suggestions': [
              //             {
              //               'desc': 'Update the dependencies list to be: [props.foo]',
              //               'output': r'''
              //                 final MyComponent = uiFunction<TestProps>((props) {
              //                   useCallback(() {
              //                     print(props.foo?.toString());
              //                   }, [props.foo]);
              //                 }, null);
              //               ''',
              //             },
              for (var i = 0; i < errors.length; i++) {
                final actualError = errors.elementAt(i);
                Map<dynamic, dynamic> expectedError;
                final expectedErrorIndex = expectedErrorIndexByActualErrorIndex[i]!;
                try {
                  expectedError = expectedErrors[expectedErrorIndex];
                } catch (_) {
                  // The StateError check in the mapping should probably render this catch unreachable, but we'll
                  // leave this in here just in case.
                  print('Error mapping actual error at index $i to expected error');
                  print('expectedErrorIndex: $expectedErrorIndex');
                  print('actualError: $actualError');
                  print('expectedErrorIndexByActualErrorIndex: $expectedErrorIndexByActualErrorIndex');
                  print('expectedErrors: $expectedErrors');
                  print('errors: $errors');
                  rethrow;
                }

                final expectedFixes = (expectedError['suggestions'] as List? ?? <dynamic>[]).cast<Map>();

                final actualFixesForError = (await testBase.getAllErrorFixesAtSelection(
                        SourceSelection(source, actualError.location.offset, actualError.location.length)))
                    // Some cases have multiple errors on the same selection, each potentially having their own fix.
                    // Sometimes, the codes are the same, too, so we'll ise the message to disambiguate.
                    .where((f) => f.error.code == actualError.code && f.error.message == actualError.message)
                    .toList();

                if (expectedFixes.isEmpty) {
                  // Check this before `.hasFix` one so we can see the actual fixes if this `expect` fails.
                  expect(actualFixesForError, isEmpty, reason: 'was not expecting fixes');
                  expect(actualError.hasFix, isFalse, reason: 'was not expecting the error to report it has a fix');
                } else {
                  String prettyExpectedFixes() => JsonEncoder.withIndent('  ').convert(expectedFixes);
                  expect(actualError.hasFix, isTrue,
                      reason: 'error should report it has a fix. Expected fixes: ${prettyExpectedFixes()}');
                  expect(actualFixesForError, isNotEmpty,
                      reason: 'was expecting fixes but got none. Expected fixes: ${prettyExpectedFixes()}');
                  expect(
                      actualFixesForError,
                      everyElement(
                          isA<AnalysisErrorFixes>().having((f) => f.fixes, 'fixes', [testBase.isAFixUnderTest()])));

                  if (expectedFixes.length > 1 || actualFixesForError.length > 1) {
                    throw UnimplementedError('Test does not currently support multiple suggestions/fixes');
                  }

                  final expectedFix = expectedFixes.single;
                  final expectedFixMessage = expectedFix['desc'] as String;
                  final expectedOutput = expectedFix['output'] as String;
                  expect(expectedFixMessage, isNotNull,
                      reason: 'test setup check: test suggestion \'desc\' should not be null');
                  expect(expectedOutput, isNotNull,
                      reason: 'test setup check: test suggestion \'output\' should not be null');

                  final actualFix = actualFixesForError.single;
                  expect(actualFix.fixes.map((fix) => fix.change.message).toList(), [expectedFixMessage],
                      reason: 'fix message should match');

                  final sourceBeforeFixes = source.contents.data;
                  try {
                    final fixedSource = testBase.applyErrorFixes(actualFix, source);

                    // The source is indented differently, so we'll format before comparing instead to get better
                    // failure messages if they don't match (equalsIgnoringWhitespace has pretty hard to read messages).
                    final formatter = DartFormatter();
                    String tryFormat(String source, String sourceName) {
                      try {
                        return formatter.format(source);
                      } on FormatterException catch (e) {
                        fail('Failure formatting source "$sourceName": $e. Source:\n$source');
                      }
                    }

                    final expectedOutputWithoutPreamble = tryFormat(expectedOutput, 'expected output');
                    final actualOutputWithoutPreamble =
                        tryFormat(fixedSource.contents.data.replaceFirst(preamble, ''), 'actual output');

                    expect(actualOutputWithoutPreamble, expectedOutputWithoutPreamble,
                        reason: 'applying fixes should match expected output');
                  } finally {
                    // When fixes are applied, they get written to the source file.
                    // This means that later iterations in the loop will have unexpected changes, and also their
                    // fixes won't always end up in the right places since their offsets are stale.
                    // Revert the changes to the file so that other iterations can test their fixes without interference.
                    testBase.modifyFile(p.normalize(source.uri.toFilePath()), sourceBeforeFixes);
                  }
                }
              }
            });
          });
        });
      });
    });

    group('internal utilities', () {
      group(
          'getReactiveHookCallbackIndex (and by extension, getNodeWithoutReactNamespace)'
          ' works as expected when the hook being called uses', () {
        test('a non-namespaced over_react import', () async {
          final unit = (await parseAndGetResolvedUnit(r'''
            import 'package:over_react/over_react.dart';
            test() {
              useEffect(() {}, []);
            }
          ''')).unit;
          final invocations =
              allDescendantsOfType<ExpressionStatement>(unit).map((s) => s.expression as InvocationExpression).toList();
          expect(invocations, hasLength(1));

          expect(invocations.map((i) => getReactiveHookCallbackIndex(i.function)).toList(), [
            isNot(-1),
          ]);
        });

        test('a namespaced over_react import', () async {
          final unit = (await parseAndGetResolvedUnit(r'''
            import 'package:over_react/over_react.dart' as foo;
            test() {
              foo.useEffect(() {}, []);
              // Force this to be a FunctionExpressionInvocation
              (foo.useEffect)(() {}, []);
            }
          ''')).unit;
          final invocations =
              allDescendantsOfType<ExpressionStatement>(unit).map((s) => s.expression as InvocationExpression).toList();
          expect(invocations, hasLength(2));

          expect(invocations.map((i) => getReactiveHookCallbackIndex(i.function)).toList(), [
            isNot(-1),
            isNot(-1),
          ]);
        });

        test('an unresolved namespaced import', () async {
          final unit = (await parseAndGetResolvedUnit(r'''
            test() {
              // ignore: undefined_identifier
              foo.useEffect(() {}, []);
              // Force this to be a FunctionExpressionInvocation
              // ignore: undefined_identifier
              (foo.useEffect)(() {}, []);
            }
          ''')).unit;
          final invocations =
              allDescendantsOfType<ExpressionStatement>(unit).map((s) => s.expression as InvocationExpression).toList();
          expect(invocations, hasLength(2));

          expect(invocations.map((i) => getReactiveHookCallbackIndex(i.function)).toList(), [
            isNot(-1),
            isNot(-1),
          ]);
        });
      });
    });
  });
}

class TestCase {
  final Map<dynamic, dynamic> _testCaseJson;

  TestCase.fromJson(this._testCaseJson);

  String? get name => _testCaseJson['name'] as String?;

  String get code => _testCaseJson['code'] as String;

  List<Map> get errors => (_testCaseJson['errors'] as List).cast();

  List<Map>? get options => (_testCaseJson['options'] as List?)?.cast();
}

@reflectiveTest
class HooksExhaustiveDepsDiagnosticTest extends DiagnosticTestBase {
  @override
  final String? analysisOptionsYamlContents;

  HooksExhaustiveDepsDiagnosticTest({this.analysisOptionsYamlContents});

  @override
  get errorUnderTest => ExhaustiveDeps.code;

  @override
  get fixKindUnderTest => ExhaustiveDeps.fixKind;
}
