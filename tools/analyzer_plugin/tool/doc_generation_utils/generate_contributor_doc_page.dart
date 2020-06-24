import 'dart:io';

import 'package:markdown/markdown.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';

import 'shared_html.dart';

abstract class ContributorDocPage<T extends DocumentedContributorMetaBase> {
  final T contributor;
  ContributorDocPage(this.contributor);

  String get maturityString {
    switch (contributor.maturity) {
      case Maturity.deprecated:
        return '<span style="color:orangered;font-weight:bold;" >${contributor.maturity}</span>';
      case Maturity.experimental:
        return '<span style="color:hotpink;font-weight:bold;" >${contributor.maturity}</span>';
      default:
        return '${contributor.maturity}';
    }
  }

  void generate(String filePath) {
    var generated = _generate();
    if (filePath != null) {
      var outPath = '$filePath/${contributor.name}.html';

      logger.fine('Writing to $outPath');
      File(outPath).writeAsStringSync(generated);
    } else {
      print(generated);
    }
  }

  String _generate() => '''
<!doctype html>
<html>
   <head>
      ${getSharedHead(contributor.name)}
   </head>
   <body>
      <div class="wrapper">
         <header>
            <h1>${contributor.name}</h1>
            ${generateAdditionalContributorHeaderSections()}
            <p>Maturity: $maturityString</p>
            <p style="padding-bottom: 10px;">Since ${contributor.since}</p>
            <!--getBadges(name)-->
            <p class="view"><a href="$analyzerPluginRepoSrcUrl">View the Project on GitHub <small>workiva/over_react</small></a></p>
         </header>
         <section>

            ${markdownToHtml(contributor.details)}

         </section>
      </div>
      ${getSharedIndexBodyFooter()}
   </body>
</html>
''';

  String generateAdditionalContributorHeaderSections() => '';
}
