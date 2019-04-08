// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/generated/java_core.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';

export 'package:analyzer_plugin/protocol/protocol_common.dart' show AnalysisErrorType, AnalysisErrorSeverity;
export 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
export 'package:analyzer_plugin/utilities/fixes/fixes.dart' show FixKind;
export 'package:analyzer_plugin/utilities/range_factory.dart' show range;
export 'package:over_react_analyzer_plugin/src/component_usage.dart';

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
    if (range != null) {
      offset = range.offset;
      length = range.length;
      end = range.end;
    } else {
      if (offset == null) {
        throw new ArgumentError.notNull('offset or range');
      }
      if (end != null && length != null) {
        throw new ArgumentError('Cannot specify both `end` and `length`.');
      } else if (length != null) {
        end = offset + length;
      } else if (end != null) {
        length = end - offset;
      } else {
        end = offset;
        length = 0;
      }
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
  // todo use generatorResult
  /// Create an 'edit.getErrors' response for the location in the file specified
  /// by the given [request]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<GeneratorResult<List<AnalysisError>>> generateErrors(ResolvedUnitResult unitResult) async {
    final notifications = <Notification>[];
    final collector = new DiagnosticCollectorImpl(false);
    for (DiagnosticContributor contributor in contributors) {
      try {
        await contributor.computeErrors(unitResult, collector);
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

    return GeneratorResult(filteredErrors, notifications);
  }


  Future<GeneratorResult<EditGetFixesResult>> generateFixesResponse(DartFixesRequest request) async {
    final notifications = <Notification>[];
    final collector = new DiagnosticCollectorImpl(true);

    for (var contributor in contributors) {
      try {
        await contributor.computeErrors(request.result, collector);
      } catch (exception, stackTrace) {
        notifications.add(new PluginErrorParams(
                false, exception.toString(), stackTrace.toString())
            .toNotification());
      }
    }

    // Return any fixes that contain the given offset.
    final fixes = <AnalysisErrorFixes>[];
    for (var i = 0; i < collector.errors.length; i++) {
      final error = collector.errors[i];
      final errorStart = error.location.offset;
      final errorEnd = errorStart + error.location.length;

      // `<=` because we do want the end to be inclusive (you should get
      // the fix when your cursor is on the tail end of the error).
      if (request.offset >= errorStart && request.offset <= errorEnd) {
        fixes.add(AnalysisErrorFixes(
          error,
          fixes: [collector.fixes[i]],
        ));
        break;
      }
    }

    return GeneratorResult(new EditGetFixesResult(fixes), notifications);
  }
}


/// An object that [DiagnosticContributor]s use to record errors.
///
/// Clients may not extend, implement or mix-in this class.
abstract class DiagnosticCollector {
  void addRawError(AnalysisError error, {PrioritizedSourceChange fix});
  void addError(ErrorCode code, Location location, {bool hasFix, List<Object> errorMessageArgs});
  ///
  ///
  ///
  ///     computeFix: () {
  ///       final builder = new DartChangeBuilder(result.session);
  ///       await builder.addFileEdit(result.path, (builder) {
  ///         builder.addSimpleInsertion(cascade.offset, '(');
  ///         builder.addSimpleInsertion(cascade.end, ')');
  ///       });
  ///       return builder.sourceChange;
  ///     }
  ///
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
    if (fixChange != null) {
      if (fixChange.edits.isNotEmpty) {
        fixChange.message = formatList(fixKind.message, fixMessageArgs);
        fix = new PrioritizedSourceChange(fixKind.priority, fixChange);
      }
    }

    // fixme add hasFix
    final error = AnalysisError(
      code.errorSeverity,
      code.type,
      location,
      formatList(code.message, errorMessageArgs),
      code.name,
      correction: null,
      hasFix: hasFix,
    );

    addRawError(error, fix: fix);
  }

  @override
  Future<void> addErrorWithFix(ErrorCode code, Location location,
      {FixKind fixKind, FutureOr<SourceChange> computeFix(), List<
          Object> errorMessageArgs, List<Object> fixMessageArgs}) async {
    addError(code, location, hasFix: true,
      fixKind: fixKind,
      fixChange: shouldComputeFixes ? await computeFix() : null,
      errorMessageArgs: errorMessageArgs,
      fixMessageArgs: fixMessageArgs,);
  }
}


abstract class ComponentUsageDiagnosticContributor extends DiagnosticContributor {
  // computeErrorsForUsage(result, collector, usage) async {
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


/// The result produced by a generator.
///
/// Clients may not extend, implement or mix-in this class.
class GeneratorResult<T> {
  /// The result to be sent to the server, or `null` if there is no response, as
  /// when the generator is generating a notification.
  final T result;

  /// The notifications that should be sent to the server. The list will be empty
  /// if there are no notifications.
  final List<Notification> notifications;

  /// Initialize a newly created generator result with the given [result] and
  /// [notifications].
  GeneratorResult(this.result, this.notifications);

  /// Use the given communications [channel] to send the notifications to the
  /// server.
  void sendNotifications(PluginCommunicationChannel channel) {
    for (final notification in notifications) {
      channel.sendNotification(notification);
    }
  }
}
