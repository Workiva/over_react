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

import 'package:analyzer/dart/ast/ast.dart';

import 'parsing/declarations.dart';
import 'parsing/declarations_from_members.dart';
import 'parsing/error_collection.dart';
import 'parsing/members_from_ast.dart';

export 'parsing/ast_util.dart';
export 'parsing/declarations.dart';
export 'parsing/declarations_from_members.dart';
export 'parsing/error_collection.dart';
export 'parsing/member_association.dart';
export 'parsing/members.dart';
export 'parsing/members_from_ast.dart';
export 'parsing/meta.dart';
export 'parsing/util.dart';
export 'parsing/version.dart';

Iterable<BoilerplateDeclaration> parseDeclarations(
    CompilationUnit unit, ErrorCollector errorCollector) {
  final members = detectBoilerplateMembers(unit);
  return getBoilerplateDeclarations(members, errorCollector);
}

List<BoilerplateDeclaration> parseAndValidateDeclarations(
    CompilationUnit unit, ErrorCollector errorCollector) {
  final declarations = parseDeclarations(unit, errorCollector).toList();
  for (var declaration in declarations) {
    declaration.validate(errorCollector);
  }
  return declarations;
}
