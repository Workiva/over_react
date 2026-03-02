import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/documented_contributor_meta.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';

import 'constant_instantiation.dart';

/// Returns a `DocsMeta` instance constructed by parsing the AST of the provided annotated [element].
DocsMeta _getDocsMetaFromAnnotation(FieldElement element) {
  final annotation =
      element.metadata.singleWhere((a) => a.element!.thisOrAncestorOfType<ClassElement>()!.name == 'DocsMeta');
  final annotationObj = annotation.computeConstantValue()!;
  final description = annotationObj.getField('description')!.toStringValue()!;
  final details = annotationObj.getField('details')!.toStringValue();
  final maturity = getMatchingConst(annotationObj.getField('maturity')!, Maturity.VALUES);
  final since = annotationObj.getField('since')!.toStringValue() ?? IContributorMetaBase.defaultSince;

  return DocsMeta(description, details: details, since: since, maturity: maturity);
}

/// Creates a new instance from the field [element] annotated with a [DocsMeta] annotation.
DocumentedDiagnosticContributorMeta getDiagnosticDocsMetaFromNode(FieldElement element) {
  final metaFromAnnotation = _getDocsMetaFromAnnotation(element);

  final diagnosticCodeObj = element.computeConstantValue()!;
  final name = diagnosticCodeObj.getField('name')!.toStringValue()!;
  final severity = diagnosticCodeObj.getField('errorSeverity')!;
  final type = diagnosticCodeObj.getField('type')!;

  return DocumentedDiagnosticContributorMeta(
    name,
    metaFromAnnotation.description,
    details: metaFromAnnotation.details,
    since: metaFromAnnotation.since,
    maturity: metaFromAnnotation.maturity,
    severity: getMatchingConst(severity, AnalysisErrorSeverity.VALUES),
    type: getMatchingConst(type, AnalysisErrorType.VALUES),
  );
}

/// Creates a new instance from the field [element] annotated with a [DocsMeta] annotation.
DocumentedAssistContributorMeta getAssistDocsMetaFromNode(FieldElement element) {
  final metaFromAnnotation = _getDocsMetaFromAnnotation(element);

  final assistKindObj = element.computeConstantValue()!;
  final name = assistKindObj.getField('id')!.toStringValue()!;

  return DocumentedAssistContributorMeta(
    name,
    metaFromAnnotation.description,
    details: metaFromAnnotation.details,
    since: metaFromAnnotation.since,
    maturity: metaFromAnnotation.maturity,
  );
}
