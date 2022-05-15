// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/arrow_function_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ArrowFunctionPropCascadeDiagnosticTest);
  });
}

@reflectiveTest
class ArrowFunctionPropCascadeDiagnosticTest extends DiagnosticTestBase {
  @override
  get errorUnderTest => ArrowFunctionPropCascadeDiagnostic.code;

  @override
  get fixKindUnderTest => ArrowFunctionPropCascadeDiagnostic.fixKind;

  static String simpleSource = /*language=dart*/ '''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = (_) => 'click'
  ..key = 'foo'
)('hello');
''';

  Future<void> test_noError() async {
    final source = newSource('test.dart', 'var foo = true;');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorLastInCascade() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
      import 'package:over_react/over_react.dart';
      
      var foo = (Dom.div()
        ..onClick = (_) => 'click'
      )('hello');
    ''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorLastInCascadeWithDescendantCascade() async {
    final source = newSource('test.dart', /*language=dart*/ r'''
      import 'package:over_react/over_react.dart';
      
      var foo = (Dom.div()
        ..onClick = (_) => setState(newState()..foo = 'bar')
      )('hello');
    ''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorForSelection() async {
    final source = newSource('test.dart', simpleSource);
    final selection = createSelection(source, '#var foo#');
    await expectNoErrorFix(selection);
  }

  Future<void> test_producesErrorForAllSelectionTypes() => expectAllSelectionsProduceAtLeastOneError(simpleSource, [
        "##(_) => 'click'", // empty selection at beginning
        "(_) => 'click'##", // empty selection at end
        "(_) =>## 'click'", // empty selection within
        "#(_) => 'click'#", // range starting at beginning
        "#(_) => 'click'\n#", // range extending beyond end
        "(_) #=> 'cl#ick'", // range within
      ]);

  Future<void> test_errorFix() async {
    var source = newSource('test.dart', simpleSource);
    final selection = createSelection(source, "#(_) => 'click'#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, r'''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = ((_) => 'click')
  ..key = 'foo'
)('hello');
''');
  }

  Future<void> test_multipleErrors() async {
    final source = newSource('test.dart', '''
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..onClick = (_) => null..key = 'foo')('');
var bar = (Dom.div()..onSubmit = (_) => null..key = 'bar')('');
''');

    final allErrors = await getAllErrors(source);

    final errorSelections = [
      createSelection(source, 'onClick = #(_) => null#'),
      createSelection(source, 'onSubmit = #(_) => null#'),
    ];
    for (final selection in errorSelections) {
      expect(allErrors, contains(isAnErrorUnderTest(locatedAt: selection, hasFix: true)));
    }
  }
}
