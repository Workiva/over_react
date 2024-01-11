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

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:over_react_analyzer_plugin/src/analysis_options/error_severity_provider.dart';
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
import 'package:over_react_analyzer_plugin/src/diagnostic/missing_required_prop.dart';
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

mixin OverReactAnalyzerPluginBase
    on
        ServerPlugin,
//    OutlineMixin, DartOutlineMixin,
        DiagnosticMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin {
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
  List<DiagnosticContributor> getDiagnosticContributors(AnalysisContext analysisContext, String path) {
    // Do not use protocol.ContextRoot's optionsFile, since it's null at least in tests;
    // get it from analysisContext instead.
    final options = pluginOptionsReader.getOptionsForContextRoot(analysisContext.contextRoot);
    final severityProvider = AnalysisOptionsErrorSeverityProvider(options);

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
      MissingRequiredPropDiagnostic(
        // Disable validation of annotation required props by default.
        // Enabling this would be too noisy for existing code due to forwarded prop logic (FED-2034) not being
        // implemented yet, and due to these annotations never being validated up until this Diagnostic was enabled.
        lintForAnnotationRequiredProps:
            (severityProvider.severityForCode(MissingRequiredPropDiagnostic.annotationRequiredCode.name) ??
                    AnalysisOptionsSeverity.ignore) !=
                AnalysisOptionsSeverity.ignore,
      ),
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

  @override
  Future<void> analyzeFile({required AnalysisContext analysisContext, required String path}) async {
    if (!path.endsWith('.dart')) return;

    await runZonedGuarded(() async {
      final result = await analysisContext.currentSession.getResolvedUnit(path);
      if (result is ResolvedUnitResult) {
        await getAllErrors(result);
      }
    }, (e, stackTrace) {
      channel.sendNotification(plugin.PluginErrorParams(false, e.toString(), stackTrace.toString()).toNotification());
    });
  }
}

/// Analyzer plugin for over_react.
class OverReactAnalyzerPlugin extends ServerPlugin
    with
        DiagnosticMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin,
        OverReactAnalyzerPluginBase {
  OverReactAnalyzerPlugin(ResourceProvider provider) : super(resourceProvider: provider);

  @override
  String get name => 'over_react';

  @override
  String get contactInfo => 'Workiva Slack channel: #react-analyzer-plugin';
}
