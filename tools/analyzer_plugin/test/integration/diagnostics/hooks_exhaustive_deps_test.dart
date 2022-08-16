// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
//@dart=2.9

import 'dart:convert';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:over_react_analyzer_plugin/src/diagnostic/hooks_exhaustive_deps.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';
import '../test_bases/server_plugin_contributor_test_base.dart';
import 'test_cases_output.dart' as tco;

void main() {
  group('HooksExhaustiveDeps', () {
    // TODO(greg) inline some of these globals to avoid potential shadowing / bad references and to clean things ups
    const preamble = r'''
// ignore_for_file: unused_import
    
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react.dart' as over_react;

part 'test.over_react.g.dart';

// window isn't defined in MockSdk's dart:html
dynamic window;
dynamic jsonEncode;

mixin TestProps on UiProps {
  // FIXME do we need to make these non-dynamic?
  var foo;
  var bar;
  var baz;
  var history;
  var innerRef;
  List items;
  num delay;
  Function myEffect;
  num upperViewHeight;
  var local;
  var activeTab;
  var maybeRef2;
  var prop;
  Function fn1;
  Function fn2;
  var hello;
  var attribute;
  Function function;
  Ref<dynamic> someOtherRefs;
  var color;
  var initY;
  Function onPlay;
  Function onPause;
  bool isEditMode;
  Function toggleEditMode;
  Function fetchPodcasts;
  Function fetchPodcasts2;
  var country;
  var prop1;
  var prop2;
  var section_components;
  int step;
  var increment;
  UiFactory Component;
}

// Globals used by test cases
TestProps props;
var global;
var arguments;
var foo;
var fetch;
var globalIncrementValue;
var maybeRef1;
int setInterval(Function callback, [int duration]) => 0;
void clearInterval(int id) {}
int setTimeout(Function callback, [int duration]) => 0;
void clearTimeout(int id) {}
dynamic someFunc() => null;
Function debounce(Function callback, num delay) => null;
num delay;
dynamic renderHelperConfusedWithEffect(Function callback, dynamic secondArg) => null;
void useCustomEffect(Function callback, [List dependencies]) {}
void useWithoutEffectSuffix(Function callback, [List dependencies]) {}
T increment<T extends num>(T value) => value + 1;

abstract class UseTransitionHook {
  bool get isPending;
  Function get startTransition;
}
UseTransitionHook useTransition() => null;

abstract class Store {
  static Function subscribe(Function listener) => null;
}
abstract class MutableStore {
  static dynamic get hello => null;
}
abstract class API {
  static dynamic fetchPodcasts() => null;
}
StateHook<T> useFunnyState<T>(T initialState) {}
ReducerHook<T, dynamic, dynamic> useFunnyReducer<T>(dynamic reducer, T initialState) {}
dynamic useSomeOtherRefyThing() => null;
String computeCacheKey(dynamic object) => null;
class SomeObject {
  final int id;
  SomeObject({this.id});
}
void useLayoutEffect_SAFE_FOR_SSR(dynamic Function() callback, [List<dynamic> dependencies]) {}
Future<dynamic> fetchDataFuture;
dynamic useCustomHook() => null;
void externalCall(dynamic arg) {}
''';

    String wrapInFunction(String code) => 'void __testCaseWrapperFunction() {\n\n$code\n\n}';

    bool errorFilter(AnalysisError error, {@required bool isFromPlugin}) =>
        defaultErrorFilter(error, isFromPlugin: isFromPlugin) &&
        // These are intentionally undefined references
        !(error.code == 'undefined_identifier' && error.message.contains("Undefined name 'unresolved'."));

    Future<HooksExhaustiveDepsDiagnosticTest> setUpTestBase(TestCase testCase) async {
      final additionalHooks = testCase.options
          ?.where((option) => option.containsKey('additionalHooks'))
          ?.map((option) => option['additionalHooks'] as String)
          ?.firstOrNull;

      String analysisYaml;
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
      'tests': tco.tests,
      'testsFlow': tco.testsFlow,
      'testsTypescript': tco.testsTypescript,
      'testsTypescriptEslintParserV4': tco.testsTypescriptEslintParserV4,
    }).forEach((suiteName, suite) {
      group('$suiteName:', () {
        group('test cases that should pass', () {
          suite['valid'].forEachIndexed((i, element) {
            test('valid[$i]', () async {
              final testCase = TestCase.fromJson(element);

              final testBase = await setUpTestBase(testCase);

              // Need to wrap in a function because some of the code includes statements that aren't valid
              // outside of a function context.
              final rawCode = testCase.code;
              final code = preamble + wrapInFunction(rawCode);
              try {
                final source = testBase.newSource('test.dart', code);
                await testBase.expectNoErrors(source, errorFilter: errorFilter);
                // Run this here even though it's also in tearDown, so that we can see the source
                // when there's failures caused by this expectation.
                testBase.expectNoPluginErrors();
              } catch (_) {
                print('Raw source (before adding preamble and wrapper): ```\n$rawCode\n```');
                rethrow;
              }
            });
          });
        });

        //fixme add regression test for this case: useEffect(() {state.set(1);state.value;}, [])

        group('test cases that should warn', () {
          suite['invalid'].forEachIndexed((i, element) {
            test('invalid[$i]', () async {
              final testCase = TestCase.fromJson(element);

              final testBase = await setUpTestBase(testCase);

              // Need to wrap in a function because some of the code includes statements that aren't valid
              // outside of a function context.
              final rawCode = testCase.code;
              final code = preamble + wrapInFunction(rawCode);

              final expectedErrors = testCase.errors;
              expect(expectedErrors, isNotEmpty);

              try {
                final source = testBase.newSource('test.dart', code);
                final errors = await testBase.getAllErrors(source, includeOtherCodes: true, errorFilter: errorFilter);
                expect(errors.dartErrors, isEmpty,
                    reason: 'Expected there to be no errors coming from the analyzer and not the plugin.'
                        ' Ensure your test source is free of unintentional errors, such as syntax errors and missing imports.'
                        ' If errors are expected, set includeOtherErrorCodes:true.');
                expect(
                    errors.pluginErrors,
                    everyElement(
                        AnalysisErrorHavingUtils(isA<AnalysisError>()).havingCode(HooksExhaustiveDeps.code.name)),
                    reason: 'Expected all errors to match the error & fix kinds under test.');

                final expectedErrorIndexByActualErrorIndex = <int, int>{};

                {
                  // Replace line numbers in messages so we don't have to update them every time the preamble changes.
                  String ignoreLineNumber(String message) =>
                      message.replaceAll(RegExp(r'at line \d+'), 'at line {{IGNORED}}');
                  final expectedMessages =
                      expectedErrors.map((e) => e['message'] as String).map(ignoreLineNumber).toList();
                  final actualMessages = errors.map((e) => e.message).map(ignoreLineNumber).toList();

                  // expect(errors, unorderedEquals(expectedErrors.map((e) => isDiagnostic(HooksExhaustiveDeps.code).havingMessage(contains(e['message'] as String));
                  expect(actualMessages, unorderedEquals(expectedMessages));

                  expectedMessages.forEachIndexed((expectedIndex, expectedMessage) {
                    final actualIndex = actualMessages.indexOf(expectedMessage);
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
                  final expectedError = expectedErrors[expectedErrorIndexByActualErrorIndex[i]];

                  final expectedFixes = (expectedError['suggestions'] as List ?? <dynamic>[]).cast<Map>();

                  final actualFixesForError = (await testBase.getAllErrorFixesAtSelection(
                          SourceSelection(source, actualError.location.offset, actualError.location.length)))
                      // Some cases have multiple errors on the same selection, each potentially having their own fix.
                      // Sometimes, the codes are the same, too, so we'll ise the message to disambiguate.
                      .where((f) => f.error.code == actualError.code && f.error.message == actualError.message)
                      .toList();

                  if (expectedFixes.isEmpty) {
                    expect(actualError.hasFix, isFalse, reason: 'was not expecting the error to report it has a fix');
                    expect(actualFixesForError, isEmpty, reason: 'was not expecting fixes');
                  } else {
                    expect(actualError.hasFix, isTrue,
                        reason: 'error should report it has a fix. Expected fixes: $expectedFixes');
                    expect(actualFixesForError, isNotEmpty,
                        reason: 'was expecting fixes but got none. Expected fixes: $expectedFixes');
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

                      final expectedOutputWithoutPreamble =
                          tryFormat(wrapInFunction(expectedOutput), 'expected output');
                      final actualOutputWithoutPreamble =
                          tryFormat(fixedSource.contents.data.replaceFirst(preamble, ''), 'actual output');

                      expect(actualOutputWithoutPreamble, expectedOutputWithoutPreamble,
                          reason: 'applying fixes should match expected output');
                    } finally {
                      // When fixes are applied, they get written to the source file.
                      // This means that later iterations in the loop will have unexpected changes, and also their
                      // fixes won't always end up in the right places since their offsets are stale.
                      // Revert the changes to the file so that other iterations can test their fixes without interference.
                      testBase.resourceProvider.updateFile(p.normalize(source.uri.toFilePath()), sourceBeforeFixes);
                    }
                  }
                }

                // Run this here even though it's also in tearDown, so that we can see the source
                // when there's failures caused by this expectation.
                testBase.expectNoPluginErrors();
              } catch (_) {
                print('Raw source (before adding preamble and wrapper): ```\n$rawCode\n```');
                rethrow;
              }
            });
          });
        });
      });
    });

    test('use of state.value without it in the dependency list', () async {
      final testBase = HooksExhaustiveDepsDiagnosticTest();
      await testBase.setUp();
      addTearDown(testBase.tearDown);

      final source = testBase.newSource(
          'test.dart',
          preamble + /*language=dart*/ r'''
        final Foo = uiFunction((props) {
          final count = useState();
          final otherValue = props.id;
          useEffect(() {
            print(otherValue);
            print(count.value);
          }, [otherValue]);
        }, null);
      ''');
      final selection = testBase.createSelection(source, ', #[otherValue]#);');
      await testBase.expectSingleErrorAt(selection, hasFix: true);
    });
  });
}

class TestCase {
  final Map<dynamic, dynamic> _testCaseJson;

  TestCase.fromJson(this._testCaseJson);

  String get code => _testCaseJson['code'] as String;

  List<Map> get errors => (_testCaseJson['errors'] as List).cast();

  List<Map> get options => (_testCaseJson['options'] as List)?.cast();
}

@reflectiveTest
class HooksExhaustiveDepsDiagnosticTest extends DiagnosticTestBase {
  @override
  final String analysisOptionsYamlContents;

  HooksExhaustiveDepsDiagnosticTest({this.analysisOptionsYamlContents});

  @override
  get errorUnderTest => HooksExhaustiveDeps.code;

  @override
  get fixKindUnderTest => HooksExhaustiveDeps.fixKind;
}
