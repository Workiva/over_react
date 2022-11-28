// Adapted from https://github.com/google/built_value.dart/blob/fc689b41f7a62ee7622a16123412c3b9310185a6/built_value_generator/lib/src/plugin/plugin.dart
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

import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart' as analyzer;
import 'package:analyzer/file_system/file_system.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/context_builder.dart' show ContextBuilderImpl;
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/driver.dart' show AnalysisDriver, AnalysisDriverGeneric;
import 'package:analyzer_plugin/plugin/navigation_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/utilities/navigation/navigation.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/reader.dart';
import 'package:over_react_analyzer_plugin/src/assist/add_props.dart';
import 'package:over_react_analyzer_plugin/src/assist/convert_class_or_function_component.dart';
import 'package:over_react_analyzer_plugin/src/assist/extract_component.dart';
import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref_assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/toggle_stateful.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/arrow_function_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/bad_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/boilerplate_validator.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/callback_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/consumed_props_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/create_ref_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/dom_prop_types.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/duplicate_prop_cascade.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/exhaustive_deps.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/forward_only_dom_props_to_dom_builders.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/incorrect_doc_comment_location.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/iterator_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/link_target_without_rel.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_cascade_parens.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/non_defaulted_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/proptypes_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/pseudo_static_lifecycle.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/render_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/rules_of_hooks.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/string_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/style_value_diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/variadic_children.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/variadic_children_with_keys.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

abstract class OverReactAnalyzerPluginBase extends ServerPlugin
    with
//    OutlineMixin, DartOutlineMixin,
        DiagnosticMixin,
        NavigationMixin,
        DartNavigationMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin {
  OverReactAnalyzerPluginBase(ResourceProvider provider) : super(provider);

  @override
  final pluginOptionsReader = PluginOptionsReader();

  @override
  List<String> get fileGlobsToAnalyze => const ['*.dart'];

  // This is the protocol version, not the plugin version. It must match the
  // protocol version of the `analyzer_plugin` package.
  @override
  String get version => '1.0.0-alpha.0';

  @override
  List<AsyncAssistContributor> getAssistContributors(String path) => [
        AddPropsAssistContributor(),
        AddUseOrCreateRefAssistContributor(),
        ExtractComponentAssistContributor(),
        ExtractStatefulComponentAssistContributor(),
        ToggleComponentStatefulness(),
        ConvertClassOrFunctionComponentAssistContributor(),
        // TODO re-enable this when it's more polished
//        WrapUnwrapAssistContributor(),
      ];

  @override
  List<NavigationContributor> getNavigationContributors(String path) => [];

  // TODO(greg) is there a better way to do this?
  analyzer.ContextRoot? _analyzerContextRootForPath(String path) {
    final driver = driverForPath(path);
    if (driver == null) return null;

    // TODO should this throw?
    if (driver is! AnalysisDriver) return null;

    return driver.analysisContext?.contextRoot;
  }

  PluginAnalysisOptions? optionsForPath(String path) {
    // Do not use protocol.ContextRoot's optionsFile, since it's null at least in tests.
    // We'll use te driver's context instead.
    final contextRoot = _analyzerContextRootForPath(path);
    if (contextRoot == null) return null;
    return pluginOptionsReader.getOptionsForContextRoot(contextRoot);
  }

  @override
  List<DiagnosticContributor> getDiagnosticContributors(String path) {
    final options = optionsForPath(path);
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
      // TODO: Re-enable this once consumers can disable lints via analysis_options.yaml
//      MissingRequiredPropDiagnostic(),
      PseudoStaticLifecycleDiagnostic(),
      InvalidDomAttributeDiagnostic(),
      // TODO: Re-enable this once consumers can disable lints via analysis_options.yaml
//        BoolPropNameReadabilityDiagnostic(),
      StyleValueDiagnostic(),
      BoilerplateValidatorDiagnostic(),
      VariadicChildrenWithKeys(),
      IncorrectDocCommentLocationDiagnostic(),
      ConsumedPropsReturnValueDiagnostic(),
      ForwardOnlyDomPropsToDomBuildersDiagnostic(),
      IteratorKey(),
      RulesOfHooks(),
      ExhaustiveDeps(
        additionalHooksPattern: options?.exhaustiveDepsAdditionalHooksPattern,
      ),
      NonDefaultedPropDiagnostic(),
      CreateRefUsageDiagnostic(),
    ];
  }

  // @override
  // List<OutlineContributor> getOutlineContributors(String path) => [
  //       // Disabled for now since it doesn't seem to work consistently
  //       new ReactElementOutlineContributor(),
  //     ];
}

/// Analyzer plugin for over_react.
class OverReactAnalyzerPlugin extends OverReactAnalyzerPluginBase {
  OverReactAnalyzerPlugin(ResourceProvider provider) : super(provider);

  @override
  String get name => 'over_react';

  @override
  String get contactInfo => 'Workiva Slack channel: #react-analyzer-plugin';

  @override
  AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {
    final root = ContextLocator(resourceProvider: resourceProvider).locateRoots(
      includedPaths: [contextRoot.root],
      excludedPaths: contextRoot.exclude,
      optionsFile: contextRoot.optionsFile,
    ).single;
    final contextBuilder = ContextBuilder(resourceProvider: resourceProvider) as ContextBuilderImpl;
    final context = contextBuilder.createContext(
      contextRoot: root,
      scheduler: analysisDriverScheduler,
      byteStore: byteStore,
      performanceLog: performanceLog,
    );
    final driver = context.driver;
    try {
      driver.currentSession.analysisContext;
    } catch (_) {
      channel.sendNotification(
          plugin.PluginErrorParams(false, 'Error fetching analysis context; assists may be unavailable', '')
              .toNotification());
    }
    runZonedGuarded(() {
      driver.results.listen((result) {
        final path = result.path;
        if (path != null) {
          // FIXME this will definitely have race conditions with contentChanged
          _alreadyResolvedFiles.add(path);
        }
        processDiagnosticsForResult(result);
      });
    }, (e, stackTrace) {
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
    });
    return driver;
  }

  @override
  void contentChanged(String path) {
    _alreadyResolvedFiles.remove(path);
    // FIXME take ignores into account here
    super.driverForPath(path)!.addFile(path);
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

  final _alreadyResolvedFiles = <String>{};

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
      for (var driver2 in driverMap.values) ...(driver2 as AnalysisDriver).addedFiles.difference(_alreadyResolvedFiles),
    };

    filesToFullyResolve.removeWhere((f) => f.contains('/graph_app/test/'));

    // From ServerPlugin.handleAnalysisSetPriorityFiles
    final filesByDriver = <AnalysisDriverGeneric, List<String>>{};
    for (final file in filesToFullyResolve) {
      var contextRoot = contextRootContaining(file);
      if (contextRoot != null) {
        // TODO(brianwilkerson) Which driver should we use if there is no context root?
        var driver = driverMap[contextRoot]!;
        filesByDriver.putIfAbsent(driver, () => <String>[]).add(file);
      }
    }
    filesByDriver.forEach((driver, files) {
      driver.priorityFiles = files;
    });
  }
}
