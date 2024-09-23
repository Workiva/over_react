// Adapted from analyzer 5.13.0 src/dart/ast/utilities.dart
// Permalink: https://github.com/dart-lang/sdk/blob/efe0ca193f1c1485efc5467fb8dc9dfca6085d39/pkg/analyzer/test/src/dart/ast/utilities_test.dart
//
// Copyright 2013, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../../test_util.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NodeLocatorTest);
    defineReflectiveTests(NodeLocator2Test);
  });
}

@reflectiveTest
class NodeLocator2Test extends _SharedNodeLocatorTests {
  @override
  AstNode? locate(
    CompilationUnit unit,
    int start, [
    int? end,
  ]) {
    final locator = NodeLocator2(start, end);
    final node = locator.searchWithin(unit)!;
    return node;
  }

  void test_onlyStartOffset() {
    var code = ' f() {} ';
    //             01234567
    final unit = parseAndGetUnit(code);
    final function = unit.declarations.single as FunctionDeclaration;
    final expression = function.functionExpression;
    final body = expression.body as BlockFunctionBody;
    expect(NodeLocator2(0).searchWithin(unit), same(unit));
    expect(NodeLocator2(1).searchWithin(unit), same(function));
    expect(NodeLocator2(2).searchWithin(unit), same(function));
    expect(NodeLocator2(3).searchWithin(unit), same(expression.parameters));
    expect(NodeLocator2(4).searchWithin(unit), same(expression));
    expect(NodeLocator2(5).searchWithin(unit), same(body.block));
    expect(NodeLocator2(6).searchWithin(unit), same(body.block));
    expect(NodeLocator2(7).searchWithin(unit), same(unit));
    expect(NodeLocator2(100).searchWithin(unit), isNull);
  }

  void test_startEndOffset() {
    var code = ' f() {} ';
    //             01234567
    final unit = parseAndGetUnit(code);
    final function = unit.declarations.single as FunctionDeclaration;
    expect(NodeLocator2(-1, 2).searchWithin(unit), isNull);
    expect(NodeLocator2(0, 2).searchWithin(unit), same(unit));
    expect(NodeLocator2(1, 2).searchWithin(unit), same(function));
    expect(NodeLocator2(1, 3).searchWithin(unit), same(function));
    expect(NodeLocator2(1, 4).searchWithin(unit), same(function));
    expect(NodeLocator2(5, 7).searchWithin(unit), same(unit));
    expect(NodeLocator2(5, 100).searchWithin(unit), isNull);
    expect(NodeLocator2(100, 200).searchWithin(unit), isNull);
  }
}

@reflectiveTest
class NodeLocatorTest extends _SharedNodeLocatorTests {
  @override
  AstNode? locate(
    CompilationUnit unit,
    int start, [
    int? end,
  ]) {
    final locator = NodeLocator(start, end);
    final node = locator.searchWithin(unit)!;
    expect(locator.foundNode, same(node));
    return node;
  }

  void test_range() {
    final unit = parseAndGetUnit("library myLib;");
    final node = _assertLocate(unit, 4, 10);
    expect(node, isA<LibraryDirective>());
  }

  void test_searchWithin_null() {
    final locator = NodeLocator(0, 0);
    expect(locator.searchWithin(null), isNull);
  }

  void test_searchWithin_offset() {
    final unit = parseAndGetUnit("library myLib;");
    final node = _assertLocate(unit, 10, 10);
    expect(node, isA<SimpleIdentifier>());
  }

  void test_searchWithin_offsetAfterNode() {
    final unit = parseAndGetUnit(r'''
class A {}
class B {}''');
    final locator = NodeLocator(1024, 1024);
    final node = locator.searchWithin(unit.declarations[0]);
    expect(node, isNull);
  }

  void test_searchWithin_offsetBeforeNode() {
    final unit = parseAndGetUnit(r'''
class A {}
class B {}''');
    final locator = NodeLocator(0, 0);
    final node = locator.searchWithin(unit.declarations[1]);
    expect(node, isNull);
  }
}

abstract class _SharedNodeLocatorTests {
  AstNode? locate(
    CompilationUnit unit,
    int start, [
    int? end,
  ]);

  void test_searchWithin_constructor_afterName_beforeParameters() {
    var source = r'''
class A {
  A() {}
}
''';
    var unit = parseAndGetUnit(source);
    // TODO(dantup): Update these tests to use markers.
    final node = _assertLocate(unit, source.indexOf('() {}'));
    expect(node, isA<ConstructorDeclaration>());
  }

  void test_searchWithin_function_afterName_beforeParameters() {
    var source = r'''
void f() {}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('() {}'));
    expect(node, isA<FunctionDeclaration>());
  }

  void test_searchWithin_function_afterName_beforeTypeParameters() {
    var source = r'''
void f<T>() {}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('<T>() {}'));
    expect(node, isA<FunctionDeclaration>());
  }

  void test_searchWithin_method_afterName_beforeParameters() {
    var source = r'''
class A {
  void m() {}
}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('() {}'));
    expect(node, isA<MethodDeclaration>());
  }

  void test_searchWithin_method_afterName_beforeTypeParameters() {
    var source = r'''
class A {
  void m<T>() {}
}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('<T>() {}'));
    expect(node, isA<MethodDeclaration>());
  }

  void test_searchWithin_namedConstructor_afterName_beforeParameters() {
    var source = r'''
class A {
  A.c() {}
}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('() {}'));
    expect(node, isA<ConstructorDeclaration>());
  }

  void test_searchWithin_setter_afterName_beforeParameters() {
    var source = r'''
set s(int i) {}
''';
    var unit = parseAndGetUnit(source);
    final node = _assertLocate(unit, source.indexOf('(int i)'));
    expect(node, isA<FunctionDeclaration>());
  }

  AstNode _assertLocate(
    CompilationUnit unit,
    int start, [
    int? end,
  ]) {
    end ??= start;
    final node = locate(unit, start, end)!;
    expect(node.offset <= start, isTrue, reason: "Node starts after range");
    expect(node.offset + node.length > end, isTrue,
        reason: "Node ends before range");
    return node;
  }
}
