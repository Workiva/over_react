// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:meta/meta.dart';

import 'component_usage.dart';

export 'package:analyzer_plugin/protocol/protocol_common.dart' show AnalysisErrorType, AnalysisErrorSeverity;
export 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
export 'package:analyzer_plugin/utilities/fixes/fixes.dart' show FixKind;
export 'package:analyzer_plugin/utilities/range_factory.dart' show range;
export 'package:over_react_analyzer_plugin/src/component_usage.dart';
export 'package:over_react_analyzer_plugin/src/util/fix.dart';
export 'package:over_react_analyzer_plugin/src/util/location.dart';

/// An error code associated with an [AnalysisError].
///
/// adapted from ErrorCode in _fe_analyzer_shared
class DiagnosticCode {
  /// Initialize a newly created error code to have the given [name]. The message
  /// associated with the error will be created from the given [message]
  /// template. The correction associated with the error will be created from the
  /// given [correction] template.
  const DiagnosticCode(this.name, this.message, this.errorSeverity, this.type, [this.correction]);

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

/// An object that [DiagnosticContributor]s use to record errors and fixes.
@sealed
abstract class DiagnosticCollector {
  void addRawError(AnalysisError error, {PrioritizedSourceChange fix});

  void addError(DiagnosticCode code, Location location, {bool hasFix, List<Object> errorMessageArgs});

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
  Future<void> addErrorWithFix(DiagnosticCode code, Location location,
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
  void addError(DiagnosticCode code, Location location,
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
  Future<void> addErrorWithFix(DiagnosticCode code, Location location,
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
