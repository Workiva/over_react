// Adapted from package:built_value_generator's analyzer plugin:
// https://github.com/google/built_value.dart/blob/fc689b41f7a62ee7622a16123412c3b9310185a6/built_value_generator/lib/src/plugin/plugin.dart
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

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
// ignore: implementation_imports
import 'package:analyzer_plugin/src/utilities/fixes/fixes.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/error_filtering.dart';

mixin DiagnosticMixin on ServerPlugin {
  List<DiagnosticContributor> getDiagnosticContributors(String path);

  /// Computes errors based on an analysis result and notifies the analyzer.
  Future<void> processDiagnosticsForResult(ResolvedUnitResult analysisResult) async {
    await getAllErrors(analysisResult);
  }

  /// Computes errors based on an analysis result, notifies the analyzer, and
  /// then returns the list of errors.
  Future<List<AnalysisError>> getAllErrors(ResolvedUnitResult analysisResult) async {
    try {
      // If there is no relevant analysis result, notify the analyzer of no errors.
      if (analysisResult.unit == null) {
        channel.sendNotification(plugin.AnalysisErrorsParams(analysisResult.path!, []).toNotification());
        return [];
      }

      // If there is something to analyze, do so and notify the analyzer.
      // Note that notifying with an empty set of errors is important as
      // this clears errors if they were fixed.
      final generator = _DiagnosticGenerator(getDiagnosticContributors(analysisResult.path!));
      final result = await generator.generateErrors(analysisResult);
      channel.sendNotification(plugin.AnalysisErrorsParams(analysisResult.path!, result.result).toNotification());
      result.sendNotifications(channel);
      return result.result;
    } catch (e, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
      return [];
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(plugin.EditGetFixesParams parameters) async {
    // We want request errors to propagate if they throw
    final request = await _getFixesRequest(parameters);
    try {
      final generator = _DiagnosticGenerator(getDiagnosticContributors(parameters.file));
      final result = await generator.generateFixesResponse(request);
      result.sendNotifications(channel);
      return result.result;
    } catch (e, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
      return plugin.EditGetFixesResult([]);
    }
  }

  // from DartFixesMixin
  Future<DartFixesRequest> _getFixesRequest(EditGetFixesParams parameters) async {
    final path = parameters.file;
    final offset = parameters.offset;
    final result = await getResolvedUnitResult(path);
    return DartFixesRequestImpl(resourceProvider, offset, [], result);
  }

  // from DartFixesMixin
//  List<AnalysisError> _getErrors(int offset, ResolvedUnitResult result) {
//    LineInfo lineInfo = result.lineInfo;
//    int offsetLine = lineInfo.getLocation(offset).lineNumber;
  // these errors don't include ones from the plugin, which doesn't seem right...
//    return result.errors.where((AnalysisError error) {
//      int errorLine = lineInfo.getLocation(error.offset).lineNumber;
//      return errorLine == offsetLine;
//    }).toList();
//    return result.errors;
//  }
}

/// A class that generates errors and fixes for a set of [contributors] for
/// a given result unit or fixes request.
@sealed
class _DiagnosticGenerator {
  /// Initialize a newly created errors generator to use the given
  /// [contributors].
  _DiagnosticGenerator(this.contributors);

  /// The contributors to be used to generate the errors.
  final List<DiagnosticContributor> contributors;

  /// Creates a 'analysis.errors' response for the the file specified
  /// by the given [unitResult]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<_GeneratorResult<List<AnalysisError>>> generateErrors(ResolvedUnitResult unitResult) async {
    return _generateErrors(unitResult, DiagnosticCollectorImpl(shouldComputeFixes: false));
  }

  /// Creates an 'edit.getFixes' response for the location in the file specified
  /// by the given [request]. If any of the contributors throws an exception,
  /// also create a non-fatal 'plugin.error' notification.
  Future<_GeneratorResult<EditGetFixesResult>> generateFixesResponse(DartFixesRequest request) async {
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
        final fix = collector.fixes[i];
        if (fix != null) {
          fixes.add(AnalysisErrorFixes(
            error,
            fixes: [fix],
          ));
        }
      }
    }

    return _GeneratorResult(EditGetFixesResult(fixes), notifications);
  }

  Future<_GeneratorResult<List<AnalysisError>>> _generateErrors(
      ResolvedUnitResult unitResult, DiagnosticCollectorImpl collector) async {
    final notifications = <Notification>[];

    // Reuse component usages so we don't have to recompute them for each ComponentUsageDiagnosticContributor.
    List<FluentComponentUsage>? _usages;
    // Lazily compute the usage so any errors get handled as part of each diagnostic's try/catch.
    // TODO: collect data how long this takes.
    List<FluentComponentUsage> getUsages() => _usages ??= getAllComponentUsages(unitResult.unit!);

    for (final contributor in contributors) {
      try {
        if (contributor is ComponentUsageDiagnosticContributor) {
          await contributor.computeErrorsForUsages(unitResult, collector, getUsages());
        } else {
          await contributor.computeErrors(unitResult, collector);
        }
      } catch (exception, stackTrace) {
        notifications.add(PluginErrorParams(false, exception.toString(), stackTrace.toString()).toNotification());
      }
    }

    // The analyzer normally filters out errors with "ignore" comments,
    // but it doesn't do it for plugin errors, so we need to do that here.
    final filteredErrors = filterIgnores(
        collector.errors, unitResult.lineInfo, () => IgnoreInfo.forDart(unitResult.unit!, unitResult.content!));

    return _GeneratorResult(filteredErrors, notifications);
  }
}

/// The result produced by a generator.
///
/// Adapted from `GeneratorResult` in package:analyzer_plugin, but with less restrictive typing.
//
// Copyright 2017, the Dart project authors. All rights reserved.
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
@sealed
class _GeneratorResult<T> {
  /// The result to be sent to the server, or `null` if there is no response, as
  /// when the generator is generating a notification.
  final T result;

  /// The notifications that should be sent to the server. The list will be empty
  /// if there are no notifications.
  final List<Notification> notifications;

  /// Initialize a newly created generator result with the given [result] and
  /// [notifications].
  _GeneratorResult(this.result, this.notifications);

  /// Use the given communications [channel] to send the notifications to the
  /// server.
  void sendNotifications(PluginCommunicationChannel channel) {
    for (final notification in notifications) {
      channel.sendNotification(notification);
    }
  }
}
