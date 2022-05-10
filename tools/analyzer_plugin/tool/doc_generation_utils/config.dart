import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/contributor_meta_registry.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';

import 'generate_contributor_doc_page.dart';
import 'generate_contributor_type_index.dart';

/// A model representing a classification of docs to be generated (e.g. assists / lints).
class DocsGenerationConfig {
  final String srcDir;
  final String outputSubDir;
  final String typeNameOfAnnotatedField;
  final String typeNameOfContributorClass;
  final ContributorMetaRegistry registry;
  final List<DocumentedContributorMetaBase> Function() getSortedContributorMetas;
  final DocumentedContributorMetaBase Function(FieldElement el) getMeta;
  final ContributorIndexer Function() getIndexGenerator;
  final ContributorDocPage<DocumentedContributorMetaBase> Function(DocumentedContributorMetaBase meta) getPageGenerator;
  final String packageNameContainingContributorClass;
  final String packageNameContainingAnnotatedFieldType;
  final Function(String outDir)? generateAdditionalDocs;

  DocsGenerationConfig({
    required this.srcDir,
    required this.typeNameOfContributorClass,
    required this.typeNameOfAnnotatedField,
    required this.registry,
    required this.getSortedContributorMetas,
    required this.getIndexGenerator,
    required this.getPageGenerator,
    required this.getMeta,
    this.packageNameContainingAnnotatedFieldType = 'over_react_analyzer_plugin',
    this.packageNameContainingContributorClass = 'over_react_analyzer_plugin',
    this.generateAdditionalDocs,
    String? outputSubDir,
  }) : outputSubDir = outputSubDir ?? srcDir;
}
