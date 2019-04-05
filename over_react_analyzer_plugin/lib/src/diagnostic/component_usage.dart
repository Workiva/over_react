// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' hide AnalysisError;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer/src/generated/java_core.dart';
import 'package:analyzer_plugin/utilities/analyzer_converter.dart';
import 'package:analyzer_plugin/utilities/generator.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';

export 'package:over_react_analyzer_plugin/src/component_usage.dart';
export 'package:analyzer_plugin/protocol/protocol_common.dart' show AnalysisErrorType, AnalysisErrorSeverity;
export 'package:analyzer_plugin/utilities/fixes/fixes.dart' show FixKind;
export 'package:analyzer_plugin/utilities/range_factory.dart' show range;
export 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

class ErrorCode {
  /// Initialize a newly created error code to have the given [name]. The message
  /// associated with the error will be created from the given [message]
  /// template. The correction associated with the error will be created from the
  /// given [correction] template.
  const ErrorCode(this.name, this.message, this.errorSeverity, this.type, [this.correction]);

  /// The name of the error code.
  final String name;

  /// The template used to create the message to be displayed for this error. The
  /// message should indicate what is wrong and why it is wrong.
  final String message;

  /// The template used to create the correction to be displayed for this error,
  /// or `null` if there is no correction information for this error. The
  /// correction should indicate how the user can fix the error.
  final String correction;

  /// The severity of the error.
  final AnalysisErrorSeverity errorSeverity;

  /// The type of the error.
  final AnalysisErrorType type;

  /// The unique name of this error code.
  String get uniqueName => "$runtimeType.$name";

  @override
  String toString() => uniqueName;

}

/// An object used to produce errors.
///
/// Clients may implement this class when implementing plugins.
abstract class DiagnosticContributor {
  /// Contribute errors for the location in the file specified by the given
  /// [result] into the given [collector].
  Future<void> computeErrors(ResolvedUnitResult result, DiagnosticCollector collector);
  
  Location location(ResolvedUnitResult result, {
    int offset,
    int end,
    int length,
    SourceRange range,
  }) {
    if (end != 0 && length != 0) {
      throw new ArgumentError('Cannot specify both `end` and `length`.');
    }
    if (length == null) {
      length = end != null ? end - offset : 0;
    }
    final info = result.lineInfo.getLocation(offset);
    return new Location(result.path, offset, length, info.lineNumber, info.columnNumber);
  }
}

/// A generator that will generate an 'edit.getErrors' response.
///
/// Clients may not extend, implement or mix-in this class.
class DiagnosticGenerator {
  /// Initialize a newly created errors generator to use the given
  /// [contributors].
  DiagnosticGenerator(this.contributors);

  /// The contributors to be used to generate the errors.
  final List<DiagnosticContributor> contributors;

  // TODO dry up
  /// Create an 'edit.getErrors' response for the location in the file specified
  /// by the given [request]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<List<AnalysisError>> generateErrorsResponse(ResolvedUnitResult unitResult) async {
    final notifications = <Notification>[];
    final collector = new DiagnosticCollectorImpl();
    for (DiagnosticContributor contributor in contributors) {
      try {
        await contributor.computeErrors(unitResult, collector, false);
      } catch (exception, stackTrace) {
        notifications.add(new PluginErrorParams(
                false, exception.toString(), stackTrace.toString())
            .toNotification());
      }
    }

    // The analyzer normally filters out errors with "ignore" comments,
    // but it doesn't do it for plugin errors, so we need to do that here.
    final lineInfo = unitResult.unit.lineInfo;
    final filteredErrors = filterIgnores(collector.errors, lineInfo,
      () => IgnoreInfo.calculateIgnores(unitResult.content, lineInfo));

    return filteredErrors;
  }


  Future<EditGetFixesResult> generateFixesResponse(DartFixesRequest request) async {
    final notifications = <Notification>[];
    final collector = new DiagnosticCollectorImpl();

    for (var contributor in contributors) {
      try {
        await contributor.computeErrors(request.result, collector, false);
      } catch (exception, stackTrace) {
        notifications.add(new PluginErrorParams(
                false, exception.toString(), stackTrace.toString())
            .toNotification());
      }
    }

    // Skip severity equality since it can be modified by analysis_options.yaml.
    final convertedRequestErrors = AnalyzerConverter().convertAnalysisErrors(request.errorsToFix);

    // todo use this logic?
//    // Return any fixes that are for the expected file and within the given offset.
//    final fixes = <plugin.AnalysisErrorFixes>[];
//    for (final error in checkResult.keys) {
//      final fix = checkResult[error];
//      if (error.location.file == parameters.file && fix != null) {
//        if (parameters.offset >= error.location.offset && parameters.offset <= error.location.offset + error.location.length) {
//          fixes.add(new plugin.AnalysisErrorFixes(error, fixes: [fix]));
//        }
//      }
//    }

    // Return any fixes that match the provided errors
    final fixes = <AnalysisErrorFixes>[];
    for (var convertedRequestError in convertedRequestErrors) {
      for (var i = 0; i < collector.errors.length; i++) {
        final newError = collector.errors[i];
        if (_isEquivalentError(convertedRequestError, newError)) {
          // Pass in the same error that was passed with the request
          fixes.add(AnalysisErrorFixes(
            convertedRequestError,
            fixes: [collector.fixes[i]],
          ));
          break;
        }
      }
    }

    return EditGetFixesResult(fixes);
  }

  /// Custom comparison of [a] and [b].
  ///
  /// Skip severity equality since it can be modified by analysis_options.yaml.
  /// Skip line information since one errors might not contain it,
  ///
  static bool _isEquivalentError(AnalysisError a, AnalysisError b) {
    return a.code == b.code &&
           a.message == b.message &&
           a.location.file == b.location.file &&
           a.location.offset == b.location.offset &&
           a.location.length == b.location.length;
  }
}


/// An object that [DiagnosticContributor]s use to record errors.
///
/// Clients may not extend, implement or mix-in this class.
abstract class DiagnosticCollector {
  void addRawError(AnalysisError error, {PrioritizedSourceChange fix});
  void addError(ErrorCode code, Location location, {FixKind fixKind, SourceChange fixChange, List<Object> errorMessageArgs, List<Object> fixMessageArgs, bool hasFix});
  Future<void> addErrorWithFix(ErrorCode code, Location location, {FixKind fixKind, FutureOr<SourceChange> computeFix(), List<Object> errorMessageArgs, List<Object> fixMessageArgs});
}

class DiagnosticCollectorImpl implements DiagnosticCollector {
  DiagnosticCollectorImpl(this.shouldComputeFixes);

  final bool shouldComputeFixes;

  /// The list of assists that have been collected.
  final List<AnalysisError> errors = [];
  final List<PrioritizedSourceChange> fixes = [];

  @override
  void addRawError(AnalysisError error, {PrioritizedSourceChange fix}) {
    errors.add(error);
    fixes.add(fix);
  }

  @override
  void addError(ErrorCode code, Location location, {bool hasFix = false, FixKind fixKind, SourceChange fixChange, List<Object> errorMessageArgs, List<Object> fixMessageArgs}) {
    PrioritizedSourceChange fix;
    if (fix != null) {
      if (fixChange.edits.isNotEmpty) {
        fixChange.message = formatList(fixKind.message, fixMessageArgs);
        fix = new PrioritizedSourceChange(fixKind.priority, fixChange);
      }
    }

    // fixme add hasFix
    final error = AnalysisError(
      AnalysisErrorSeverity.ERROR,
      code.type,
      location,
      formatList(code.message, errorMessageArgs),
      code.name,
      correction: null,
      hasFix: fix != null || hasFix,
    );

    addRawError(error, fix: fix);
  }

  @override
  Future<void> addErrorWithFix(ErrorCode code, Location location,
      {FixKind fixKind, FutureOr<SourceChange> computeFix(), List<
          Object> errorMessageArgs, List<Object> fixMessageArgs}) async {
    addError(code, location, hasFix: true,
      fixKind: fixKind,
      fixChange: await computeFix(),
      errorMessageArgs: errorMessageArgs,
      fixMessageArgs: fixMessageArgs,);
  }
}


abstract class ComponentUsageDiagnosticContributor extends DiagnosticContributor {
  Future<void> computeErrorsForUsage(ResolvedUnitResult result, DiagnosticCollector collector, FluentComponentUsage usage);

  @override
  Future<void> computeErrors(ResolvedUnitResult result, DiagnosticCollector collector) async {
    final usages = <FluentComponentUsage>[];
    result.unit.accept(ComponentUsageVisitor(usages.add));
    await Future.forEach(usages, (usage) => computeErrorsForUsage(result, collector, usage));
  }
}

typedef void _OnComponent(FluentComponentUsage usage);

class ComponentUsageVisitor extends RecursiveAstVisitor<void> {
  ComponentUsageVisitor(this.onComponent);

  final _OnComponent onComponent;

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    return visitInvocationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    return visitInvocationExpression(node);
  }

  void visitInvocationExpression(InvocationExpression node) {
    var usage = getComponentUsage(node);
    if (usage != null) {
      onComponent(usage);
    }

    node.visitChildren(this);
    return null;
  }
}

//
//class ComponentUsageElementVisitor extends RecursiveElementVisitor<void> {
//  final _OnComponent onComponent;
//
//  ComponentUsageElementVisitor(this.onComponent);
//
//  @override
//  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
//    return visitInvocationExpression(node);
//  }
//
//  @override
//  void visitMethodInvocation(MethodInvocation node) {
//    return visitInvocationExpression(node);
//  }
//
//  void visitInvocationExpression(InvocationExpression node) {
//    var usage = getComponentUsage(node);
//    if (usage != null) {
//      onComponent(usage);
//    }
//
//    node.visitChildren(this);
//    return null;
//  }
//}

class DiagnosticError {
  DiagnosticError(this.code, this.message, this.offset, this.end, this.severity, this.type, this.fixEdits, this.fixMessage, this.modificationStamp) {
    if (((offset == null) != (end == null)) ||
        ((offset == null) && fixEdits != null)) {
      throw new ArgumentError(
          'Offset, end and fixEdits must either all be null or all non-null. '
              'Got: offset $offset, end $end, fixEdits $fixEdits');
    }
  }

  /// The code of the error
  final String code;
  
  /// Error message for the user.
  final String message;

  /// Optionally, the offset of the incorrect code.
  final int offset;

  /// Optionally, the length of the incorrect code.
  final int end;

  final int modificationStamp;

  String fixMessage;

  List<SourceEdit> fixEdits;

  int get length => end - offset;

  AnalysisErrorSeverity severity;

  AnalysisErrorType type;

  bool get hasFix => fixEdits != null;
}
