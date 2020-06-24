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
import 'package:analyzer_plugin/plugin/navigation_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/utilities/navigation/navigation.dart';
import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref_assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/extract_component.dart';
import 'package:over_react_analyzer_plugin/src/assist/wrap_unwrap.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/arrow_function_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/boilerplate_validator.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/bool_prop_name_readability.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/bad_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/callback_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/consumed_props_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/forward_only_dom_props_to_dom_builders.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/link_target_without_rel.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/proptypes_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/incorrect_doc_comment_location.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/dom_prop_types.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/duplicate_prop_cascade.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/iterator_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_cascade_parens.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/pseudo_static_lifecycle.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/render_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/string_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/style_missing_unit.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/variadic_children.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/single_child_key.dart';

/// Analyzer plugin for over_react.
class OverReactAnalyzerPlugin extends ServerPlugin
    with
//    OutlineMixin, DartOutlineMixin,
        DiagnosticMixin,
        NavigationMixin,
        DartNavigationMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin {
  OverReactAnalyzerPlugin(ResourceProvider provider) : super(provider);

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    final root = ContextRoot(contextRoot.root, contextRoot.exclude, pathContext: resourceProvider.pathContext)
      ..optionsFilePath = contextRoot.optionsFile;
    final contextBuilder = ContextBuilder(resourceProvider, sdkManager, null)
      ..analysisDriverScheduler = analysisDriverScheduler
      ..byteStore = byteStore
      ..performanceLog = performanceLog
      ..fileContentOverlay = fileContentOverlay;
    final result = contextBuilder.buildDriver(root);
    runZoned(() {
      result.results.listen(processDiagnosticsForResult);
    }, onError: (e, stackTrace) {
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
    });
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
  String get contactInfo => 'Workiva Slack channel: #react-analyzer-plugin';

  @override
  void contentChanged(String path) {
    super.driverForPath(path).addFile(path);
  }

  //  @override
//  List<OutlineContributor> getOutlineContributors(String path) {
//    return [
  // Disabled for now since it doesn't seem to work consistently
//      new ReactElementOutlineContributor(),
//    ];
//  }

  @override
  List<AsyncAssistContributor> getAssistContributors(String path) {
    return [
      AddPropsAssistContributor(),
      AddCreateRefAssistContributor(),
      ExtractComponentAssistContributor(),
      ExtractStatefulComponentAssistContributor(),
      WrapUnwrapAssistContributor(),
    ];
  }

  @override
  List<NavigationContributor> getNavigationContributors(String path) {
    return [];
  }

  @override
  List<DiagnosticContributor> getDiagnosticContributors(String path) {
    return [
      PropTypesReturnValueDiagnostic(),
      DuplicatePropCascadeDiagnostic(),
      LinkTargetUsageWithoutRelDiagnostic(),
      BadKeyDiagnostic(),
      VariadicChildrenDiagnostic(),
      ArrowFunctionPropCascadeDiagnostic(),
      RenderReturnValueDiagnostic(),
      InvalidChildDiagnostic(),
      StringRefDiagnostic(),
      CallbackRefDiagnostic(),
      MissingCascadeParensDiagnostic(),
      MissingRequiredPropDiagnostic(),
      PseudoStaticLifecycleDiagnostic(),
      InvalidDomAttributeDiagnostic(),
      BoolPropNameReadabilityDiagnostic(),
      StyleMissingUnitDiagnostic(),
      BoilerplateValidatorDiagnostic(),
      SingleChildWithKey(),
      IncorrectDocCommentLocationDiagnostic(),
      ConsumedPropsReturnValueDiagnostic(),
      ForwardOnlyDomPropsToDomBuildersDiagnostic(),
      IteratorKey(),
    ];
  }

  @override
  Future<plugin.AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
      plugin.AnalysisSetContextRootsParams parameters) async {
    final result = await super.handleAnalysisSetContextRoots(parameters);
    // The super-call adds files to the driver, so we need to prioritize them so they get analyzed.
    _updatePriorityFiles();
    return result;
  }

  List<String> _filesFromSetPriorityFilesRequest = [];

  @override
  Future<plugin.AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(
      plugin.AnalysisSetPriorityFilesParams parameters) async {
    _filesFromSetPriorityFilesRequest = parameters.files;
    _updatePriorityFiles();
    return plugin.AnalysisSetPriorityFilesResult();
  }

  /// AnalysisDriver doesn't fully resolve files that are added via `addFile`; they need to be either explicitly requested
  /// via `getResult`/etc, or added to `priorityFiles`.
  ///
  /// This method updates `priorityFiles` on the driver to include:
  ///
  /// - Any files prioritized by the analysis server via [handleAnalysisSetPriorityFiles]
  /// - All other files the driver has been told to analyze via addFile (in [ServerPlugin.handleAnalysisSetContextRoots])
  ///
  /// As a result, [processDiagnosticsForResult] will get called with resolved units, and thus all of our diagnostics
  /// will get run on all files in the repo instead of only the currently open/edited ones!
  void _updatePriorityFiles() {
    final filesToFullyResolve = {
      // Ensure these go first, since they're actually considered priority; ...
      ..._filesFromSetPriorityFilesRequest,

      /// ... all other files need to be analyzed, but don't trump priority/
      for (var driver2 in driverMap.values) ...(driver2 as AnalysisDriver).addedFiles,
    };

    // From ServerPlugin.handleAnalysisSetPriorityFiles
    final filesByDriver = <AnalysisDriverGeneric, List<String>>{};
    for (final file in filesToFullyResolve) {
      var contextRoot = contextRootContaining(file);
      if (contextRoot != null) {
        // TODO(brianwilkerson) Which driver should we use if there is no context root?
        var driver = driverMap[contextRoot];
        filesByDriver.putIfAbsent(driver, () => <String>[]).add(file);
      }
    }
    filesByDriver.forEach((driver, files) {
      driver.priorityFiles = files;
    });
  }
}
