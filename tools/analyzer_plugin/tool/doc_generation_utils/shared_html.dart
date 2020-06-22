import 'package:markdown/markdown.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';

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
  <a href="https://workiva.github.io/over_react/analyzer_plugin/">
     <h1>OverReact Analyzer Plugin</h1>
  </a>
  <p>$subTitle</p>
  <p class="view"><a href="https://github.com/Workiva/over_react/blob/master/tools/analyzer_plugin/">View the Project on GitHub <small>workiva/over_react</small></a></p>
  <ul>
     <li><a href="https://github.com/Workiva/over_react/blob/master/tools/analyzer_plugin/">View On <strong>GitHub</strong></a></li>
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
