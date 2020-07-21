// Copyright 2020 Workiva Inc.
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
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/parsing.dart';
import 'package:test/test.dart';

import '../../ast_test_util.dart';

main() {
  group('ClassishDeclaration', () {
    test('constructor throws when type is invalid', () {
      final invalidNode = parseAndGetSingleWithType<EnumDeclaration>('enum Foo { bar, baz }');
      expect(() => ClassishDeclaration(invalidNode), throwsArgumentError);
    });

    group('provides correct implementations when the class is a', () {
      group('class:', () {
        test('simple getters:', () {
          final classish = parseAndGetSingleClassish('''
            @annotation
            class Foo<T> {
              static var staticField;
              static staticMethod() {}
              
              var field;
              method() {}
              
              Foo.constructor() {}
            }
          ''');
          expect(classish.node, isA<ClassDeclaration>());
          expect(classish.name?.name, 'Foo');
          expect(classish.metadata.firstOrNull?.toSource(), '@annotation');
          expect(classish.typeParameters?.toSource(), '<T>');
          expect(
              classish.members.map((m) => m.toSource()),
              unorderedEquals([
                contains('staticField'),
                contains('staticMethod'),
                contains('field'),
                contains('method'),
                contains('constructor'),
              ]));
          expect(classish.classOrMixinKeyword.toString(), 'class');
        });

        group('more involved getters:', () {
          test('interfaces', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').interfaces, isEmpty);

            expect(parseAndGetSingleClassish('''
              abstract class Foo implements Bar, Baz {}
            ''').interfaces.map((i) => i.name.name), ['Bar', 'Baz']);
          });

          test('withClause', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').withClause, isNull);

            expect(parseAndGetSingleClassish('''
              class Foo extends Object with Bar {}
            ''').withClause?.toSource(), 'with Bar');
          });

          test('abstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').abstractKeyword, isNull);

            expect(parseAndGetSingleClassish('''
              abstract class Foo {}
            ''').abstractKeyword?.toString(), 'abstract');
          });

          test('hasAbstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').hasAbstractKeyword, isFalse);

            expect(parseAndGetSingleClassish('''
              abstract class Foo {}
            ''').hasAbstractKeyword, isTrue);
          });

          test('superclass', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').superclass, isNull);

            expect(parseAndGetSingleClassish('''
              class Foo extends Bar {}
            ''').superclass?.name?.name, 'Bar');
          });

          test('mixins', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').mixins, isEmpty);

            expect(parseAndGetSingleClassish('''
              class Foo extends Object with Bar, Baz {}
            ''').mixins.map((m) => m.name.name), ['Bar', 'Baz']);
          });

          test('allSuperTypes', () {
            expect(parseAndGetSingleClassish('''
              class Foo extends Bar with Baz implements Qux {}
            ''').allSuperTypes.map((m) => m.name.name), unorderedEquals(['Bar', 'Baz', 'Qux']));
          });
        });
      });

      group('mixin application (aka "class type alias")', () {
        test('simple getters:', () {
          final classish = parseAndGetSingleClassish('''
            @annotation
            class Foo<T> = Object with Something;
          ''');
          expect(classish.node, isA<ClassTypeAlias>());
          expect(classish.name?.name, 'Foo');
          expect(classish.metadata.firstOrNull?.toSource(), '@annotation');
          expect(classish.typeParameters?.toSource(), '<T>');
          expect(classish.members, isEmpty);
          expect(classish.classOrMixinKeyword.toString(), 'class');
        });

        group('more involved getters:', () {
          test('interfaces', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Object with Something;
            ''').interfaces, isEmpty);

            expect(parseAndGetSingleClassish('''
              abstract class Foo = Object with Something implements Bar, Baz;
            ''').interfaces.map((i) => i.name.name), ['Bar', 'Baz']);
          });

          test('withClause', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Object with Bar;
            ''').withClause?.toSource(), 'with Bar');
          });

          test('abstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Object with Bar;
            ''').abstractKeyword, isNull);

            expect(parseAndGetSingleClassish('''
              abstract class Foo = Object with Bar;
            ''').abstractKeyword?.toString(), 'abstract');
          });

          test('hasAbstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Object with Bar;
            ''').hasAbstractKeyword, isFalse);

            expect(parseAndGetSingleClassish('''
              abstract class Foo = Object with Bar;
            ''').hasAbstractKeyword, isTrue);
          });

          test('superclass', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Bar with Baz;
            ''').superclass?.name?.name, 'Bar');
          });

          test('mixins', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Object with Bar, Baz;
            ''').mixins.map((m) => m.name.name), ['Bar', 'Baz']);
          });

          test('allSuperTypes', () {
            expect(parseAndGetSingleClassish('''
              class Foo = Bar with Baz implements Qux;
            ''').allSuperTypes.map((m) => m.name.name), unorderedEquals(['Bar', 'Baz', 'Qux']));
          });
        });
      });

      group('mixin', () {
        test('simple getters:', () {
          final classish = parseAndGetSingleClassish('''
            @annotation
            mixin Foo<T> {
              static var staticField;
              static staticMethod() {}
              
              var field;
              method() {}
            }
          ''');
          expect(classish.node, isA<MixinDeclaration>());
          expect(classish.name?.name, 'Foo');
          expect(classish.metadata.firstOrNull?.toSource(), '@annotation');
          expect(classish.typeParameters?.toSource(), '<T>');
          expect(
              classish.members.map((m) => m.toSource()),
              unorderedEquals([
                contains('staticField'),
                contains('staticMethod'),
                contains('field'),
                contains('method'),
              ]));
          expect(classish.classOrMixinKeyword.toString(), 'mixin');
        });

        group('more involved getters:', () {
          test('interfaces', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo {}
            ''').interfaces, isEmpty);

            expect(parseAndGetSingleClassish('''
              mixin Foo on Bar implements Baz {}
            ''').interfaces.map((i) => i.name.name), unorderedEquals(['Bar', 'Baz']));
          });

          test('withClause', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo {}
            ''').withClause, isNull);
          });

          test('abstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo {}
            ''').abstractKeyword, isNull);
          });

          test('hasAbstractKeyword', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo {}
            ''').hasAbstractKeyword, isFalse);
          });

          test('superclass', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo on Bar implements Baz {}
            ''').superclass, isNull);
          });

          test('mixins', () {
            expect(parseAndGetSingleClassish('''
              class Foo {}
            ''').mixins, isEmpty);
          });

          test('allSuperTypes', () {
            expect(parseAndGetSingleClassish('''
              mixin Foo on Bar implements Baz {}
            ''').allSuperTypes.map((m) => m.name.name), unorderedEquals(['Bar', 'Baz']));
          });
        });
      });
    });
  });
}
