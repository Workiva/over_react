// Copyright 2015 Workiva Inc.
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

// Copied from https://github.com/Workiva/dart_transformer_utils/tree/0.2.23/test/

@TestOn('vm')
library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/vendor/transformer_utils/src/analyzer_helpers.dart';
import 'package:test/test.dart';


import '../test_utils.dart';

const String classDef = '''
class TestClass {
  TestClass();

  var field = 'field';
  String typedField = 'typedField';
  static String staticField = 'typedField';

  get untypedGetter => null;
  String get typedGetter => null;
  static String get staticGetter => null;
  Future get asyncGetter async => null;

  static void set staticSetter(v) { }
  void set setter(v) { }
  void set typedSetter(String v) { }

  untypedMethod() { }
  String typedMethod() { }
  static String staticMethod() { }
  Future asyncMethod() async { }
  String methodWithArgs(String a, {int b}) { }
}
''';

void expectLines(String actual, String expected) {
  var expectedLines = expected.split('\n');
  var actualLines = actual.split('\n');
  for (var i = 0; i < expectedLines.length; i++) {
    expect(actualLines[i].trim(), expectedLines[i].trim());
  }
}

main() {
  group('copyClassMember()', () {
    test('throws on unsupported class member', () {
      var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
      var ctor = getConstructor(node);
      expect(() {
        copyClassMember(ctor, 'body');
      }, throwsUnsupportedError);
    });

    group('FieldDeclaration', () {
      test('copies an untyped field', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var field = getFieldByName(node, 'field');
        var expected = 'var field = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a typed field', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var field = getFieldByName(node, 'typedField');
        var expected = 'String typedField = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a static field', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var field = getFieldByName(node, 'staticField');
        var expected = 'static String staticField = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a field witout an initializer', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var field = getFieldByName(node, 'typedField');
        var expected = 'String typedField;';
        expect(copyClassMember(field, ''), equals(expected));
      });
    });

    group('MethodDeclaration (Getter)', () {
      test('copies untyped getter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var getter = getMethodByName(node, 'untypedGetter');
        var expected =
            ['get untypedGetter {', 'return "copy";', '}'].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies typed getter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var getter = getMethodByName(node, 'typedGetter');
        var expected =
            ['String get typedGetter {', 'return "copy";', '}'].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies static getter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var getter = getMethodByName(node, 'staticGetter');
        var expected = [
          'static String get staticGetter {',
          'return "copy";',
          '}'
        ].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies async getter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var getter = getMethodByName(node, 'asyncGetter');
        var expected = ['Future get asyncGetter async {', 'return "copy";', '}']
            .join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });
    });

    group('MethodDeclaration (Setter)', () {
      test('copies setter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var setter = getMethodByName(node, 'setter');
        var expected = ['void set setter(v) {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });

      test('copies typed setter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var setter = getMethodByName(node, 'typedSetter');
        var expected =
            ['void set typedSetter(String v) {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });

      test('copies static setter', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var setter = getMethodByName(node, 'staticSetter');
        var expected = ['static void set staticSetter(v) {', 'c = "copy";', '}']
            .join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });
    });

    group('MethodDeclaration', () {
      test('copies untyped method', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var method = getMethodByName(node, 'untypedMethod');
        var expected = ['untypedMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies typed method', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var method = getMethodByName(node, 'typedMethod');
        var expected =
            ['String typedMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies static method', () {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var method = getMethodByName(node, 'staticMethod');
        var expected =
            ['static String staticMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies async method', () async {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var method = getMethodByName(node, 'asyncMethod');
        var expected =
            ['Future asyncMethod() async {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies method with args', () async {
        var node = parseAndGetSingleMember<ClassDeclaration>(classDef);
        var method = getMethodByName(node, 'methodWithArgs');
        var expected = [
          'String methodWithArgs(String a, {int b}) {',
          'c = "copy";',
          '}'
        ].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });
    });
  });
}
