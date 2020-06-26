import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/boilerplate_utils.dart';
import 'package:source_span/source_span.dart';

const _errorDesc = 'Something is malformed in your component boilerplate.';
// TODO: Add a more detailed description about the types of things our validator catches
// <editor-fold desc="Error Documentation Details">
const _errorDetails = r'''

Anything caught by this rule will cause the over_react builder to fail when building your project.

''';
// </editor-fold>

const _warningDesc = 'Something is not quite right in your component boilerplate.';
// TODO: Add a more detailed description about the types of things our validator catches
// <editor-fold desc="Warning Documentation Details">
const _warningDetails = r'''

Anything caught by this rule could cause unexpected behavior at build / run time.

''';
// </editor-fold>

const _debugDesc = 'Internal tool for debugging boilerplate parsing / building.';
// TODO: Add some info here for contributors so they know how to use it
// <editor-fold desc="Debug Documentation Details">
const _debugDetails = r'''''';
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

  static final missingGeneratedPartFixKind = FixKind(errorCode.name, 200, 'Add generated part directive');
  static final invalidGeneratedPartFixKind = FixKind(errorCode.name, 200, 'Fix generated part directive');
  static final unnecessaryGeneratedPartFixKind = FixKind(errorCode.name, 200, 'Remove generated part directive');

  static final _debugFlagPattern = RegExp(r'debug:.*\bover_react_boilerplate\b');

  PartDirective _overReactGeneratedPartDirective;
  bool _overReactGeneratedPartDirectiveIsValid;

  @override
  Future<void> computeErrors(result, collector) async {
    _overReactGeneratedPartDirective = getOverReactGeneratedPartDirective(result.unit);
    _overReactGeneratedPartDirectiveIsValid = _overReactGeneratedPartDirective != null &&
        overReactGeneratedPartDirectiveIsValid(_overReactGeneratedPartDirective, result.uri);

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
    for (final member in members.allMembers) {
      if (debug) {
        collector.addError(debugCode, result.locationFor(member.name), errorMessageArgs: [member.debugString]);
      }

      // Do not lint anything that is not a likely boilerplate member that will actually get generated.
      if (member.versionConfidences.toList().every((vcp) => vcp.confidence <= Confidence.neutral)) continue;

      if (_overReactGeneratedPartDirective == null) {
        await _addPartDirectiveErrorForMember(
          result: result,
          collector: collector,
          member: member,
          errorType: PartDirectiveErrorType.missing,
        );
      } else if (!_overReactGeneratedPartDirectiveIsValid) {
        await _addPartDirectiveErrorForMember(
          result: result,
          collector: collector,
          member: member,
          errorType: PartDirectiveErrorType.invalid,
        );
      }
    }

    final declarations = getBoilerplateDeclarations(members, errorCollector).toList();
    for (var j = 0; j < declarations.length; j++) {
      final declaration = declarations[j];
      declaration.validate(errorCollector);

      final declarationName =
          'Declaration ${j + 1}/${declarations.length} - ${declaration.runtimeType}, ${declaration.version.toString().split('.').last}';
      final declMembers = declaration.members.toList();
      for (var i = 0; i < declMembers.length; i++) {
        final member = declMembers[i];
        if (debug) {
          collector.addError(debugCode, result.locationFor(member.name),
              errorMessageArgs: ['Member ${i + 1}/${declMembers.length} of $declarationName']);
        }
      }
    }

    // TODO: this logic does not handle when the component is already in a part file. We should refactor this to share logic that the builder uses to validate parts.
    // <https://github.com/Workiva/over_react/issues/522>
    if (declarations.isEmpty && _overReactGeneratedPartDirective != null) {
      await collector.addErrorWithFix(
        errorCode,
        result.locationFor(_overReactGeneratedPartDirective),
        errorMessageArgs: [
          // ignore: no_adjacent_strings_in_list
          'This part will not be generated because there are no valid OverReact component boilerplate '
              'declarations in this file. If you expect this file to contain OverReact component boilerplate declarations, '
              'double check that they have no syntax errors / lints. Otherwise, the part can safely be removed.'
        ],
        fixKind: unnecessaryGeneratedPartFixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          removeOverReactGeneratedPartDirective(builder, result.unit);
        }),
      );
    } else if (declarations.isNotEmpty &&
        _overReactGeneratedPartDirective != null &&
        !_overReactGeneratedPartDirectiveIsValid) {
      await collector.addErrorWithFix(
        errorCode,
        result.locationFor(_overReactGeneratedPartDirective),
        errorMessageArgs: ['The generated part name must match the name of the file that contains it.'],
        fixKind: invalidGeneratedPartFixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          fixOverReactGeneratedPartDirective(builder, result.unit, result.uri);
        }),
      );
    }
  }

  Future<void> _addPartDirectiveErrorForMember({
    @required ResolvedUnitResult result,
    @required DiagnosticCollector collector,
    @required BoilerplateMember member,
    @required PartDirectiveErrorType errorType,
  }) {
    const memberMissingPartErrorMsg = 'A `.over_react.g.dart` part directive is required';
    const memberInvalidPartErrorMsg = 'A valid `.over_react.g.dart` part directive is required';
    final memberPartDirectiveErrorMsg =
        errorType == PartDirectiveErrorType.missing ? memberMissingPartErrorMsg : memberInvalidPartErrorMsg;
    final memberPartDirectiveFixKind =
        errorType == PartDirectiveErrorType.missing ? missingGeneratedPartFixKind : invalidGeneratedPartFixKind;
    final fixFn = errorType == PartDirectiveErrorType.missing
        ? addOverReactGeneratedPartDirective
        : fixOverReactGeneratedPartDirective;

    return collector.addErrorWithFix(
      errorCode,
      result.locationFor(member.name),
      errorMessageArgs: ['$memberPartDirectiveErrorMsg to use OverReact component boilerplate.'],
      fixKind: memberPartDirectiveFixKind,
      computeFix: () => buildFileEdit(result, (builder) {
        fixFn(builder, result.unit, result.uri);
      }),
    );
  }
}

enum PartDirectiveErrorType { missing, invalid }

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
