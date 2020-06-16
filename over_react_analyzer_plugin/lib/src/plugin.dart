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
import 'package:over_react_analyzer_plugin/src/diagnostic/bool_prop_name_readability.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/callback_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/dom_prop_types.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/duplicate_prop_cascade.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/hashcode_as_key.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_cascade_parens.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/pseudo_static_lifecycle.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/render_return_value.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/string_ref.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/style_missing_unit.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/variadic_children.dart';
import 'package:over_react_analyzer_plugin/src/navigation/prop_navigation_contributor.dart';

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
      ExtractFluxComponentAssistContributor(),
      ExtractFluxStatefulComponentAssistContributor(),
      WrapUnwrapAssistContributor(),
    ];
  }

  @override
  List<NavigationContributor> getNavigationContributors(String path) {
    return [
      /// NOTE: when developing in JetBrains IDEs, clear caches after reloading this
      /// plugin, or it may not request the latest navigation regions from this plugin.
      PropNavigationContributor(),
    ];
  }

  @override
  List<DiagnosticContributor> getDiagnosticContributors(String path) {
    return [
      DuplicatePropCascadeDiagnostic(),
      HashCodeAsKeyDiagnostic(),
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
    ];
  }
}
