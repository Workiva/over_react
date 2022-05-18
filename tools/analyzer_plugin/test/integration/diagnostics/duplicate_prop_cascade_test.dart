// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/duplicate_prop_cascade.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DuplicatePropCascadeDiagnosticTest);
  });
}

@reflectiveTest
class DuplicatePropCascadeDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => DuplicatePropCascadeDiagnostic.code;

  @override
  get fixKindUnderTest => DuplicatePropCascadeDiagnostic.fixKind;

  Future<void> test_noError() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
part 'test.over_react.g.dart';

mixin CustomProps on UiProps {
  int size;
  bool hidden;
}

final Custom = uiFunction<CustomProps>(
  (props) {
    return null;
  },
  _$CustomConfig, // ignore: undefined_identifier
);

final customUsage = (Custom()
  ..size = 2
  ..dom.size = 2
  ..dom.hidden = false
  ..aria.hidden = false
  ..hidden = false
)();
''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_error() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
final foo = (Dom.div()
  ..id = '1'
  ..dom.id = 'foo'
  ..hidden = false
  ..aria.hidden = false
)();
''');
    final allErrors = await getAllErrors(source);
    expect(allErrors, hasLength(2));

    for (final selection in [createSelection(source, "#..id# = '1'"), createSelection(source, "#..dom.id# = 'foo'")]) {
      expect(allErrors, contains(isAnErrorUnderTest(locatedAt: selection, hasFix: true)));
    }
  }
}
