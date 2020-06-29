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

import 'package:markdown/markdown.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';

String getSharedHead(String title, {String relativePath = '../'}) => '''
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<title>$title</title>
<link rel="stylesheet" href="${relativePath}stylesheets/styles.css">
<link rel="stylesheet" href="${relativePath}stylesheets/pygment_trac.css">
<script src="${relativePath}javascripts/scale.fix.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<!--[if lt IE 9]>
<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
''';

String getSharedIndexBodyHeader(String subTitle) => '''
<header>
  <a href="$analyzerPluginDocsUrl">
     <h1>OverReact Analyzer Plugin</h1>
  </a>
  <p>$subTitle</p>
  <p class="view"><a href="$analyzerPluginRepoSrcUrl">View the Project on GitHub <small>workiva/over_react</small></a></p>
  <ul>
     <li><a href="$analyzerPluginRepoSrcUrl">View On <strong>GitHub</strong></a></li>
  </ul>
</header>
''';

String getSharedIndexBodyFooter() => '''
<footer>
   <p>Project maintained by <a href="https://workiva.github.io/" target="_blank" rel="noopener noreferrer">Workiva</a></p>
   <p>Hosted on GitHub Pages &mdash; Theme by <a href="https://github.com/orderedlist" target="_blank" rel="noopener noreferrer">orderedlist</a></p>
</footer>
<!--[if !IE]><script>fixScale(document);</script><![endif]-->
''';

String qualify(DocumentedContributorMetaBase r) => r.name.toString() + describeMaturity(r);

String describeMaturity(DocumentedContributorMetaBase r) =>
    r.maturity == Maturity.stable ? '' : ' (${r.maturity.name})';

String toDescription(DocumentedContributorMetaBase r) =>
    '<!--suppress HtmlUnknownTarget --><strong><a href="${r.name}.html">${qualify(r)}</a></strong><br/> ${markdownToHtml(r.description)}';
