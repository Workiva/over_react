// ignore_for_file: camel_case_types
// Copyright 2024 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../matchers.dart';
import '../../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MissingRequiredPropTest);
    defineReflectiveTests(MissingRequiredPropTest_MissingAnnotationRequired);
  });
}

abstract class MissingRequiredPropTestBase extends DiagnosticTestBase {
  @override
  get fixKindUnderTest => MissingRequiredPropDiagnostic.fixKind;

  Source newSourceWithPrefix(String sourceFragment) => newSource(sourcePrefix + sourceFragment);

  static const sourcePrefix = /*language=dart*/ r'''
// @dart=2.11
import 'package:over_react/over_react.dart';
// ignore: unused_import
import 'package:over_react/over_react_redux.dart';

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
class MissingRequiredPropTest extends MissingRequiredPropTestBase {
  @override
  get errorUnderTest => MissingRequiredPropDiagnostic.lateRequiredCode;

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

  Future<void> test_missingLateRequiredDeclaredInOtherLib() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => ReduxProvider()();
    ''');
    final selection = createSelection(source, '#ReduxProvider()#');
    final allErrors = await getAllErrors(source);
    expect(
        allErrors,
        unorderedEquals(<dynamic>[
          isAnErrorUnderTest(locatedAt: selection).havingMessage(contains("'store' from 'ReduxProviderPropsMixin'")),
        ]));
  }
}

@reflectiveTest
class MissingRequiredPropTest_MissingAnnotationRequired extends MissingRequiredPropTestBase {
  @override
  get errorUnderTest => MissingRequiredPropDiagnostic.annotationRequiredCode;

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
