// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
//@dart=2.9

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/hooks_exhaustive_deps.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';
import 'test_cases_output.dart' as tco;

void main() {
  group('HooksExhaustiveDeps', () {
    HooksExhaustiveDepsDiagnosticTest testBase;
    setUpAll(() => testBase = HooksExhaustiveDepsDiagnosticTest());
    setUp(() => testBase.setUp());
    tearDown(() => testBase.tearDown());

    const preamble = r'''
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
''';

    String wrapInFunction(String code) => 'void __testCaseWrapperFunction() {\n\n$code\n\n}';

    bool errorFilter(AnalysisError error, {@required bool isFromPlugin, bool ignoreRulesOfHooks = false}) =>
        defaultErrorFilter(error, isFromPlugin: isFromPlugin) &&
        !{
          'unused_import',
        }.contains(error.code) &&
        // These are intentionally undefined references
        !(error.code == 'undefined_identifier' && error.message.contains("Undefined name 'unresolved'.")) &&
        !(ignoreRulesOfHooks && error.code == 'over_react_rules_of_hooks');

    group('test cases that should pass', () {
      final tests = tco.tests['tests'].cast<String, List<dynamic>>();
      final valid = tests['valid'].cast<Map<dynamic, dynamic>>();
      valid.forEachIndexed((i, element) {
        test('valid[$i]', () async {
          // Need to wrap in a function because some of the code includes statements that aren't valid
          // outside of a function context.
          final code = preamble + wrapInFunction(element['code'] as String);
          final ignoreRulesOfHooks = element['isOutsideOfFunctionComponentOrHook'] as bool ?? false;
          try {
            final source = testBase.newSource('test.dart', code);
            await testBase.expectNoErrors(source,
                errorFilter: (error, {@required isFromPlugin}) =>
                    errorFilter(error, isFromPlugin: isFromPlugin, ignoreRulesOfHooks: ignoreRulesOfHooks));
            // Run this here even though it's also in tearDown, so that we can see the source
            // when there's failures caused by this expectation.
            testBase.expectNoPluginErrors();
          } catch (_) {
            print('Source: ```\n$code\n```');
            rethrow;
          }
        });
      });
    });
  });
}

@reflectiveTest
class HooksExhaustiveDepsDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => HooksExhaustiveDeps.code;

  @override
  get fixKindUnderTest => null;
}
