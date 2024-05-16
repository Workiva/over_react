// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../matchers.dart';
import '../../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MissingRequiredPropTest_NoErrors);
    defineReflectiveTests(MissingRequiredPropTest_MissingAnnotationRequired);
  });
}

abstract class MissingRequiredPropTest extends DiagnosticTestBase {
  @override
  get fixKindUnderTest => null;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

// ignore_for_file: unused_local_variable

UiFactory<UiProps> GenericFactory = uiFunction((_) {}, UiFactoryConfig());

UiFactory<NoRequiredProps> NoRequired = uiFunction((_) {}, _$NoRequiredConfig);
mixin NoRequiredProps on UiProps {
  String optional1;
  String optional2;
}

UiFactory<InheritsLateRequiredProps> InheritsLateRequired = uiFunction((_) {}, _$InheritsLateRequiredConfig);
mixin InheritsLateRequiredPropsMixin on UiProps {
  String optional1;
}
class InheritsLateRequiredProps = UiProps with FluxUiPropsMixin, InheritsLateRequiredPropsMixin;

UiFactory<WithAnnotationRequiredProps> WithAnnotationRequired = uiFunction((_) {}, _$WithAnnotationRequiredConfig);
mixin WithAnnotationRequiredProps on UiProps {
  @requiredProp String required1;
  @requiredProp String required2;
  String optional1;
  String optional2;
}
''';
}

@reflectiveTest
class MissingRequiredPropTest_NoErrors extends MissingRequiredPropTest {
  @override
  get errorUnderTest => null;

  Future<void> test_noErrorsWhenNoRequiredProps() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => Fragment()(
        NoRequired()(),
        (NoRequired())(),
        (NoRequired()..optional1 = '1')(),
        (NoRequired()
          ..optional1 = '1'
          ..optional2 = '2'
        )(),
        (NoRequired()..id = 'id')(),
      );
    '''));
  }

  Future<void> test_noErrorsForDomComponents() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => Fragment()(
        // DomProps
        Dom.div()(),
        (Dom.div()..id = 'dom')(),
        // SvgProps
        Dom.ellipse()(),
        (Dom.ellipse()..id = 'svg')(),
      );
    '''));
  }

  Future<void> test_noErrorsForGenericUiProps() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => Fragment()(
        GenericFactory()(),
        (GenericFactory()..id = 'dom')(),
      );
    '''));
  }

  Future<void> test_noErrorsWhenIncompleteBuilder() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      testLate() {
        final incompleteBuilder = InheritsLateRequired()..optional1 = '1';
        
        final incompleteBuilderInvokedLater = InheritsLateRequired()..optional1 = '1';
        incompleteBuilderInvokedLater();
      }
      
      testAnnotation() {
        final incompleteBuilder = WithAnnotationRequired()..optional1 = '1';
        
        final incompleteBuilderInvokedLater = WithAnnotationRequired()..optional1 = '1';
        incompleteBuilderInvokedLater();
      }
    '''));
  }

  Future<void> test_noErrorsAnnotationRequiredByDefault() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => WithAnnotationRequired()();
    '''));
  }

  Future<void> test_noErrorsInheritsLateRequired() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
        test() => InheritsLateRequired()();
    '''));
  }
}

@reflectiveTest
class MissingRequiredPropTest_MissingAnnotationRequired extends MissingRequiredPropTest {
  @override
  get errorUnderTest => MissingRequiredPropDiagnostic.annotationRequiredCode;

  @override
  get fixKindUnderTest => MissingRequiredPropDiagnostic.fixKind;

  // This lint is disabled by default, so we have to opt into it.
  @override
  String get analysisOptionsYamlContents => r'''
analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_annotation_required_prop: info
  ''';

  Future<void> test_singleMissingAndFix() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (WithAnnotationRequired()
          ..optional1 = '1'
          ..required1 = '1'
        )();
    ''');
    final selection = createSelection(source, '#WithAnnotationRequired()#');
    final error = await expectSingleErrorAt(selection, hasFix: true);
    expect(error.message, "Missing @requiredProp 'required2' from 'WithAnnotationRequiredProps'.");

    final errorFix = await expectSingleErrorFix(selection);
    final fixedSource = applyErrorFixes(errorFix, source);
    expect(fixedSource.contents.data, contains(/*language=dart*/ r'''
        test() => (WithAnnotationRequired()
          ..optional1 = '1'
          ..required1 = '1'
          ..required2 = 
        )();
    '''));
  }

  Future<void> test_multipleMissing() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (WithAnnotationRequired()..optional1 = '1')();
    ''');
    final selection = createSelection(source, '#WithAnnotationRequired()#');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<dynamic>[
          isAnErrorUnderTest(locatedAt: selection)
              .havingMessage(contains("'required1' from 'WithAnnotationRequiredProps'")),
          isAnErrorUnderTest(locatedAt: selection)
              .havingMessage(contains("'required2' from 'WithAnnotationRequiredProps'")),
        ]));
  }

  Future<void> test_noErrorsAllRequiredPropsSpecified() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
        test() => (WithAnnotationRequired()
          ..required1 = ''
          ..required2 = ''
        )();
    '''));
  }
}
