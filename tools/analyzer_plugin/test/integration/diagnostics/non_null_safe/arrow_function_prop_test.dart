// This file is a non-null safe copy of diagnostics tests.
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/arrow_function_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_bases/diagnostic_test_base.dart';

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
// @dart=2.11
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = (_) => 'click'
  ..key = 'foo'
)('hello');
''';

  Future<void> test_noError() async {
    final source = newSource('var foo = true;');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorLastInCascade() async {
    final source = newSource(/*language=dart*/ r'''
      // @dart=2.11
      import 'package:over_react/over_react.dart';
      
      var foo = (Dom.div()
        ..onClick = (_) => 'click'
      )('hello');
    ''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorLastInCascadeWithDescendantCascade() async {
    final source = newSource(/*language=dart*/ r'''
      // @dart=2.11
      import 'package:over_react/over_react.dart';

      part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';
      
      mixin FooState on UiState {
        var foo;
      }
      
      abstract class FooComponent extends UiStatefulComponent2<UiProps, FooState> {
        @override
        render() {
          return (Dom.div()
            ..onClick = (_) => setState(newState()..foo = 'bar')
          )('hello');
        }
      }
    ''');
    expect(await getAllErrors(source), isEmpty);
  }

  Future<void> test_noErrorForSelection() async {
    final source = newSource(simpleSource);
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
    var source = newSource(simpleSource);
    final selection = createSelection(source, "#(_) => 'click'#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    source = applyErrorFixes(errorFix, source);
    expect(source.contents.data, r'''
// @dart=2.11
import 'package:over_react/over_react.dart';
var foo = (Dom.div()
  ..onClick = ((_) => 'click')
  ..key = 'foo'
)('hello');
''');
  }

  Future<void> test_multipleErrors() async {
    final source = newSource('''
// @dart=2.11
import 'package:over_react/over_react.dart';
var foo = (Dom.div()..onClick = (_) => null..key = 'foo')('');
var bar = (Dom.div()..onSubmit = (_) => null..key = 'bar')('');
''');

    final allErrors = await getAllErrors(source, includeOtherCodes: true);

    final errorSelections = [
      createSelection(source, 'onClick = #(_) => null#'),
      createSelection(source, 'onSubmit = #(_) => null#'),
    ];
    for (final selection in errorSelections) {
      expect(allErrors.pluginErrors, contains(isAnErrorUnderTest(locatedAt: selection, hasFix: true)));
    }
  }
}
