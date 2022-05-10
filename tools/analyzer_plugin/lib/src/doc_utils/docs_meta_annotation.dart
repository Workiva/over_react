import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';

/// An annotation used to declare documentation metadata for a:
///
/// * `AssistKind` static field within an assist class instance
/// * `DiagnosticCode` static field within a `DiagnosticContributor` instance
///
/// > See: [DocumentedAssistContributorMeta.fromAnnotatedFieldAst] and [DocumentedDiagnosticContributorMeta..fromAnnotatedField]
class DocsMeta implements IContributorMetaBase {
  @override
  final String description;
  @override
  final String? details;
  @override
  final String since;
  @override
  final Maturity maturity;

  const DocsMeta(
    this.description, {
    this.details,
    this.since = IContributorMetaBase.defaultSince,
    this.maturity = IContributorMetaBase.defaultMaturity,
  });
}
