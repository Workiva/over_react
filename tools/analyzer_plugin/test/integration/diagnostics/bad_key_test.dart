// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/bad_key.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../test_bases/diagnostic_test_base.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BadKeyDiagnosticTest_NoErrors);
    defineReflectiveTests(BadKeyDiagnosticTest_LowQualityCode);
    defineReflectiveTests(BadKeyDiagnosticTest_ToString);
    defineReflectiveTests(BadKeyDiagnosticTest_UnknownKeyType);
  });
}

abstract class BadKeyDiagnosticTest extends DiagnosticTestBase {
  Source source;

  @override
  get fixKindsUnderTest => {};

  @override
  tearDown() async {
    await super.tearDown();
    source = null;
  }

  void initSource(String sourceFragment) {
    source = newSource('test.dart', sourcePrefix + sourceFragment);
  }

  Future<AnalysisError> expectError(String selection) =>
      expectAndGetSingleErrorAtSelection(createSelection(source, selection));

  static const sourcePrefix = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';

MyModel modelVar;
MyModelWithCustomToString modelVarWithCustomToString;

Object objectVar;
dynamic dynamicVar;

// ignore: missing_return
String deriveKeyFrom(Object object) {}

class MyModel {
  int id;
}

class MyModelWithCustomToString {
  int id;

  @override
  toString() => '$id';
}
''';
}

@reflectiveTest
class BadKeyDiagnosticTest_NoErrors extends BadKeyDiagnosticTest {
  @override
  get errorsUnderTest => {};

  Future<void> test_noErrors() async {
    initSource(/*language=dart*/ r'''
      test() => [
        (Dom.div()..key = 'a string')(),
        (Dom.div()..key = 122)(),
        (Dom.div()..key = modelVar.id)(),
        (Dom.div()..key = modelVarWithCustomToString)(),
        (Dom.div()..key = deriveKeyFrom(modelVar))(),
      ];
    ''');

    expect(await getAllErrors(source, includeOtherCodes: true), isEmpty);
  }

  Future<void> test_noErrorsEvenWithEdgeCases() async {
    initSource(/*language=dart*/ r'''
      void voidVar;        
      test() => [
        // Not an assignment
        (Dom.div()..key)(),
        (Dom.div()..key = 'greg')(),
        // Missing RHS
        (Dom.div()..key = )(),
        // Missing interpolated expression
        (Dom.div()..key = '${}')(),
        // Weird type 
        (Dom.div()..key = voidVar)(),
      ];
    ''');

    expect(await getAllErrors(source, includeOtherCodes: true), isEmpty);
  }
}

@reflectiveTest
class BadKeyDiagnosticTest_LowQualityCode extends BadKeyDiagnosticTest {
  @override
  get errorsUnderTest => {BadKeyDiagnostic.lowQualityCode};

  Future<void> test_bool() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = false)();''');
    final error = await expectAndGetSingleErrorAtSelection(createSelection(source, '= #false#'));
    expect(error.message, contains("'bool.toString()'"));
  }

  Future<void> test_Null() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = null)();''');
    final error = await expectAndGetSingleErrorAtSelection(createSelection(source, '= #null#'));
    expect(error.message, contains("'Null.toString()'"));
  }
}

@reflectiveTest
class BadKeyDiagnosticTest_ToString extends BadKeyDiagnosticTest {
  @override
  get errorsUnderTest => {BadKeyDiagnostic.toStringCode};

  Future<void> test_rawObjecct() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = modelVar)();''');
    final error = await expectError('= #modelVar#)');
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_explicitToString() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = modelVar.toString())();''');
    final error = await expectError('= #modelVar#.toString())');
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_explicitToStringNested() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = deriveKeyFrom(modelVar.toString()))();''');
    final error = await expectError('= deriveKeyFrom(#modelVar#.toString())');
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_interpolated() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = 'interpolated $modelVar')();''');
    final error = await expectError(r"= 'interpolated $#modelVar#')");
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_inMap() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = {'foo': modelVar})();''');
    final error = await expectError(r"= #{'foo': modelVar}#");
    expect(error.message, contains("'MyModel.toString()' (from Map<String, MyModel>)"));
  }

  Future<void> test_inList() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = [modelVar])();''');
    final error = await expectError(r"= #[modelVar]#");
    expect(error.message, contains("'MyModel.toString()' (from List<MyModel>)"));
  }
}

@reflectiveTest
class BadKeyDiagnosticTest_UnknownKeyType extends BadKeyDiagnosticTest {
  @override
  get errorsUnderTest => {BadKeyDiagnostic.dynamicOrObjectCode};

  Future<void> test_object() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = objectVar)();''');
    final error = await expectAndGetSingleErrorAtSelection(createSelection(source, '= #objectVar#'));
    expect(error.message, contains("'Object.toString()'"));
  }

  Future<void> test_dynamic() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = dynamicVar)();''');
    final error = await expectAndGetSingleErrorAtSelection(createSelection(source, r"= #dynamicVar#"));
    expect(error.message, contains("'dynamic.toString()'"));
  }

  Future<void> test_inMap() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = {'foo': modelVar, 'bar': 1})();''');
    final error = await expectAndGetSingleErrorAtSelection(createSelection(source, r"= #{'foo': modelVar, 'bar': 1}#"));
    expect(error.message, contains("'Object.toString()' (from Map<String, Object>)"));
  }

  Future<void> test_inList() async {
    initSource(/*language=dart*/ r'''test() => (Dom.div()..key = [dynamicVar])();''');
    final error = await expectError(r"= #[dynamicVar]#");
    expect(error.message, contains("'dynamic.toString()' (from List<dynamic>)"));
  }
}
