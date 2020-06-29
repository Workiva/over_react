// Adapted from https://github.com/dart-lang/linter/blob/aab17d378181df057ca7dbd4f1b4889b3babad52/tool/doc.dart
//
// Copyright 2015, the Dart project authors. All rights reserved.
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

import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';

import 'doc_generation_utils/config.dart';
import 'doc_generation_utils/generate_assist_docs.dart';
import 'doc_generation_utils/generate_rule_docs.dart';
import 'doc_generation_utils/visitor.dart';

final logger = Logger('doc');

final configs = [
  DocsGenerationConfig(
    srcDir: 'diagnostic',
    outputSubDir: analyzerPluginLintDocsDir,
    registry: DiagnosticMetaRegistry.diagnosticRegistry,
    getSortedContributorMetas: () => RulesIndexer.rules,
    typeNameOfContributorClass: 'DiagnosticContributor',
    typeNameOfAnnotatedField: 'DiagnosticCode',
    getMeta: (el) => DocumentedDiagnosticContributorMeta.fromAnnotatedField(el),
    getPageGenerator: (meta) => RuleDocGenerator(meta as DocumentedDiagnosticContributorMeta),
    getIndexGenerator: () => RulesIndexer(),
    generateAdditionalDocs: (outDir) => OptionsSample(RulesIndexer.rules).generate(outDir),
  ),
  DocsGenerationConfig(
    srcDir: 'assist',
    outputSubDir: analyzerPluginAssistDocsDir,
    registry: AssistMetaRegistry.assistRegistry,
    getSortedContributorMetas: () => AssistsIndexer.assists,
    typeNameOfContributorClass: 'AssistContributorBase',
    typeNameOfAnnotatedField: 'AssistKind',
    packageNameContainingAnnotatedFieldType: 'analyzer_plugin',
    getMeta: (el) => DocumentedAssistContributorMeta.fromAnnotatedFieldAst(el),
    getPageGenerator: (meta) => AssistDocGenerator(meta as DocumentedAssistContributorMeta),
    getIndexGenerator: () => AssistsIndexer(),
  ),
];

/// Generates docs for the various lints/assists/etc. - for publishing to https://workiva.github.io/over_react/analyzer_plugin/
///
/// When running on a branch other than `gh-pages`, you can test the doc generation by running the script and
/// serving the `doc/` directory.
///
/// When it is run within the `gh-pages` branch, the output should be sent to the `docs/` directory along
/// with the other jekyll resources so that the documentation is included in what gets deployed by Github.
/// This can be done using the `--gh-pages` flag.
Future<void> main([List<String> args]) async {
  var parser = ArgParser()
    ..addOption('out', abbr: 'o', help: 'Specifies output directory.', defaultsTo: 'doc/analyzer_plugin')
    ..addFlag('gh-pages',
        help:
            'Output the files to the directory expected in the gh-pages branch. Should only be run in the gh-pages branch. Overrides any value passed to the `--out` option.');

  ArgResults options;
  try {
    options = parser.parse(args);
  } on FormatException catch (err) {
    printUsage(parser, err.message);
    return;
  }

  var outDir = options['out'] as String;
  final ghPages = options['gh-pages'] as bool;
  if (ghPages) {
    outDir = '../../analyzer_plugin';
  }

  await registerContributorMetadata(configs);

  for (final config in configs) {
    await generateDocs(outDir, config);
  }
}

void printUsage(ArgParser parser, [String error]) {
  var message = 'Generates lint/assist docs.';
  if (error != null) {
    message = error;
  }

  stdout.write('''$message
Usage: doc
${parser.usage}
''');
}

Future<void> generateDocs(String baseDir, DocsGenerationConfig config) async {
  var outDir = '$baseDir/${config.outputSubDir}';
  if (outDir != null) {
    final d = Directory(outDir);
    if (d.existsSync()) {
      d.deleteSync(recursive: true);
    }
    d.createSync(recursive: true);
  }

  // Generate the index ("landing") page for a certain type of contributor defined in the config
  config.getIndexGenerator().generate(outDir);

  // Generate a documentation page for each of the contributors registered in the config
  final sortedContributorMetas = config.getSortedContributorMetas();
  for (final contributorMeta in sortedContributorMetas) {
    config.getPageGenerator(contributorMeta).generate(outDir);
  }

  config.generateAdditionalDocs?.call(outDir);
}
