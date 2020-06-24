import 'dart:io';

import 'package:meta/meta.dart';

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
      print('Writing to $outPath');
      File(outPath).writeAsStringSync(generated);
    } else {
      print(generated);
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