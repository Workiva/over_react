import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:source_span/source_span.dart';

const _errorDesc = 'Something is malformed in your component boilerplate';
// <editor-fold desc="Error Documentation Details">
const _errorDetails = r'''

Anything caught by this rule will cause the over_react builder to fail when building your project.

TODO: Write a description about the types of things our validator catches

''';
// </editor-fold>

const _warningDesc = 'Something is not quite right in your component boilerplate';
// <editor-fold desc="Warning Documentation Details">
const _warningDetails = r'''

Anything caught by this rule could cause unexpected behavior at build / run time.

TODO: Write a description about the types of things our validator catches

''';
// </editor-fold>

const _debugDesc = 'Internal tool for debugging boilerplate parsing / building';
// <editor-fold desc="Debug Documentation Details">
const _debugDetails = r'''

TODO: Add some info here for contributors so they know how to use it

''';
// </editor-fold>

class BoilerplateValidatorDiagnostic extends DiagnosticContributor {
  @DocsMeta(_errorDesc, details: _errorDetails)
  static const errorCode = DiagnosticCode(
      'over_react_boilerplate_error', '{0}', AnalysisErrorSeverity.ERROR, AnalysisErrorType.COMPILE_TIME_ERROR);

  // TODO should this be COMPILE_TIME_ERROR or STATIC_WARNING?
  @DocsMeta(_warningDesc, details: _warningDetails)
  static const warningCode = DiagnosticCode(
      'over_react_boilerplate_warning', '{0}', AnalysisErrorSeverity.WARNING, AnalysisErrorType.COMPILE_TIME_ERROR);

  @DocsMeta(_debugDesc, details: _debugDetails, maturity: Maturity.experimental)
  static const debugCode =
      DiagnosticCode('over_react_boilerplate_debug', '{0}', AnalysisErrorSeverity.INFO, AnalysisErrorType.HINT);

  static final _debugFlagPattern = RegExp(r'debug:.*\bover_react_boilerplate\b');

  // TODO: How do we define / document all the possible errors?
//  BoilerplateValidatorDiagnostic()
//      : super({
//          errorCode.name: DocumentedDiagnosticContributorMeta(
//            errorCode.name,
//            '',
//            details: null,
//            severity: errorCode.errorSeverity,
//            type: errorCode.type,
//          )
//        });

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
