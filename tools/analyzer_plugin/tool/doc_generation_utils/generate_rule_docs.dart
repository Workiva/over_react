// // Adapted from https://github.com/dart-lang/linter/blob/aab17d378181df057ca7dbd4f1b4889b3babad52/tool/doc.dart
// //
// // Copyright 2015, the Dart project authors. All rights reserved.
// // Redistribution and use in source and binary forms, with or without
// // modification, are permitted provided that the following conditions are
// // met:
// //
// //     * Redistributions of source code must retain the above copyright
// //       notice, this list of conditions and the following disclaimer.
// //     * Redistributions in binary form must reproduce the above
// //       copyright notice, this list of conditions and the following
// //       disclaimer in the documentation and/or other materials provided
// //       with the distribution.
// //     * Neither the name of Google Inc. nor the names of its
// //       contributors may be used to endorse or promote products derived
// //       from this software without specific prior written permission.
// //
// // THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// // "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// // LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// // A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// // OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// // SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// // LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// // DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// import 'dart:io';
//
// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:markdown/markdown.dart';
// import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
// import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
// import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
//
// import '../doc.dart' show logger;
// import 'generate_contributor_doc_page.dart';
// import 'generate_contributor_type_index.dart';
// import 'shared_html.dart';
//
// class RuleDocGenerator extends ContributorDocPage<DocumentedDiagnosticContributorMeta> {
//   RuleDocGenerator(DocumentedDiagnosticContributorMeta contributor) : super(contributor);
//
//   @override
//   generateAdditionalContributorHeaderSections() => '''
// <p>Severity: ${contributor.severity}</p>
//   ''';
// }
//
// class RulesIndexer extends ContributorIndexer {
//   RulesIndexer() : super(pageTitle: 'OverReact Analyzer Plugin Lints', bodySubtitle: 'Lint Rules');
//
//   static final rules = List.of(DiagnosticMetaRegistry.diagnosticRegistry.meta, growable: false)..sort();
//
//   String get enumerateErrorRules =>
//       rules.where((r) => r.severity == AnalysisErrorSeverity.ERROR).map((r) => '${toDescription(r)}').join('\n\n');
//
//   String get enumerateWarningRules =>
//       rules.where((r) => r.severity == AnalysisErrorSeverity.WARNING).map((r) => '${toDescription(r)}').join('\n\n');
//
//   String get enumerateInfoRules =>
//       rules.where((r) => r.severity == AnalysisErrorSeverity.INFO).map((r) => '${toDescription(r)}').join('\n\n');
//
//   String get enumerateSeverities =>
//       AnalysisErrorSeverity.VALUES.map((severity) => '<li><strong>${severity.name}</strong></li>').join('\n');
//
//   @override
//   String generateContributorsIndexBodySection() => '''
// <h1 id="supported-lints">Supported Lint Rules</h1>
// <p>
//    This list is auto-generated from our sources.
// </p>
// <p>
//    ${markdownToHtml(ruleLeadMatter)}
// </p>
// <p>
//   <ul>
//     $enumerateSeverities
//   </ul>
// </p>
// <p>
//    ${markdownToHtml(ruleFootMatter)}
// </p>
//
// <h2 id="error-rules">Errors</h2>
//
//    $enumerateErrorRules
//
// <h2 id="warning-rules">Warnings</h2>
//
//    $enumerateWarningRules
//
// <h2 id="hint-rules">Hints</h2>
//
//    $enumerateInfoRules
// ''';
// }
//
// class OptionsSample {
//   Iterable<DocumentedDiagnosticContributorMeta> rules;
//   OptionsSample(this.rules);
//
//   void generate(String filePath) {
//     var generated = _generate();
//     if (filePath != null) {
//       var outPath = '$filePath/options/index.html';
//       final file = File(outPath);
//       if (file.parent.existsSync()) {
//         file.parent.deleteSync(recursive: true);
//       }
//       file.parent.createSync(recursive: true);
//
//       logger.fine('Writing to $outPath');
//       file.writeAsStringSync(generated);
//     } else {
//       logger.fine(generated);
//     }
//   }
//
//   String generateOptions() {
//     final sb = StringBuffer('''
// ```
// linter:
//   rules:
// ''');
//
//     var sortedRules = rules.where((r) => r.maturity != Maturity.deprecated).map((r) => r.name).toList()..sort();
//     for (final rule in sortedRules) {
//       sb.write('    - $rule\n');
//     }
//     sb.write('```');
//
//     return sb.toString();
//   }
//
//   String _generate() => '''
// <!doctype html>
// <html>
//    <head>
//       ${getSharedHead('Analysis Options Sample', relativePath: '../../')}
//    </head>
//   <body>
//       <div class="wrapper">
//          ${getSharedIndexBodyHeader('Analysis Options Sample')}
//          <section>
//
//             <h1 id="analysis-options">Analysis Options</h1>
//             <p>
//                Auto-generated options enabling all lints.
//                Add these to your
//                <a href="https://dart.dev/guides/language/analysis-options#the-analysis-options-file">analysis_options.yaml file</a>
//                and tailor to fit!
//             </p>
//
// ${markdownToHtml(generateOptions())}
//
//          </section>
//       </div>
//       ${getSharedIndexBodyFooter()}
//    </body>
// </html>
// ''';
// }
//
// // TODO: Once we figure out how to allow our plugin lints to be enabled/disabled via analysis_options.yaml, restore this:
// //
// //  Rules can be selectively enabled in the analyzer using
// //  [analysis options](https://pub.dev/packages/analyzer)
// //  or through an
// //  [analysis options file](https://dart.dev/guides/language/analysis-options#the-analysis-options-file).
// //
// //  * **An auto-generated list enabling all options is provided [here](options/).**
// const ruleFootMatter = '''
// In addition, rules can be further distinguished by *maturity*.  Unqualified
// rules are considered stable, while others may be marked **experimental**
// to indicate that they are under review.  Lints that are marked as **deprecated**
// should not be used and are subject to removal in future Linter releases.
//
// These rules are under active development.  Feedback is
// [welcome](https://github.com/Workiva/over_react/issues/new?labels=area-analyzer-plugin)!
// ''';
//
// const ruleLeadMatter = 'Rules are organized by severity.';
