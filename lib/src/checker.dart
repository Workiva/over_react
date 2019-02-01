// Based on https://github.com/google/built_value.dart/blob/master/built_value_generator/lib/src/plugin/plugin.dart,
// hacked together as a proof of concept.
//
// Copyright 2015, Google Inc. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
// * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//
// * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/arrow_function_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/duplicate_prop_cascade.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/extra_invocations.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/hashcode_as_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/render_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/variadic_children.dart';

/// Checks a library for errors related to built_value generation. Returns
/// the errors and, where possible, corresponding fixes.
class Checker {
  Map<AnalysisError, PrioritizedSourceChange> check(
      CompilationUnit compilationUnit, String path) {
    final result = <AnalysisError, PrioritizedSourceChange>{};

    final checkers = <SubChecker>[
      new DuplicatePropCascadeChecker(),
      new HashCodeAsKeyChecker(),
      new VariadicChildrenChecker(),
      new ArrowFunctionPropCascadeChecker(),
      new ExtraInvocationsChecker(),
      new RenderReturnValueChecker(),
      new InvalidChildChecker(),
    ];

    for (var checker in checkers) {
      checker.check(compilationUnit);
      final errors = checker.getErrors();
      checker.clearErrors();

      for (var error in errors) {
        final lineInfo = compilationUnit.lineInfo;
        final offsetLineLocation = lineInfo.getLocation(error.offset);

        final analysisError = new AnalysisError(
            error.severity,
            error.type,
            new Location(
                path,
                error.offset,
                error.end - error.offset,
                offsetLineLocation.lineNumber,
                offsetLineLocation.columnNumber),
            error.message, error.code);

        PrioritizedSourceChange fix;
        if (error.hasFix) {
          int priority;
          switch (error.severity) {
            case AnalysisErrorSeverity.INFO:
              priority = 1000000;
              break;
            case AnalysisErrorSeverity.WARNING:
              priority = 1000002;
              break;
            case AnalysisErrorSeverity.ERROR:
              priority = 1000003;
              break;
          }

          fix = new PrioritizedSourceChange(
              priority,
              new SourceChange(
                error.fixMessage,
                edits: [
                  new SourceFileEdit(
                    path,
                    error.modificationStamp,
                    edits: error.fixEdits ?? [new SourceEdit(error.offset, error.length, error.fix)],
                  )
                ],
              ));
        }
        result[analysisError] = fix;
      }
    }

    return result;
  }
}
