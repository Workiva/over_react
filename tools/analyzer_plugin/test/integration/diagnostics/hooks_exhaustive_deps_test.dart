// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
//@dart=2.9

import 'package:collection/collection.dart';
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
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react.dart' as over_react;

part 'test.over_react.g.dart';

mixin TestProps on UiProps {
  var foo;
  var bar;
  List items;
}

// Globals used by test cases
TestProps props;
int setInterval(Function, int duration) => 0;
void clearInterval(int id) {}
dynamic someFunc() => null;
''';

    String wrapInFunction(String code) => 'void __testCaseWrapperFunction() {\n\n$code\n\n}';

    group('test cases that should pass', () {
      final tests = tco.tests['tests'].cast<String, List<dynamic>>();
      final valid = tests['valid'].cast<Map<dynamic, dynamic>>();
      valid.forEachIndexed((i, element) {
        test('valid[$i]', () async {
          // Need to wrap in a function because some of the code includes statements that aren't valid
          // outside of a function context.
          final code = preamble + wrapInFunction(element['code'] as String);
          try {
            final source = testBase.newSource('test.dart', code);
            await testBase.expectNoErrors(source);
          } catch(_) {
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
