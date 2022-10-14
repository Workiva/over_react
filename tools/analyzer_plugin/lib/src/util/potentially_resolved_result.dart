// Copyright 2022 Workiva Inc.
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

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

class PotentiallyResolvedResult {
  final Union<ResolvedUnitResult, ParsedUnitResult> _result;

  PotentiallyResolvedResult.resolved(ResolvedUnitResult resolved) : _result = Union.a(resolved);

  PotentiallyResolvedResult.unresolved(ParsedUnitResult unresolved) : _result = Union.b(unresolved);

  ResolvedUnitResult? get resolved => _result.a;

  ParsedUnitResult? get unresolved => _result.b;

  CompilationUnit? get unit => _result.switchCase((r) => r.unit, (r) => r.unit);

  String? get content => _result.switchCase((r) => r.content, (r) => r.content);

  String? get path => _result.switchCase((r) => r.path, (r) => r.path);

  Uri get uri => _result.switchCase((r) => r.uri, (r) => r.uri);

  AnalysisSession get session => _result.switchCase((r) => r.session, (r) => r.session);

  LineInfo get lineInfo => _result.switchCase((r) => r.lineInfo, (r) => r.lineInfo);

  bool get isPart => _result.switchCase((r) => r.isPart, (r) => r.isPart);

  List<AnalysisError> get errors => _result.switchCase((r) => r.errors, (r) => r.errors);
}

extension ResolvedUnitResultAsPotentiallyResolved on ResolvedUnitResult {
  PotentiallyResolvedResult asPotentiallyResolvedResult() => PotentiallyResolvedResult.resolved(this);
}

extension ParsedUnitResultAsPotentiallyResolved on ParsedUnitResult {
  PotentiallyResolvedResult asPotentiallyResolvedResult() => PotentiallyResolvedResult.unresolved(this);
}
