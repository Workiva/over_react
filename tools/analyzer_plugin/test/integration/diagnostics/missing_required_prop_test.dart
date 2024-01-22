// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../matchers.dart';
import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MissingRequiredPropTest_NoErrors);
    defineReflectiveTests(MissingRequiredPropTest_MissingLateRequired);
    defineReflectiveTests(MissingRequiredPropTest_MissingAnnotationRequired);
  });
}

abstract class MissingRequiredPropTest extends DiagnosticTestBase {
  @override
  get fixKindUnderTest => null;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

part '{{FILE_BASENAME_WITHOUT_EXTENSION}}.over_react.g.dart';

// ignore_for_file: unused_local_variable

UiFactory<UiProps> GenericFactory = uiFunction((_) {}, UiFactoryConfig());

UiFactory<NoRequiredProps> NoRequired = uiFunction((_) {}, _$NoRequiredConfig);
mixin NoRequiredProps on UiProps {
  String? optional1;
  String? optional2;
}


UiFactory<WithLateRequiredProps> WithLateRequired = uiFunction((_) {}, _$WithLateRequiredConfig);
mixin WithLateRequiredProps on UiProps {
  late String required1;
  late String? required2;
  String? optional1;
  String? optional2;
}


UiFactory<InheritsLateRequiredProps> InheritsLateRequired = uiFunction((_) {}, _$InheritsLateRequiredConfig);
mixin InheritsLateRequiredPropsMixin on UiProps {
  late String requiredInSubclass;
}
class InheritsLateRequiredProps = UiProps with WithLateRequiredProps, InheritsLateRequiredPropsMixin;


UiFactory<RequiredWithSameNameAsPrefixedProps> RequiredWithSameNameAsPrefixed = uiFunction((_) {}, _$RequiredWithSameNameAsPrefixedConfig);
mixin RequiredWithSameNameAsPrefixedProps on UiProps {
  late bool hidden;
}


UiFactory<DisableValidationProps> DisableValidation = uiFunction((_) {}, _$DisableValidationConfig);
mixin DisableValidationProps on UiProps {
  @disableRequiredPropValidation
  late String requiredPropWithDisabledValidation;
}


UiFactory<IgnoresSomeRequiredProps> IgnoresSomeRequired = uiFunction((_) {}, _$IgnoresSomeRequiredConfig);
mixin IgnoresSomeRequiredPropsMixin on UiProps {
  late String requiredInSubclass1;
  late String requiredInSubclass2;
}
@Props(ignoreRequiredProps: {'required1', 'requiredInSubclass1'})
class IgnoresSomeRequiredProps = UiProps with WithLateRequiredProps, IgnoresSomeRequiredPropsMixin;


UiFactory<WithAnnotationRequiredProps> WithAnnotationRequired = uiFunction((_) {}, _$WithAnnotationRequiredConfig);
mixin WithAnnotationRequiredProps on UiProps {
  @requiredProp String? required1;
  @requiredProp String? required2;
  String? optional1;
  String? optional2;
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
        final incompleteBuilder = WithLateRequired()..optional1 = '1';
        
        final incompleteBuilderInvokedLater = WithLateRequired()..optional1 = '1';
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
}

@reflectiveTest
class MissingRequiredPropTest_MissingLateRequired extends MissingRequiredPropTest {
  @override
  get errorUnderTest => MissingRequiredPropDiagnostic.lateRequiredCode;

  @override
  get fixKindUnderTest => MissingRequiredPropDiagnostic.fixKind;

  Future<void> test_singleMissingAndFix() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (WithLateRequired()
          ..optional1 = '1'
          ..required1 = '1'
        )();
    ''');
    final selection = createSelection(source, '#WithLateRequired()#');
    final error = await expectSingleErrorAt(selection, hasFix: true);
    expect(error.message, "Missing required late prop 'required2' from 'WithLateRequiredProps'.");

    final errorFix = await expectSingleErrorFix(selection);
    expect(errorFix.fixes.single.change.message, "Add required prop 'required2'");
    final fixedSource = applyErrorFixes(errorFix, source);
    expect(fixedSource.contents.data, contains(/*language=dart*/ r'''
        test() => (WithLateRequired()
          ..optional1 = '1'
          ..required1 = '1'
          ..required2 = 
        )();
    '''));
  }

  Future<void> test_multipleMissing() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (WithLateRequired()..optional1 = '1')();
    ''');
    final selection = createSelection(source, '#WithLateRequired()#');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<dynamic>[
          isAnErrorUnderTest(locatedAt: selection).havingMessage(contains("'required1' from 'WithLateRequiredProps'")),
          isAnErrorUnderTest(locatedAt: selection).havingMessage(contains("'required2' from 'WithLateRequiredProps'")),
        ]));
  }

  Future<void> test_missingFromParentClass() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (InheritsLateRequired()..optional1 = '1')();
    ''');
    final selection = createSelection(source, '#InheritsLateRequired()#');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<dynamic>[
          isAnErrorUnderTest(locatedAt: selection)
              .havingMessage(contains("'requiredInSubclass' from 'InheritsLateRequiredPropsMixin'")),
          isAnErrorUnderTest(locatedAt: selection).havingMessage(contains("'required1' from 'WithLateRequiredProps'")),
          isAnErrorUnderTest(locatedAt: selection).havingMessage(contains("'required2' from 'WithLateRequiredProps'")),
        ]));
  }

  Future<void> test_missingWithSameNameAsPrefixed() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (RequiredWithSameNameAsPrefixed()..dom.hidden = true)();
    ''');
    final selection = createSelection(source, '#RequiredWithSameNameAsPrefixed()#');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<dynamic>[
          isAnErrorUnderTest(locatedAt: selection)
              .havingMessage(contains("'hidden' from 'RequiredWithSameNameAsPrefixedProps'")),
        ]));
  }

  Future<void> test_noErrorsAllRequiredPropsSpecified() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
        test() => Fragment()(
          (WithLateRequired()
            ..required1 = ''
            ..required2 = ''
          )(),
          (InheritsLateRequired()
            ..required1 = ''
            ..required2 = ''
            ..requiredInSubclass = ''
          )(),
        );
    '''));
  }

  Future<void> test_noErrorsForPropsWithDisabledValidation() async {
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => DisableValidation()();
    '''));
  }

  Future<void> test_noErrorsForIgnoredProps() async {
    // All props except for required2 and requiredInSubclass2 should be ignored
    await expectNoErrors(newSourceWithPrefix(/*language=dart*/ r'''
      test() => (IgnoresSomeRequired()
        ..required2 = ''
        ..requiredInSubclass2 = ''
      )();
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
