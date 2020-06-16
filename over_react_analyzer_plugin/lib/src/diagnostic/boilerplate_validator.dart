import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:source_span/source_span.dart';

class BoilerplateValidatorDiagnostic extends DiagnosticContributor {
  static final errorCode = DiagnosticCode(
      'over_react_boilerplate_error', '{0}', AnalysisErrorSeverity.ERROR, AnalysisErrorType.COMPILE_TIME_ERROR);

  static final warningCode = DiagnosticCode(
      'over_react_boilerplate_warning', '{0}', AnalysisErrorSeverity.WARNING, AnalysisErrorType.COMPILE_TIME_ERROR);

  static final debugCode =
      DiagnosticCode('over_react_boilerplate_debug', '{0}', AnalysisErrorSeverity.INFO, AnalysisErrorType.HINT);

  static final _debugFlagPattern = RegExp(r'debug:.*\bover_react_boilerplate\b');

  @override
  Future<void> computeErrors(result, collector) async {
    final debugMatch = _debugFlagPattern.firstMatch(result.content);
    final debug = debugMatch != null;
    if (debug) {
      collector.addError(debugCode, result.location(offset: debugMatch.start, end: debugMatch.end),
          errorMessageArgs: ['Boilerplate debugging hints enabled']);
    }

    final sourceFile = SourceFile.fromString(result.content, url: result.path);

    final errorCollector = ErrorCollector.callback(
      sourceFile,
      onError: (message, [span]) {
        final location = result.location(range: span.asRangeOrEmpty());
        collector.addError(errorCode, location, errorMessageArgs: [message]);
      },
      onWarning: (message, [span]) {
        final location = result.location(range: span.asRangeOrEmpty());
        collector.addError(warningCode, location, errorMessageArgs: [message]);
      },
    );

    final members = detectBoilerplateMembers(result.unit);
    if (debug) {
      for (final member in members.allMembers) {
        collector.addError(debugCode, result.locationFor(member.name), errorMessageArgs: [member.debugString]);
      }
    }

    final declarations = getBoilerplateDeclarations(members, errorCollector).toList();
    for (var j = 0; j < declarations.length; j++) {
      final declaration = declarations[j];
      declaration.validate(errorCollector);

      if (debug) {
        final declarationName =
            'Declaration ${j + 1}/${declarations.length} - ${declaration.runtimeType}, ${declaration.version.toString().split('.').last}';
        final declMembers = declaration.members.toList();
        for (var i = 0; i < declMembers.length; i++) {
          final member = declMembers[i];
          collector.addError(debugCode, result.locationFor(member.name),
              errorMessageArgs: ['Member ${i + 1}/${declMembers.length} of $declarationName']);
        }
      }
    }
  }
}

extension on SourceSpan {
  SourceRange asRange() => SourceRange(start.offset, length);
  SourceRange asRangeOrEmpty() => this == null ? SourceRange.EMPTY : asRange();
}

extension<E> on Iterable<E> {
  void forEachIndexed(void Function(E, int) callback) {
    var i = 0;
    forEach((e) {
      callback(e, i);
      i++;
    });
  }
}
