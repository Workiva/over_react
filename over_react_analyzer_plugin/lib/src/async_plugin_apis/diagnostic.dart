// Based heavily on https://github.com/google/built_value.dart/blob/master/built_value_generator/lib/src/plugin/plugin.dart,
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

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
// ignore: implementation_imports
import 'package:analyzer_plugin/src/utilities/fixes/fixes.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

mixin DiagnosticMixin on ServerPlugin {
  List<DiagnosticContributor> getDiagnosticContributors(String path);

  /// Computes errors based on an analysis result and notifies the analyzer.
  Future<void> processDiagnosticsForResult(ResolvedUnitResult analysisResult) async {
    try {
      // If there is no relevant analysis result, notify the analyzer of no errors.
      if (analysisResult.unit == null || analysisResult.libraryElement == null) {
        channel.sendNotification(plugin.AnalysisErrorsParams(analysisResult.path, []).toNotification());
      } else {
        // If there is something to analyze, do so and notify the analyzer.
        // Note that notifying with an empty set of errors is important as
        // this clears errors if they were fixed.
        final generator = DiagnosticGenerator(getDiagnosticContributors(analysisResult.path));
        final result = await generator.generateErrors(analysisResult);
        channel.sendNotification(plugin.AnalysisErrorsParams(analysisResult.path, result.result).toNotification());
        result.sendNotifications(channel);
      }
    } catch (e, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(plugin.EditGetFixesParams parameters) async {
    // We want request errors to propagate if they throw
    final request = await _getFixesRequest(parameters);
    try {
      final generator = DiagnosticGenerator(getDiagnosticContributors(parameters.file));
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
  Future<FixesRequest> _getFixesRequest(EditGetFixesParams parameters) async {
    final path = parameters.file;
    final offset = parameters.offset;
    final result = await getResolvedUnitResult(path);
    return DartFixesRequestImpl(resourceProvider, offset, null, result);
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
