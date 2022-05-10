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

import 'package:markdown/markdown.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';

import '../doc.dart' show logger;
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
      logger.fine(generated);
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

            ${markdownToHtml(contributor.details!)}

         </section>
      </div>
      ${getSharedIndexBodyFooter()}
   </body>
</html>
''';

  String generateAdditionalContributorHeaderSections() => '';
}
