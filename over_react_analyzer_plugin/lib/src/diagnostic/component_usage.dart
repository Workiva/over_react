// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';

export 'package:analyzer_plugin/protocol/protocol_common.dart' show AnalysisErrorType, AnalysisErrorSeverity;
export 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
export 'package:analyzer_plugin/utilities/fixes/fixes.dart' show FixKind;
export 'package:analyzer_plugin/utilities/range_factory.dart' show range;
export 'package:over_react_analyzer_plugin/src/component_usage.dart';
export 'package:over_react_analyzer_plugin/src/util/fix.dart';

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

/// An object used to produce errors and fixes.
///
/// Clients may implement this class when implementing plugins.
abstract class DiagnosticContributor {
  /// Contribute errors for the location in the file specified by the given
  /// [result] into the given [collector].
  Future<void> computeErrors(ResolvedUnitResult result, DiagnosticCollector collector);
}

extension ResultLocation on ResolvedUnitResult {
  Location location({
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
        throw ArgumentError.notNull('offset or range');
      }
      if (end != null && length != null) {
        throw ArgumentError('Cannot specify both `end` and `length`.');
      } else if (length != null) {
        end = offset + length;
      } else if (end != null) {
        length = end - offset;
      } else {
        end = offset;
        length = 0;
      }
    }

    final info = lineInfo.getLocation(offset);
    return Location(path, offset, length, info.lineNumber, info.columnNumber);
  }

  Location locationFor(SyntacticEntity entity) {
    return location(offset: entity.offset, length: entity.length);
  }
}

/// A class that generates errors and fixes for aa set of [contributors] for
/// a given result unit or fixes request.
@sealed
class DiagnosticGenerator {
  /// Initialize a newly created errors generator to use the given
  /// [contributors].
  DiagnosticGenerator(this.contributors);

  /// The contributors to be used to generate the errors.
  final List<DiagnosticContributor> contributors;

  /// Creates a 'analysis.errors' response for the the file specified
  /// by the given [unitResult]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<GeneratorResult<List<AnalysisError>>> generateErrors(ResolvedUnitResult unitResult) async {
    return _generateErrors(unitResult, DiagnosticCollectorImpl(shouldComputeFixes: false));
  }

  /// Creates an 'edit.getFixes' response for the location in the file specified
  /// by the given [request]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<GeneratorResult<EditGetFixesResult>> generateFixesResponse(DartFixesRequest request) async {
    // Recompute the errors and then emit the matching fixes

    final collector = DiagnosticCollectorImpl(shouldComputeFixes: true);
    final errorsResult = await _generateErrors(request.result, collector);
    final notifications = [...errorsResult.notifications];

    // Return any fixes that contain the given offset.
    // TODO use request.errorsToFix instead?
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
      }
    }

    return GeneratorResult(EditGetFixesResult(fixes), notifications);
  }

  Future<GeneratorResult<List<AnalysisError>>> _generateErrors(
      ResolvedUnitResult unitResult, DiagnosticCollectorImpl collector) async {
    final notifications = <Notification>[];
    for (final contributor in contributors) {
      try {
        await contributor.computeErrors(unitResult, collector);
      } catch (exception, stackTrace) {
        notifications.add(PluginErrorParams(false, exception.toString(), stackTrace.toString()).toNotification());
      }
    }

    // The analyzer normally filters out errors with "ignore" comments,
    // but it doesn't do it for plugin errors, so we need to do that here.
    final lineInfo = unitResult.unit.lineInfo;
    final filteredErrors =
    filterIgnores(collector.errors, lineInfo, () => IgnoreInfo.calculateIgnores(unitResult.content, lineInfo));

    return GeneratorResult(filteredErrors, notifications);
  }
}

/// An object that [DiagnosticContributor]s use to record errors and fixes.
@sealed
abstract class DiagnosticCollector {
  void addRawError(AnalysisError error, {PrioritizedSourceChange fix});

  void addError(ErrorCode code, Location location, {bool hasFix, List<Object> errorMessageArgs});

  ///
  /// use of `buildFileEdit`]` is recommended:
  /// // todo link to range/location tools
  ///
  ///     computeFix: () => buildFileEdit(result, (builder) {
  ///       builder.addSimpleInsertion(cascade.offset, '(');
  ///       builder.addSimpleInsertion(cascade.end, ')');
  ///     }),
  ///
  /// though you can still do it manually:
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
  Future<void> addErrorWithFix(ErrorCode code, Location location,
      {FixKind fixKind,
      FutureOr<SourceChange> Function() computeFix,
      List<Object> errorMessageArgs,
      List<Object> fixMessageArgs});
}

@protected
class DiagnosticCollectorImpl implements DiagnosticCollector {
  DiagnosticCollectorImpl({@required this.shouldComputeFixes});

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
  void addError(ErrorCode code, Location location,
      {bool hasFix = false,
      FixKind fixKind,
      SourceChange fixChange,
      List<Object> errorMessageArgs,
      List<Object> fixMessageArgs}) {
    PrioritizedSourceChange fix;
    if (fixChange != null) {
      if (fixChange.edits.isNotEmpty) {
        fixChange.message = _formatList(fixKind.message, fixMessageArgs);
        fix = PrioritizedSourceChange(fixKind.priority, fixChange);
      }
    }

    // fixme add hasFix
    final error = AnalysisError(
      code.errorSeverity,
      code.type,
      location,
      _formatList(code.message, errorMessageArgs),
      code.name,
      correction: null,
      hasFix: hasFix,
    );

    addRawError(error, fix: fix);
  }

  @override
  Future<void> addErrorWithFix(ErrorCode code, Location location,
      {FixKind fixKind,
      FutureOr<SourceChange> Function() computeFix,
      List<Object> errorMessageArgs,
      List<Object> fixMessageArgs}) async {
    addError(
      code,
      location,
      hasFix: true,
      fixKind: fixKind,
      fixChange: shouldComputeFixes ? await computeFix() : null,
      errorMessageArgs: errorMessageArgs,
      fixMessageArgs: fixMessageArgs,
    );
  }
}

abstract class ComponentUsageDiagnosticContributor extends DiagnosticContributor {
  // computeErrorsForUsage(result, collector, usage) async {
  Future<void> computeErrorsForUsage(
      ResolvedUnitResult result, DiagnosticCollector collector, FluentComponentUsage usage);

  @override
  Future<void> computeErrors(ResolvedUnitResult result, DiagnosticCollector collector) async {
    final usages = <FluentComponentUsage>[];
    result.unit.accept(ComponentUsageVisitor(usages.add));
    await Future.forEach(usages, (usage) => computeErrorsForUsage(result, collector, usage));
  }
}

class ComponentUsageVisitor extends RecursiveAstVisitor<void> {
  ComponentUsageVisitor(this.onComponent);

  final void Function(FluentComponentUsage) onComponent;

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    visitInvocationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    visitInvocationExpression(node);
  }

  void visitInvocationExpression(InvocationExpression node) {
    var usage = getComponentUsage(node);
    if (usage != null) {
      onComponent(usage);
    }

    node.visitChildren(this);
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

// From package:analyzer/src/generated/java_core.dart
// Copyright 2013, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
/// Inserts the given [arguments] into [pattern].
///
///     format('Hello, {0}!', ['John']) = 'Hello, John!'
///     format('{0} are you {1}ing?', ['How', 'do']) = 'How are you doing?'
///     format('{0} are you {1}ing?', ['What', 'read']) = 'What are you reading?'
String _formatList(String pattern, List<Object> arguments) {
  if (arguments == null || arguments.isEmpty) {
    assert(!pattern.contains(RegExp(r'\{(\d+)\}')), 'Message requires arguments, but none were provided.');
    return pattern;
  }
  return pattern.replaceAllMapped(RegExp(r'\{(\d+)\}'), (match) {
    final indexStr = match.group(1);
    final index = int.parse(indexStr);
    final arg = arguments[index];
    assert(arg != null);
    return arg?.toString();
  });
}
