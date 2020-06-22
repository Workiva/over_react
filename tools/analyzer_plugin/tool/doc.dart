// Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';

import 'doc_generation_utils/config.dart';
import 'doc_generation_utils/generate_assist_docs.dart';
import 'doc_generation_utils/generate_rule_docs.dart';
import 'doc_generation_utils/visitor.dart';

final configs = [
  DocsGenerationConfig(
    srcDir: 'diagnostic',
    outputSubDir: 'lints',
    registry: DiagnosticMetaRegistry.diagnosticRegistry,
    getSortedContributorMetas: () => RulesIndexer.rules,
    typeNameOfContributorClass: 'DiagnosticContributor',
    typeNameOfAnnotatedField: 'DiagnosticCode',
    getMeta: (el) => DocumentedDiagnosticContributorMeta.fromAnnotatedFieldAst(el),
    getPageGenerator: (meta) => RuleDocGenerator(meta),
    getIndexGenerator: () => RulesIndexer(),
    generateAdditionalDocs: (outDir) => OptionsSample(RulesIndexer.rules).generate(outDir),
  ),
  DocsGenerationConfig(
    srcDir: 'assist',
    outputSubDir: 'assists',
    registry: AssistMetaRegistry.assistRegistry,
    getSortedContributorMetas: () => AssistsIndexer.assists,
    typeNameOfContributorClass: 'AssistContributorBase',
    typeNameOfAnnotatedField: 'AssistKind',
    packageNameContainingAnnotatedFieldType: 'analyzer_plugin',
    getMeta: (el) => DocumentedAssistContributorMeta.fromAnnotatedFieldAst(el),
    getPageGenerator: (meta) => AssistDocGenerator(meta),
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
    ..addFlag('gh-pages', help: 'Output the files to the directory expected in the gh-pages branch. Should only be run in the gh-pages branch. Overrides any value passed to the `--out` option.');

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

  cleanOutputDirs(outDir);

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

void cleanOutputDirs(String outDir) {
  final htmlFilesToClean = Glob('$outDir/*/**.html').listSync();
  htmlFilesToClean.forEach((f) => File(f.path).deleteSync());
}

Future<void> generateDocs(String baseDir, DocsGenerationConfig config) async {
  var outDir = '$baseDir/${config.outputSubDir}';
  if (outDir != null) {
    final d = Directory(outDir);
    if (!d.existsSync()) {
      print("Directory '${d.path}' does not exist");
      return;
    }
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
