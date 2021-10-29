// import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
// import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
//
// import 'generate_contributor_doc_page.dart';
// import 'generate_contributor_type_index.dart';
// import 'shared_html.dart';
//
// class AssistDocGenerator extends ContributorDocPage<DocumentedAssistContributorMeta> {
//   AssistDocGenerator(DocumentedAssistContributorMeta contributor) : super(contributor);
// }
//
// class AssistsIndexer extends ContributorIndexer {
//   AssistsIndexer() : super(pageTitle: 'OverReact Analyzer Plugin Assists', bodySubtitle: 'Assists');
//
//   static final assists = List.of(AssistMetaRegistry.assistRegistry.meta, growable: false)..sort();
//
//   @override
//   String generateContributorsIndexBodySection() => '''
// <h1 id="supported-assists">Supported Assists</h1>
// <p>
//    This list is auto-generated from our sources.
// </p>
//
// ${assists.map((r) => '${toDescription(r)}').join('\n\n')}
// ''';
// }
