// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
//@dart=2.9

import 'dart:convert';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/hooks_exhaustive_deps.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';
import 'test_cases_output.dart' as tco;

void main() {
  group('HooksExhaustiveDeps', () {
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
        print('ADDITIONAL HOOKS: $additionalHooks');
        // JSON is a subset of Yaml. :)
        // Also, this way, we don't have to worry about escaping strings if we're constructing the yaml ortselves.
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

    group('test cases that should pass', () {
      tco.tests['valid'].forEachIndexed((i, element) {
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
      tco.tests['invalid'].forEachIndexed((i, element) {
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
            expect(errors.pluginErrors,
                everyElement(AnalysisErrorHavingUtils(isA<AnalysisError>()).havingCode(HooksExhaustiveDeps.code.name)),
                reason: 'Expected all errors to match the error & fix kinds under test.');

            // Replace line numbers in messages so we don't have to update them every time the preamble changes.
            String ignoreLineNumber(String message) =>
                message.replaceAll(RegExp(r'at line \d+'), 'at line {{IGNORED}}');
            final expectedMessages = expectedErrors.map((e) => e['message'] as String).map(ignoreLineNumber).toList();
            final actualMessages = errors.map((e) => e.message).map(ignoreLineNumber).toList();

            // expect(errors, unorderedEquals(expectedErrors.map((e) => isDiagnostic(HooksExhaustiveDeps.code).havingMessage(contains(e['message'] as String));
            expect(actualMessages, unorderedEquals(expectedMessages));
            //fixme(greg) suggestions

            // Run this here even though it's also in tearDown, so that we can see the source
            // when there's failures caused by this expectation.
            testBase.expectNoPluginErrors();
          } catch (_) {
            print('Raw source (before adding preamble and wrapper): ```\n$rawCode\n```');
            rethrow;
          }
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
  get fixKindUnderTest => null;
}
