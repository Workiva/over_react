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

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react/src/builder/parsing/ast_util/classish.dart';

CompilationUnitMember parseAndGetSingleMember(String source) =>
    parseAndGetSingleWithType<CompilationUnitMember>(source);

ClassishDeclaration parseAndGetSingleClassish(String source) =>
    ClassishDeclaration(parseAndGetSingleWithType(source));

T parseAndGetSingleWithType<T extends AstNode>(String source) =>
    parseAndGetAllWithType<T>(source).single;

T parseAndGetFirstWithType<T extends AstNode>(String source) =>
    parseAndGetAllWithType<T>(source).first;

List<T> parseAndGetAllWithType<T extends AstNode>(String source) {
  final result = parseString(content: source, throwIfDiagnostics: false);
  if (result.errors.isNotEmpty) {
    throw ArgumentError.value(source, 'source', 'parsing resulted in errors: ${result.errors}');
  }

  return getAllWithTypeWithin(result.unit);
}

List<T> getAllWithTypeWithin<T extends AstNode>(AstNode node) {
  if (T == AstNode || T == dynamic || T == Object) {
    throw ArgumentError(
        'Generic parameter must not be AstNode; was it specified/inferred properly?');
  }

  final visitor = _GetAllWithTypeWithinVisitor<T>();
  node.accept(visitor);
  return visitor._matchingNodes;
}

class _GetAllWithTypeWithinVisitor<T extends AstNode> extends UnifyingAstVisitor<void> {
  final _matchingNodes = <T>[];

  @override
  void visitNode(AstNode node) {
    if (node is T) {
      _matchingNodes.add(node);
    }

    super.visitNode(node);
  }
}
