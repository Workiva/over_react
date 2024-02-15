// Copyright 2021 Workiva Inc.
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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/is_props_from_render.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';


void main() {
  group('isPropsFromRender', () {
    /// Parsed and resolves [source] and returns the expression that is returned from
    /// a function named `returnsExpressionToTest`.
    ///
    /// There must be exactly one function with that name, and it can either be an arrow function
    /// or a block function with exactly one return statement with an explicit value.
    ///
    /// For example,
    /// ```dart
    /// await getExpressionToTest(r'''
    ///   returnsExpressionToTest() {
    ///     return someExpression;
    ///   }
    /// ''');
    /// ```
    /// Returns `someExpression`.
    Future<Expression> getExpressionToTest(String source) async {
      final result = await parseAndGetResolvedUnit('''
        import 'package:over_react/over_react.dart';
        
        late UiFactory<FooProps> Foo;
        mixin FooProps on UiProps {}
        
        $source
      ''');
      final functionBody = allDescendants(result.unit).whereType<FunctionBody>().singleWhere((f) {
        final name =
            // Top-level and local functions
            f.parent.tryCast<FunctionExpression>()?.parent.tryCast<FunctionDeclaration>()?.name.lexeme ??
                // Class methods
                f.parent?.tryCast<MethodDeclaration>()?.name.lexeme;
        return name == 'returnsExpressionToTest';
      });
      return functionBody.returnExpressions.single;
    }

    group('returns false for', () {
      test('arbitrary props arguments', () async {
        expect(isPropsFromRender(await getExpressionToTest(r'''
          returnsExpressionToTest(FooProps props) => props;
        ''')), isFalse);
      });

      test('arbitrary props variables', () async {
        expect(isPropsFromRender(await getExpressionToTest(r'''
          returnsExpressionToTest() {
            final props = Foo();
            return props;
          }
        ''')), isFalse);
      });

      test('single-invoked builders', () async {
        expect(isPropsFromRender(await getExpressionToTest(r'''
          returnsExpressionToTest() => Foo();
        ''')), isFalse);
      });

      // FIXME also inside a component, function component
    });

    group('returns true for', () {
      group('function component props', () {
        test('in a uiFunction', () async {
          expect(isPropsFromRender(await getExpressionToTest(r'''
            final Bar = uiFunction<UiProps>((props) {
              returnsExpressionToTest() => props;
            }, UiFactoryConfig());
          ''')), isTrue);
        });

        test('in a uiForwardRef', () async {
          expect(isPropsFromRender(await getExpressionToTest(r'''
            final Bar = uiForwardRef<UiProps>((props, ref) {
              returnsExpressionToTest() => props;
            }, UiFactoryConfig());
          ''')), isTrue);
        });

        test('even when the name is not "props"', () async {
          expect(isPropsFromRender(await getExpressionToTest(r'''
            final Bar = uiFunction<UiProps>((someOtherName) {
              returnsExpressionToTest() => someOtherName;
            }, UiFactoryConfig());
          ''')), isTrue);
        });
      });

      group('class component props', () {
        test('when accessed via implicit this', () async {
          expect(isPropsFromRender(await getExpressionToTest(r'''
            class FooComponent extends UiComponent2 {
              @override render() {}
              returnsExpressionToTest() => props;
            }
          ''')), isTrue);
        });

        test('when accessed via explicit this', () async {
          expect(isPropsFromRender(await getExpressionToTest(r'''
            class FooComponent extends UiComponent2 {
              @override render() {}
              returnsExpressionToTest() => this.props;
            }
          ''')), isTrue);
        });
      });
    });
  });
}
