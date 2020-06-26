import 'dart:io';

import 'package:meta/meta.dart';

import '../doc.dart' show logger;
import 'shared_html.dart';

abstract class ContributorIndexer {
  final String pageTitle;
  final String bodySubtitle;
  ContributorIndexer({
    @required this.pageTitle,
    @required this.bodySubtitle,
  });

  void generate(String filePath) {
    var generated = _generate();
    if (filePath != null) {
      var outPath = '$filePath/index.html';
      logger.fine('Writing to $outPath');
      File(outPath)
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(generated);
    } else {
      logger.fine(generated);
    }
  }

  String _generate() => '''
<!doctype html>
<html>
   <head>
      ${getSharedHead(pageTitle)}
   </head>
   <body>
      <div class="wrapper">
         ${getSharedIndexBodyHeader(bodySubtitle)}
         <section>

            ${generateContributorsIndexBodySection()}

         </section>
      </div>
      ${getSharedIndexBodyFooter()}
   </body>
</html>
''';

  String generateContributorsIndexBodySection();
}
