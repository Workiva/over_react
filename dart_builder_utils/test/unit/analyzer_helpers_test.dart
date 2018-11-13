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

@TestOn('vm')
library builder_utils.test.unit.analyzer_helpers_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:test/test.dart';

import 'package:builder_utils/builder_utils.dart';

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
  Future get asyncGetter => null;

  static void set staticSetter(v) { }
  void set setter(v) { }
  void set typedSetter(String v) { }

  untypedMethod() { }
  String typedMethod() { }
  static String staticMethod() { }
  Future asyncMethod() { }
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
      var node = parseAndGetSingleMember(classDef);
      var ctor = getConstructor(node);
      expect(() {
        copyClassMember(ctor, 'body');
      }, throwsUnsupportedError);
    });

    group('FieldDeclaration', () {
      test('copies an untyped field', () {
        var node = parseAndGetSingleMember(classDef);
        var field = getFieldByName(node, 'field');
        var expected = 'var field = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a typed field', () {
        var node = parseAndGetSingleMember(classDef);
        var field = getFieldByName(node, 'typedField');
        var expected = 'String typedField = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a static field', () {
        var node = parseAndGetSingleMember(classDef);
        var field = getFieldByName(node, 'staticField');
        var expected = 'static String staticField = "copy";';
        expect(copyClassMember(field, '"copy"'), equals(expected));
      });

      test('copies a field witout an initializer', () {
        var node = parseAndGetSingleMember(classDef);
        var field = getFieldByName(node, 'typedField');
        var expected = 'String typedField;';
        expect(copyClassMember(field, ''), equals(expected));
      });
    });

    group('MethodDeclaration (Getter)', () {
      test('copies untyped getter', () {
        var node = parseAndGetSingleMember(classDef);
        var getter = getMethodByName(node, 'untypedGetter');
        var expected =
            ['get untypedGetter {', 'return "copy";', '}'].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies typed getter', () {
        var node = parseAndGetSingleMember(classDef);
        var getter = getMethodByName(node, 'typedGetter');
        var expected =
            ['String get typedGetter {', 'return "copy";', '}'].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies static getter', () {
        var node = parseAndGetSingleMember(classDef);
        var getter = getMethodByName(node, 'staticGetter');
        var expected = [
          'static String get staticGetter {',
          'return "copy";',
          '}'
        ].join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });

      test('copies async getter', () {
        var node = parseAndGetSingleMember(classDef);
        var getter = getMethodByName(node, 'asyncGetter');
        var expected = ['Future get asyncGetter async {', 'return "copy";', '}']
            .join('\n');
        expectLines(copyClassMember(getter, 'return "copy";'), expected);
      });
    });

    group('MethodDeclaration (Setter)', () {
      test('copies setter', () {
        var node = parseAndGetSingleMember(classDef);
        var setter = getMethodByName(node, 'setter');
        var expected = ['void set setter(v) {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });

      test('copies typed setter', () {
        var node = parseAndGetSingleMember(classDef);
        var setter = getMethodByName(node, 'typedSetter');
        var expected =
            ['void set typedSetter(String v) {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });

      test('copies static setter', () {
        var node = parseAndGetSingleMember(classDef);
        var setter = getMethodByName(node, 'staticSetter');
        var expected = ['static void set staticSetter(v) {', 'c = "copy";', '}']
            .join('\n');
        expectLines(copyClassMember(setter, 'c = "copy";'), expected);
      });
    });

    group('MethodDeclaration', () {
      test('copies untyped method', () {
        var node = parseAndGetSingleMember(classDef);
        var method = getMethodByName(node, 'untypedMethod');
        var expected = ['untypedMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies typed method', () {
        var node = parseAndGetSingleMember(classDef);
        var method = getMethodByName(node, 'typedMethod');
        var expected =
            ['String typedMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies static method', () {
        var node = parseAndGetSingleMember(classDef);
        var method = getMethodByName(node, 'staticMethod');
        var expected =
            ['static String staticMethod() {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies async method', () async {
        var node = parseAndGetSingleMember(classDef);
        var method = getMethodByName(node, 'asyncMethod');
        var expected =
            ['Future asyncMethod() async {', 'c = "copy";', '}'].join('\n');
        expectLines(copyClassMember(method, 'c = "copy";'), expected);
      });

      test('copies method with args', () async {
        var node = parseAndGetSingleMember(classDef);
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

  group('getDeclarationsAnnotatedBy()', () {
    test('no matching declarations', () {
      var unit = parseCompilationUnit(
          ['var a;', '@OtherAnnotation()', 'var b;', 'var c;'].join('\n'));
      var matches = getDeclarationsAnnotatedBy(unit, TestAnnotation);
      expect(matches, isEmpty);
    });

    test('one matching declaration', () {
      var unit = parseCompilationUnit([
        '@TestAnnotation("test")',
        'var a;',
        '@OtherAnnotation()',
        'var b;',
        'var c;'
      ].join('\n'));
      var matches = getDeclarationsAnnotatedBy(unit, TestAnnotation);
      expect(matches.length, 1);
    });

    test('multiple matching declarations', () {
      var unit = parseCompilationUnit([
        '@TestAnnotation("test")',
        'var a;',
        '@OtherAnnotation()',
        'var b;',
        '@TestAnnotation("test")',
        'var c;'
      ].join('\n'));
      var matches = getDeclarationsAnnotatedBy(unit, TestAnnotation);
      expect(matches.length, 2);
    });
  });

  group('instantiateAnnotation()', () {
    group('instantiates an annotation with a parameter value specified as', () {
      test('a string literal', () {
        var node = parseAndGetSingleMember('@TestAnnotation("hello")\nvar a;');
        TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
        expect(instance.positional, "hello");
      });

      test('a concatenated string literal', () {
        var node = parseAndGetSingleMember('@TestAnnotation("he" "y")\nvar a;');
        TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
        expect(instance.positional, "hey");
      });

      test('a boolean literal', () {
        var node = parseAndGetSingleMember('@TestAnnotation(true)\nvar a;');
        TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
        expect(instance.positional, true);
      });

      test('an integer literal', () {
        var node = parseAndGetSingleMember('@TestAnnotation(1)\nvar a;');
        TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
        expect(instance.positional, 1);
      });

      test('a null literal', () {
        var node = parseAndGetSingleMember('@TestAnnotation(null)\nvar a;');
        TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
        expect(instance.positional, null);
      });
    });

    group('throws when an annotation parameter value is unsupported:', () {
      test('a constant expression', () {
        var node = parseAndGetSingleMember('@TestAnnotation(const [])\nvar a;');
        expect(() => instantiateAnnotation(node, TestAnnotation),
            throwsUnsupportedError);
      });

      test('an interpolated String', () {
        var node = parseAndGetSingleMember('@TestAnnotation("\$v")\nvar a;');
        expect(() => instantiateAnnotation(node, TestAnnotation),
            throwsUnsupportedError);
      });

      test('an identifier', () {
        var node =
            parseAndGetSingleMember('@TestAnnotation(identifier)\nvar a;');
        expect(() => instantiateAnnotation(node, TestAnnotation),
            throwsUnsupportedError);
      });

      group('(except when `onUnsupportedArgument` is specified)', () {
        test('positional parameter', () {
          Expression unsupportedArgument;

          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(const [])\nvar a;'),
              TestAnnotation, onUnsupportedArgument: (Expression expression) {
            unsupportedArgument = expression;
            return 'value to be passed to constructor instead';
          });

          expect(unsupportedArgument, const isInstanceOf<Expression>());
          expect(instance.positional,
              equals('value to be passed to constructor instead'),
              reason:
                  'should have passed the return value of `onUnsupportedArgument` to the constructor');
        });

        test('named parameter', () {
          Expression unsupportedArgument;

          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember(
                  '@TestAnnotation.namedConstructor(namedConstructorOnly: const [])\nvar a;'),
              TestAnnotation, onUnsupportedArgument: (Expression expression) {
            unsupportedArgument = expression;
            return 'value to be passed to constructor instead';
          });

          expect(unsupportedArgument, const isInstanceOf<NamedExpression>());
          expect((unsupportedArgument as NamedExpression).name.label.name,
              equals('namedConstructorOnly'));
          expect(instance.namedConstructorOnly,
              equals('value to be passed to constructor instead'),
              reason:
                  'should have passed the return value of `onUnsupportedArgument` to the constructor');
        });
      });
    });

    test('annotation with both named and positional parameters', () {
      var node =
          parseAndGetSingleMember('@TestAnnotation(1, named: 2)\nvar a;');
      TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
      expect(instance.positional, 1);
      expect(instance.named, 2);
    });

    test('instantiates an annotation using a named constructor', () {
      var node = parseAndGetSingleMember(
          '@TestAnnotation.namedConstructor(namedConstructorOnly: true)\nvar a;');
      TestAnnotation instance = instantiateAnnotation(node, TestAnnotation);
      expect(instance.namedConstructorOnly, true);
    });

    test('throws if the annotation cannot be constructed', () {
      var node = parseAndGetSingleMember(
          '@TestAnnotation(1, 2, 3, 4, "way more parameters than were declared")\nvar a;');
      expect(() {
        instantiateAnnotation(node, TestAnnotation);
      }, throwsA(startsWith('Unable to instantiate annotation')));
    });

    test('throws if the annotation is not used as a constructor', () {
      var node = parseAndGetSingleMember('@TestAnnotation\nvar a;');
      expect(() {
        instantiateAnnotation(node, TestAnnotation);
      }, throwsA(startsWith('Annotation not invocation of constructor')));
    });

    test('returns null when the member is not annotated', () {
      var node = parseAndGetSingleMember('var a;');
      expect(instantiateAnnotation(node, TestAnnotation), isNull);
    });

    test('returns null when the member has only non-matching annotations', () {
      var node = parseAndGetSingleMember('@NonexistantAnnotation\nvar a;');
      expect(instantiateAnnotation(node, TestAnnotation), isNull);
    });

    test('returns null when the member has no annotations', () {
      var node = parseAndGetSingleMember('var a;');
      expect(instantiateAnnotation(node, TestAnnotation), isNull);
    });
  });
}
