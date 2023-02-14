// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
// @dart=2.9
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/boilerplate_validator.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  // These tests can't run until this diagnostic is re-enabled in the plugin.
  // defineReflectiveSuite(() {
  //   defineReflectiveTests(BoilerplateValidatorDiagnosticTestFalsePositives);
  //   defineReflectiveTests(BoilerplateValidatorDiagnosticTestMissingGeneratedPart);
  //   defineReflectiveTests(BoilerplateValidatorDiagnosticTestUnnecessaryGeneratedPart);
  //   defineReflectiveTests(BoilerplateValidatorDiagnosticTestInvalidGeneratedPartName);
  // });
}

@reflectiveTest
class BoilerplateValidatorDiagnosticTestFalsePositives extends BoilerplateValidatorDiagnosticTest {
  @override
  get errorUnderTest => BoilerplateValidatorDiagnostic.errorCode;

  static const source = /*language=dart*/ '''
import 'package:over_react/over_react.dart';

// This should not be linted as "an .over_react.g.dart" part is required.
mixin SomeMixin on UiStatefulComponent2<UiProps, UiState> {}

// This should not be linted as "an .over_react.g.dart" part is required.
abstract class SomeAbstractComponent<T extends UiProps> extends UiComponent2<T> {}

// This should not be linted as "an .over_react.g.dart" part is required.
// ignore: deprecated_member_use_from_same_package
abstract class LegacyAbstractComponent<T extends UiProps> extends UiComponent<T> {}
''';

  Future<void> test_noErrors() async {
    final _source = newSource('test.dart', source);
    expect(await getAllErrors(_source), isEmpty);
  }
}

@reflectiveTest
class BoilerplateValidatorDiagnosticTestMissingGeneratedPart extends BoilerplateValidatorDiagnosticTest {
  @override
  get errorUnderTest => BoilerplateValidatorDiagnostic.errorCode;

  @override
  get fixKindUnderTest => BoilerplateValidatorDiagnostic.missingGeneratedPartFixKind;

  static const source = /*language=dart*/ '''
import 'package:over_react/over_react.dart';

${BoilerplateValidatorDiagnosticTest.boilerplateThatRequiresGeneratedPart}
''';

  Future<void> test_error() async {
    final _source = newSource('test.dart', source);
    final allErrors = await getAllErrors(_source);
    expect(
      allErrors,
      allOf(
        everyElement(isAnErrorUnderTest(hasFix: true)),
        contains(isAnErrorUnderTest(locatedAt: createSelection(_source, "UiFactory<FooProps> #Foo# ="), hasFix: true)),
      ),
    );
  }

  Future<void> test_errorFix() async {
    var _source = newSource('test.dart', source);
    final selection = createSelection(_source, "UiFactory<FooProps> #Foo# =");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

${BoilerplateValidatorDiagnosticTest.boilerplateThatRequiresGeneratedPart}
''');
  }
}

@reflectiveTest
class BoilerplateValidatorDiagnosticTestUnnecessaryGeneratedPart extends BoilerplateValidatorDiagnosticTest {
  @override
  get errorUnderTest => BoilerplateValidatorDiagnostic.errorCode;

  @override
  get fixKindUnderTest => BoilerplateValidatorDiagnostic.unnecessaryGeneratedPartFixKind;

  static const source = /*language=dart*/ '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';
''';

  Future<void> test_error() async {
    final _source = newSource('test.dart', source);
    final allErrors = await getAllErrors(_source);
    expect(
      allErrors,
      allOf(
        everyElement(isAnErrorUnderTest(hasFix: true)),
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(locatedAt: createSelection(_source, "#part 'test.over_react.g.dart';#"), hasFix: true),
        ]),
      ),
    );
  }

  Future<void> test_errorFix() async {
    var _source = newSource('test.dart', source);
    final selection = createSelection(_source, "#part 'test.over_react.g.dart';#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';


''');
  }
}

@reflectiveTest
class BoilerplateValidatorDiagnosticTestInvalidGeneratedPartName extends BoilerplateValidatorDiagnosticTest {
  @override
  get errorUnderTest => BoilerplateValidatorDiagnostic.errorCode;

  @override
  get fixKindUnderTest => BoilerplateValidatorDiagnostic.invalidGeneratedPartFixKind;

  static const source = /*language=dart*/ '''
import 'package:over_react/over_react.dart';

part 'invalid_generated_part_filename.over_react.g.dart';

${BoilerplateValidatorDiagnosticTest.boilerplateThatRequiresGeneratedPart}
''';

  Future<void> test_error() async {
    final _source = newSource('test.dart', source);
    final allErrors = await getAllErrors(_source);
    expect(
      allErrors,
      allOf(
        everyElement(isAnErrorUnderTest(hasFix: true)),
        contains(
          isAnErrorUnderTest(
              locatedAt: createSelection(_source, "#part 'invalid_generated_part_filename.over_react.g.dart';#"),
              hasFix: true),
        ),
      ),
    );
  }

  Future<void> test_errorFix() async {
    var _source = newSource('test.dart', source);
    final selection = createSelection(_source, "#part 'invalid_generated_part_filename.over_react.g.dart';#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';

part 'test.over_react.g.dart';

${BoilerplateValidatorDiagnosticTest.boilerplateThatRequiresGeneratedPart}
''');
  }
}

abstract class BoilerplateValidatorDiagnosticTest extends DiagnosticTestBase {
  @override
  get fixKindUnderTest => null;

  static const boilerplateThatRequiresGeneratedPart = /*language=dart*/ r'''
UiFactory<FooProps> Foo =
    // ignore: undefined_identifier
    castUiFactory(_$Foo);

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {}
}
''';
}
