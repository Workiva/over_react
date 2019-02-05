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

import 'package:analyzer/file_system/file_system.dart';
// ignore: implementation_imports
import 'package:analyzer/src/context/builder.dart';
// ignore: implementation_imports
import 'package:analyzer/src/context/context_root.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/outline_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/utilities/outline/outline.dart';
import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:over_react_analyzer_plugin/src/assist/add_ref.dart';
import 'package:over_react_analyzer_plugin/src/assist/wrap_unwrap.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/checker.dart';

/// Analyzer plugin for over_react.
class OverReactAnalyzerPlugin extends ServerPlugin with OutlineMixin, DartOutlineMixin, AsyncAssistsMixin, AsyncDartAssistsMixin {
  final Checker checker = new Checker();

  OverReactAnalyzerPlugin(ResourceProvider provider) : super(provider);

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    final root = new ContextRoot(contextRoot.root, contextRoot.exclude,
        pathContext: resourceProvider.pathContext)
      ..optionsFilePath = contextRoot.optionsFile;
    final contextBuilder =
        new ContextBuilder(resourceProvider, sdkManager, null)
          ..analysisDriverScheduler = analysisDriverScheduler
          ..byteStore = byteStore
          ..performanceLog = performanceLog
          ..fileContentOverlay = fileContentOverlay;
    final result = contextBuilder.buildDriver(root);
    result.results.listen(_processResult);
    return result;
  }

  @override
  List<String> get fileGlobsToAnalyze => const ['*.dart'];

  @override
  String get name => 'over_react';

  // This is the protocol version, not the plugin version. It must match the
  // protocol version of the `analyzer_plugin` package.
  @override
  String get version => '1.0.0-alpha.0';

  @override
  String get contactInfo => 'https://github.com/Workiva/over_react/issues';

//  List<ErrorConntributor> get

  /// Computes errors based on an analysis result and notifies the analyzer.
  void _processResult(AnalysisResult analysisResult) {
    try {
      // If there is no relevant analysis result, notify the analyzer of no errors.
      if (analysisResult.unit == null ||
          analysisResult.libraryElement == null) {
        channel.sendNotification(
            new plugin.AnalysisErrorsParams(analysisResult.path, [])
                .toNotification());
      } else {

        // If there is something to analyze, do so and notify the analyzer.
        // Note that notifying with an empty set of errors is important as
        // this clears errors if they were fixed.
        final checkResult = checker.check(analysisResult);
        channel.sendNotification(new plugin.AnalysisErrorsParams(
                analysisResult.path, checkResult.keys.toList())
            .toNotification());
      }
    } catch (e, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(new plugin.PluginErrorParams(
              false, e.toString(), stackTrace.toString())
          .toNotification());
    }
  }

  @override
  void contentChanged(String path) {
    super.driverForPath(path).addFile(path);
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
      plugin.EditGetFixesParams parameters) async {
    try {
      final analysisResult =
          await (driverForPath(parameters.file) as AnalysisDriver)
              .getResult(parameters.file);
      // Get errors and fixes for the file.
      final checkResult = checker.check(analysisResult);

      // Return any fixes that are for the expected file and within the given offset.
      final fixes = <plugin.AnalysisErrorFixes>[];
      for (final error in checkResult.keys) {
        final fix = checkResult[error];
        if (error.location.file == parameters.file && fix != null) {
          if (parameters.offset >= error.location.offset && parameters.offset <= error.location.offset + error.location.length) {
            fixes.add(new plugin.AnalysisErrorFixes(error, fixes: [fix]));
          }
        }
      }

      return new plugin.EditGetFixesResult(fixes);
    } catch (e, stackTrace) {
      // Notify the analyzer that an exception happened.
      channel.sendNotification(new plugin.PluginErrorParams(
              false, e.toString(), stackTrace.toString())
          .toNotification());
      return new plugin.EditGetFixesResult([]);
    }
  }

  @override
  List<OutlineContributor> getOutlineContributors(String path) {
    return [
      // Disabled for now since it doesn't seem to work consistently
//      new ReactElementOutlineContributor(),
    ];
  }

  @override
  List<AsyncAssistContributor> getAssistContributors(String path) {
    return [
      new AddPropsAssistContributor(),
      new AddRefAssistContributor(),
      new WrapUnwrapAssistContributor(),
    ];
  }
}
