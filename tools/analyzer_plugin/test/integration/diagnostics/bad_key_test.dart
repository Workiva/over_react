// @dart=2.9
// ignore_for_file: camel_case_types
import 'dart:async';

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
  @override
  get fixKindUnderTest => null;

  Source newSourceWithPrefix(String sourceFragment) => newSource('test.dart', sourcePrefix + sourceFragment);

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
  get errorUnderTest => null;

  Future<void> test_noErrors() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
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
    final source = newSourceWithPrefix(/*language=dart*/ r'''
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
  get errorUnderTest => BadKeyDiagnostic.lowQualityCode;

  Future<void> test_bool() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (Dom.div()..key = false)();
    ''');
    final selection = createSelection(source, '= #false#');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'bool.toString()'"));
  }

  Future<void> test_Null() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = null)();''');
    final selection = createSelection(source, '= #null#');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'Null.toString()'"));
  }
}

@reflectiveTest
class BadKeyDiagnosticTest_ToString extends BadKeyDiagnosticTest {
  @override
  get errorUnderTest => BadKeyDiagnostic.toStringCode;

  Future<void> test_rawObjecct() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = modelVar)();''');
    final selection = createSelection(source, '= #modelVar#)');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_explicitToString() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = modelVar.toString())();''');
    final selection = createSelection(source, '= #modelVar#.toString())');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_explicitToStringNested() async {
    final source = newSourceWithPrefix(/*language=dart*/
        r'''test() => (Dom.div()..key = deriveKeyFrom(modelVar.toString()))();''');
    final selection = createSelection(source, '= deriveKeyFrom(#modelVar#.toString())');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_interpolated() async {
    final source = newSourceWithPrefix(/*language=dart*/
        r'''test() => (Dom.div()..key = 'interpolated $modelVar')();''');
    final selection = createSelection(source, r"= 'interpolated $#modelVar#')");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()'"));
  }

  Future<void> test_inMap() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = {'foo': modelVar})();''');
    final selection = createSelection(source, r"= #{'foo': modelVar}#");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()' (from Map<String, MyModel>)"));
  }

  Future<void> test_inList() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = [modelVar])();''');
    final selection = createSelection(source, r"= #[modelVar]#");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'MyModel.toString()' (from List<MyModel>)"));
  }
}

@reflectiveTest
class BadKeyDiagnosticTest_UnknownKeyType extends BadKeyDiagnosticTest {
  @override
  get errorUnderTest => BadKeyDiagnostic.dynamicOrObjectCode;

  Future<void> test_object() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = objectVar)();''');
    final selection = createSelection(source, '= #objectVar#');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'Object.toString()'"));
  }

  Future<void> test_object2() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''
        test() => (Dom.div()..key = objectVar)();
    ''');
    final selection = createSelection(source, '= #objectVar#');
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'Object.toString()'"));
  }

  Future<void> test_dynamic() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = dynamicVar)();''');
    final selection = createSelection(source, r"= #dynamicVar#");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'dynamic.toString()'"));
  }

  Future<void> test_inMap() async {
    final source = newSourceWithPrefix(/*language=dart*/
        r'''test() => (Dom.div()..key = {'foo': modelVar, 'bar': 1})();''');
    final selection = createSelection(source, r"= #{'foo': modelVar, 'bar': 1}#");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'Object.toString()' (from Map<String, Object>)"));
  }

  Future<void> test_inList() async {
    final source = newSourceWithPrefix(/*language=dart*/ r'''test() => (Dom.div()..key = [dynamicVar])();''');
    final selection = createSelection(source, r"= #[dynamicVar]#");
    final error = await expectSingleErrorAt(selection);
    expect(error.message, contains("'dynamic.toString()' (from List<dynamic>)"));
  }
}
