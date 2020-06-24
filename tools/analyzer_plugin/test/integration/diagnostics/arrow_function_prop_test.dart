import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/arrow_function_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ArrowFunctionPropCascadeDiagnosticTest);
  });
}

@reflectiveTest
class ArrowFunctionPropCascadeDiagnosticTest extends DiagnosticTestBase {
  static DiagnosticCode get diagnosticCode =>
      ArrowFunctionPropCascadeDiagnostic.code;

  static FixKind get fixKind => ArrowFunctionPropCascadeDiagnostic.fixKind;

  static String simpleSource = r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = (_) => 'arrow fn'
)('hello');
''';

  @override
  DiagnosticContributor getContributorUnderTest() =>
      ArrowFunctionPropCascadeDiagnostic();

  Future<void> test_producesError() async {
    final source = newSource('test.dart', simpleSource);
    final selection = createSelection(source, "#(_) => 'arrow fn'#");
    final errorsWithFixes = await getErrorsWithFixes(selection);
    expect(errorsWithFixes, hasLength(1));

    final error = errorsWithFixes.first.error;
    expect(
        error,
        isAnalysisErrorForDiagnostic(diagnosticCode,
            atSelection: selection, hasFix: true));
  }

  Future<void> test_errorFixMeta() async {
    final source = newSource('test.dart', simpleSource);
    final selection = createSelection(source, "#(_) => 'arrow fn'#");
    final errorsWithFixes = await getErrorsWithFixes(selection);
    expect(errorsWithFixes, hasLength(1));
    expect(errorsWithFixes.first.fixes, hasLength(1));

    final prioritizedChange = errorsWithFixes.first.fixes.first;
    expect(prioritizedChange.priority, fixKind.priority);
    expect(prioritizedChange.change.message, fixKind.message);
  }

  Future<void> test_errorFixApplication() async {
    var source = newSource('test.dart', simpleSource);
    var selection = createSelection(source, "#(_) => 'arrow fn'#");
    final errorsWithFixes = await getErrorsWithFixes(selection);
    expect(errorsWithFixes, hasLength(1));
    expect(errorsWithFixes.first.fixes, hasLength(1));

    final change = errorsWithFixes.first.fixes.first.change;
    source = applySourceChange(change, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = ((_) => 'arrow fn')
)('hello');
''');
    expect(change.selection, isNull);
  }
}
