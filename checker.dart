// Based on https://github.com/google/built_value.dart/blob/master/built_value_generator/lib/src/plugin/plugin.dart,
// hacked together as a proof of concept.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/duplicate_prop_cascade.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/hashcode_as_key.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/variadic_children.dart';

/// Checks a library for errors related to built_value generation. Returns
/// the errors and, where possible, corresponding fixes.
class Checker {
  Map<AnalysisError, PrioritizedSourceChange> check(
      LibraryElement libraryElement) {
    final result = <AnalysisError, PrioritizedSourceChange>{};

    final checkers = [
      new DuplicatePropCascadeChecker(),
      new HashCodeAsKeyChecker(),
      new VariadicChildrenChecker(),
    ];

    for (final compilationUnit in libraryElement.units) {
      for (var checker in checkers) {
        checker.visitCompilationUnitElement(compilationUnit);
        final errors = checker.getErrors();

        for (var error in errors) {
          final lineInfo = compilationUnit.lineInfo;
          final offsetLineLocation = lineInfo.getLocation(error.offset);

          final analysisError = new AnalysisError(
              error.severity,
              error.type,
              new Location(
                  compilationUnit.source.fullName,
                  error.offset,
                  error.end - error.offset,
                  offsetLineLocation.lineNumber,
                  offsetLineLocation.columnNumber),
              error.message, error.code);

          PrioritizedSourceChange fix;
          if (error.fix != null) {
            fix = new PrioritizedSourceChange(
                1000000,
                new SourceChange(
                  error.fixMessage,
                  edits: [
                    new SourceFileEdit(
                      compilationUnit.source.fullName,
                      compilationUnit.source.modificationStamp,
                      edits: [new SourceEdit(error.offset, error.length, error.fix)],
                    )
                  ],
                ));
          }
          result[analysisError] = fix;
        }
      }
    }

    return result;
  }
}
