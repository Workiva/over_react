import 'dart:async';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/boilerplate_validator.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../matchers.dart';
import '../matchers.dart';
import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BoilerplateValidatorDiagnosticTestFalsePositives);
    defineReflectiveTests(BoilerplateValidatorDiagnosticTestMissingGeneratedPart);
    defineReflectiveTests(BoilerplateValidatorDiagnosticTestUnnecessaryGeneratedPart);
    defineReflectiveTests(BoilerplateValidatorDiagnosticTestInvalidGeneratedPartName);
    defineReflectiveTests(BoilerplateValidatorDiagnosticTestTypingAnnotation);
  });
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
    final _source = newSource(source);
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
    final _source = newSource(source);
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
    var _source = newSource(source);
    final basenameWithoutExtension = p.basenameWithoutExtension(_source.uri.path);
    final selection = createSelection(_source, "UiFactory<FooProps> #Foo# =");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';

part '$basenameWithoutExtension.over_react.g.dart';

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

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

codeThatDoesNotRequireBoilerplate() => Dom.div()();
''';

  Future<void> test_error() async {
    final _source = newSource(source);
    final basenameWithoutExtension = p.basenameWithoutExtension(_source.uri.path);
    final allErrors = await getAllErrors(_source);
    expect(
      allErrors,
      allOf(
        everyElement(isAnErrorUnderTest(hasFix: true)),
        unorderedEquals(<Matcher>[
          isAnErrorUnderTest(
              locatedAt: createSelection(_source, "#part '$basenameWithoutExtension.over_react.g.dart';#"),
              hasFix: true),
        ]),
      ),
    );
  }

  Future<void> test_errorFix() async {
    var _source = newSource(source);
    final basenameWithoutExtension = p.basenameWithoutExtension(_source.uri.path);
    final selection = createSelection(_source, "#part '$basenameWithoutExtension.over_react.g.dart';#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';



codeThatDoesNotRequireBoilerplate() => Dom.div()();
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
    final _source = newSource(source);
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
    var _source = newSource(source);
    final basenameWithoutExtension = p.basenameWithoutExtension(_source.uri.path);
    final selection = createSelection(_source, "#part 'invalid_generated_part_filename.over_react.g.dart';#");
    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.selection, isNull);
    _source = applyErrorFixes(errorFix, _source);
    expect(_source.contents.data, '''
import 'package:over_react/over_react.dart';

part '$basenameWithoutExtension.over_react.g.dart';

${BoilerplateValidatorDiagnosticTest.boilerplateThatRequiresGeneratedPart}
''');
  }
}
@reflectiveTest
class BoilerplateValidatorDiagnosticTestTypingAnnotation extends BoilerplateValidatorDiagnosticTest {
  @override
  get errorUnderTest => null;

  static const source = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction((_) {}, _$FooConfig);

mixin FooPropsMixin on UiProps {}

// Incomplete annotation as the user is typing it
@Props(ignoreRequiredP/*imagine the user cursor here, typing*/)
class FooProps = UiProps with FooPropsMixin;
''';

  // Regression test to make sure there are no plugin errors that bubble to the IDE
  // as a user is typing an annotation.
  Future<void> test_regressionTestIncompleteAnnotation() async {
    final _source = newSource(source);

    // Call getAllErrors to trigger analysis so we can call expectNoPluginErrors below.
    final errors = await getAllErrors(_source, includeOtherCodes: true);
    // While we have the errors, verify the test is set up correctly.
    expect(errors.dartErrors, unorderedEquals(<dynamic>[
      isA<AnalysisError>().havingCode('undefined_identifier'),
      isA<AnalysisError>().havingCode('extra_positional_arguments_could_be_named'),
      isA<AnalysisError>().havingCode('const_with_non_constant_argument'),
    ]), reason: 'should have expected Dart SDK errors from incomplete annotation');

    // Verify that there are no plugin error notifications.
    expectNoPluginErrorNotifications();
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
