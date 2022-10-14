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
import 'dart:collection';

import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart' as analyzer;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/context_builder.dart' show ContextBuilderImpl;

// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/driver.dart' show AnalysisDriver, AnalysisDriverGeneric;
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
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
import 'package:over_react_analyzer_plugin/src/diagnostic/forward_only_dom_props_to_dom_builders.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/hooks_exhaustive_deps.dart';
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

import 'assist/contributor_base.dart';

enum RunMode {
  resolved,
  unresolved,
}

abstract class OverReactAnalyzerPluginBase extends ServerPlugin
    with
        // Don't mix in anything Dart.+Mixin from analyzer_plugin, since it might request resolved results when we don't want it to.
//    OutlineMixin, DartOutlineMixin,
        DiagnosticMixin,
        // NavigationMixin,
        // DartNavigationMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin {
  OverReactAnalyzerPluginBase(ResourceProvider provider) : super(provider);

  @override
  final pluginOptionsReader = PluginOptionsReader();

  RunMode get runMode => RunMode.unresolved;

  @override
  Future<PotentiallyResolvedDartAssistRequest> getAssistRequest(EditGetAssistsParams parameters) async {
    final path = parameters.file;
    final result = await getPotentiallyResolvedResult(path);
    return DartPotentiallyResolvedDartAssistRequestImpl(resourceProvider, parameters.offset, parameters.length, result);
  }

  Future<PotentiallyResolvedResult> getPotentiallyResolvedResult(String path) async => runMode == RunMode.resolved
      ? PotentiallyResolvedResult.resolved(await getResolvedUnitResult(path))
      : PotentiallyResolvedResult.unresolved(getUnResolvedUnitResult(path));

  /// Return the result of analyzing the file with the given [path].
  ///
  /// Throw a [RequestFailure] is the file cannot be analyzed or if the driver
  /// associated with the file is not an [AnalysisDriver].
  ParsedUnitResult getUnResolvedUnitResult(String path) {
    var driver = driverForPath(path);
    if (driver is! AnalysisDriver) {
      // Return an error from the request.
      throw RequestFailure(RequestErrorFactory.pluginError('Failed to parse $path', null));
    }
    var result = driver.getFileSync2(path);
    if (result is! ParsedUnitResult) {
      // Return an error from the request.
      throw RequestFailure(RequestErrorFactory.pluginError('Failed to parse $path', null));
    }
    return result;
  }

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

  // FIXME(greg) clean all this up, maybe find a better way
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
      HooksExhaustiveDeps(
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
  OverReactAnalyzerPlugin(ResourceProvider provider) : super(provider) {
    runZonedGuarded(() {
      _unresolvedWorker.pathsStream
          .map((p) => (driverForPath(p) as AnalysisDriver).parseFileSync2(p))
          .whereType<ParsedUnitResult>()
          .map((p) => PotentiallyResolvedResult.unresolved(p))
          .listen(processDiagnosticsForResult);
    }, _handleErrorAsNotification);
  }

  void _handleErrorAsNotification(Object error, StackTrace stackTrace) => channel
      .sendNotification(plugin.PluginErrorParams(false, error.toString(), stackTrace.toString()).toNotification());

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

    switch (runMode) {
      case RunMode.resolved:
        runZonedGuarded(() {
          driver.results.map((r) => PotentiallyResolvedResult.resolved(r)).listen(processDiagnosticsForResult);
        }, _handleErrorAsNotification);
        break;
      case RunMode.unresolved:
        runZonedGuarded(() {
          driver.results.listen((r) {
            throw StateError('Resolved AST was requested while in unresolved mode.'
                ' This is a bug; please report it alongside the provided stacktrace'
                ' to #support-ui-platform or via a GitHub issue in over_react.');
          });
        }, _handleErrorAsNotification);
        break;
    }

    return driver;
  }

  final _unresolvedWorker = UnresolvedUnitWorker();

  @override
  void contentChanged(String path) {
    if (runMode == RunMode.resolved) {
      super.driverForPath(path)!.addFile(path);
    } else {
      _unresolvedWorker.addPriorityPath(path);
    }
  }

  /// Handle an 'analysis.setContextRoots' request.
  ///
  /// Throw a [RequestFailure] if the request could not be handled.
  @override
  Future<AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(AnalysisSetContextRootsParams parameters) async {
    var contextRoots = parameters.roots;
    var oldRoots = driverMap.keys.toList();
    for (final contextRoot in contextRoots) {
      if (!oldRoots.remove(contextRoot)) {
        // The context is new, so we create a driver for it. Creating the driver
        // has the side-effect of adding it to the analysis driver scheduler.
        var driver = createAnalysisDriver(contextRoot);
        driverMap[contextRoot] = driver;
        _addFilesToDriver(driver, resourceProvider.getResource(contextRoot.root), contextRoot.exclude);
      }
    }
    for (final contextRoot in oldRoots) {
      // The context has been removed, so we remove its driver.
      var driver = driverMap.remove(contextRoot);
      // The `dispose` method has the side-effect of removing the driver from
      // the analysis driver scheduler.
      driver?.dispose();
    }

    _updatePriorityFiles();

    return AnalysisSetContextRootsResult();
  }

  /// Add all of the files contained in the given [resource] that are not in the
  /// list of [excluded] resources to the given [driver].
  void _addFilesToDriver(AnalysisDriverGeneric driver, Resource resource, List<String> excluded) {
    var path = resource.path;
    if (excluded.contains(path)) {
      return;
    }
    if (resource is File) {
      if (runMode == RunMode.resolved) {
        driver.addFile(path);
      } else {
        _unresolvedWorker.addPath(path);
      }
    } else if (resource is Folder) {
      try {
        for (var child in resource.getChildren()) {
          _addFilesToDriver(driver, child, excluded);
        }
      } on FileSystemException {
        // The folder does not exist, so ignore it.
      }
    }
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
    if (runMode == RunMode.resolved) {
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
          var driver = driverMap[contextRoot]!;
          filesByDriver.putIfAbsent(driver, () => <String>[]).add(file);
        }
      }
      filesByDriver.forEach((driver, files) {
        driver.priorityFiles = files;
      });
    } else {
      _filesFromSetPriorityFilesRequest.reversed.forEach(_unresolvedWorker.addPriorityPath);
    }
  }
}

class UnresolvedUnitWorker {
  final _queue = Queue<String>();

  void addPath(String path) {
    if (!_queue.contains(path)) {
      _queue.add(path);
      _sc.add(null);
    }
  }

  void addPriorityPath(String path) {
    _queue.remove(path);
    _queue.addFirst(path);
    _sc.add(null);
  }

  void removePath(String path) {}

  late final _sc = StreamController<void>();

  Stream<String> get pathsStream => _sc.stream.asyncExpand((_) async* {
        if (_queue.isNotEmpty) {
          yield _queue.removeFirst();
        }
      });
}

extension<E> on Stream<E> {
  Stream<T> whereType<T extends E>() => where((e) => e is T).cast();
}
