import 'dart:io';

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:markdown/markdown.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';

import 'generate_contributor_doc_page.dart';
import 'generate_contributor_type_index.dart';
import 'shared_html.dart';

class RuleDocGenerator extends ContributorDocPage<DocumentedDiagnosticContributorMeta> {
  RuleDocGenerator(DocumentedDiagnosticContributorMeta contributor) : super(contributor);

  @override
  generateAdditionalContributorHeaderSections() => '''
<p>Severity: ${contributor.severity}</p>
  ''';
}

class RulesIndexer extends ContributorIndexer {
  RulesIndexer() : super(pageTitle: 'OverReact Analyzer Plugin Lints', bodySubtitle: 'Lint Rules');

  static final rules = List.of(DiagnosticMetaRegistry.diagnosticRegistry.meta, growable: false)..sort();

  String get enumerateErrorRules =>
      rules.where((r) => r.severity == AnalysisErrorSeverity.ERROR).map((r) => '${toDescription(r)}').join('\n\n');

  String get enumerateWarningRules =>
      rules.where((r) => r.severity == AnalysisErrorSeverity.WARNING).map((r) => '${toDescription(r)}').join('\n\n');

  String get enumerateInfoRules =>
      rules.where((r) => r.severity == AnalysisErrorSeverity.INFO).map((r) => '${toDescription(r)}').join('\n\n');

  String get enumerateSeverities =>
      AnalysisErrorSeverity.VALUES.map((severity) => '<li><strong>${severity.name}</strong></li>').join('\n');

  @override
  String generateContributorsIndexBodySection() => '''
<h1 id="supported-lints">Supported Lint Rules</h1>
<p>
   This list is auto-generated from our sources.
</p>
<p>
   ${markdownToHtml(ruleLeadMatter)}
</p>
<p>
  <ul> 
    $enumerateSeverities
  </ul>
</p>
<p>
   ${markdownToHtml(ruleFootMatter)}
</p>

<h2 id="error-rules">Errors</h2>

   $enumerateErrorRules

<h2 id="warning-rules">Warnings</h2>

   $enumerateWarningRules
                  
<h2 id="hint-rules">Hints</h2>

   $enumerateInfoRules
''';
}

class OptionsSample {
  Iterable<DocumentedDiagnosticContributorMeta> rules;
  OptionsSample(this.rules);

  void generate(String filePath) {
    var generated = _generate();
    if (filePath != null) {
      var outPath = '$filePath/options/index.html';
      print('Writing to $outPath');
      File(outPath)
        ..parent.deleteSync(recursive: true)
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(generated);
    } else {
      print(generated);
    }
  }

  String generateOptions() {
    final sb = StringBuffer('''
```
linter:
  rules:
''');

    var sortedRules = rules.where((r) => r.maturity != Maturity.deprecated).map((r) => r.name).toList()..sort();
    for (final rule in sortedRules) {
      sb.write('    - $rule\n');
    }
    sb.write('```');

    return sb.toString();
  }

  String _generate() => '''
<!doctype html>
<html>
   <head>
      ${getSharedHead('Analysis Options Sample', relativePath: '../../')}
   </head>
  <body>
      <div class="wrapper">
         ${getSharedIndexBodyHeader('Analysis Options Sample')}
         <section>

            <h1 id="analysis-options">Analysis Options</h1>
            <p>
               Auto-generated options enabling all lints.
               Add these to your
               <a href="https://dart.dev/guides/language/analysis-options#the-analysis-options-file">analysis_options.yaml file</a>
               and tailor to fit!
            </p>

${markdownToHtml(generateOptions())}

         </section>
      </div>
      ${getSharedIndexBodyFooter()}
   </body>
</html>
''';
}

// TODO: Once we figure out how to allow our plugin lints to be enabled/disabled via analysis_options.yaml, restore this:
//
//  Rules can be selectively enabled in the analyzer using
//  [analysis options](https://pub.dev/packages/analyzer)
//  or through an
//  [analysis options file](https://dart.dev/guides/language/analysis-options#the-analysis-options-file).
//
//  * **An auto-generated list enabling all options is provided [here](options/).**
const ruleFootMatter = '''
In addition, rules can be further distinguished by *maturity*.  Unqualified
rules are considered stable, while others may be marked **experimental**
to indicate that they are under review.  Lints that are marked as **deprecated**
should not be used and are subject to removal in future Linter releases.

These rules are under active development.  Feedback is
[welcome](https://github.com/Workiva/over_react/issues/new?labels=area-analyzer-plugin)!
''';

const ruleLeadMatter = 'Rules are organized by severity.';
