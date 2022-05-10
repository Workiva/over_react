// Adapted from: https://github.com/dart-lang/sdk/blob/1601f6fcd2a7aa39bdd71f1f988fe7acfaecc418/pkg/analyzer/test/src/dart/ast/utilities_test.dart
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
class NodeLocator2Test {
  void test_onlyStartOffset() {
    const code = ' int vv; ';
    //             012345678
    final unit = parseAndGetUnit(code);
    final declaration = unit.declarations[0] as TopLevelVariableDeclaration;
    final variableList = declaration.variables;
    final typeName = (variableList.type as TypeName).name;
    final varName = variableList.variables[0].name;
    expect(NodeLocator2(0).searchWithin(unit), same(unit));
    expect(NodeLocator2(1).searchWithin(unit), same(typeName));
    expect(NodeLocator2(2).searchWithin(unit), same(typeName));
    expect(NodeLocator2(3).searchWithin(unit), same(typeName));
    expect(NodeLocator2(4).searchWithin(unit), same(variableList));
    expect(NodeLocator2(5).searchWithin(unit), same(varName));
    expect(NodeLocator2(6).searchWithin(unit), same(varName));
    expect(NodeLocator2(7).searchWithin(unit), same(declaration));
    expect(NodeLocator2(8).searchWithin(unit), same(unit));
    expect(NodeLocator2(9).searchWithin(unit), isNull);
    expect(NodeLocator2(100).searchWithin(unit), isNull);
  }

  void test_startEndOffset() {
    const code = ' int vv; ';
    //             012345678
    final unit = parseAndGetUnit(code);
    final declaration = unit.declarations[0] as TopLevelVariableDeclaration;
    final variableList = declaration.variables;
    final typeName = (variableList.type as TypeName).name;
    final varName = variableList.variables[0].name;
    expect(NodeLocator2(-1, 2).searchWithin(unit), isNull);
    expect(NodeLocator2(0, 2).searchWithin(unit), same(unit));
    expect(NodeLocator2(1, 2).searchWithin(unit), same(typeName));
    expect(NodeLocator2(1, 3).searchWithin(unit), same(typeName));
    expect(NodeLocator2(1, 4).searchWithin(unit), same(variableList));
    expect(NodeLocator2(5, 6).searchWithin(unit), same(varName));
    expect(NodeLocator2(5, 7).searchWithin(unit), same(declaration));
    expect(NodeLocator2(5, 8).searchWithin(unit), same(unit));
    expect(NodeLocator2(5, 100).searchWithin(unit), isNull);
    expect(NodeLocator2(100, 200).searchWithin(unit), isNull);
  }
}

@reflectiveTest
class NodeLocatorTest {
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

  AstNode _assertLocate(
    CompilationUnit unit,
    int start,
    int end,
  ) {
    final locator = NodeLocator(start, end);
    final node = locator.searchWithin(unit)!;
    expect(locator.foundNode, same(node));
    expect(node.offset <= start, isTrue, reason: "Node starts after range");
    expect(node.offset + node.length > end, isTrue, reason: "Node ends before range");
    return node;
  }
}
