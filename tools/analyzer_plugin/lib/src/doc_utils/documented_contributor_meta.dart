import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/docs_meta_annotation.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

/// An interface implemented by registered metadata models and the annotation(s)
/// that enable contribution to those models.
abstract class IContributorMetaBase {
  /// Short description suitable for display in console output.
  ///
  /// > __Required.__
  String get description;

  /// Detailed documentation _(in markdown format)_ suitable for display on a documentation website.
  String get details;

  /// The version the contributor was added in.
  ///
  /// > Should default to [defaultSince].
  String get since;

  /// The maturity of the contributor.
  ///
  /// > Should always default to [defaultMaturity].
  Maturity get maturity;

  /// The default value for [maturity].
  static const defaultMaturity = Maturity.stable;

  /// The default value for [since].
  static const defaultSince = '1.0.0';
}

/// A base class extended by registered metadata models.
abstract class DocumentedContributorMetaBase implements IContributorMetaBase {
  /// The unique name of the contributor.
  ///
  /// For a diagnostic contributor, this should be equivalent to [DiagnosticCode.name].
  ///
  /// > __Required.__
  String get name;

  /// Returns a `DocsMeta` instance constructed by parsing the AST of the provided annotated [element].
  static DocsMeta getDocsMetaFromAnnotation(FieldElement element) {
    final annotation =
        element.metadata.singleWhere((a) => a.element.thisOrAncestorOfType<ClassElement>().name == 'DocsMeta');
    final annotationObj = annotation.computeConstantValue();
    final description = annotationObj.getField('description').toStringValue();
    final details = annotationObj.getField('details').toStringValue();
    final maturity =
        getMatchingConst(annotationObj.getField('maturity'), Maturity.VALUES) ?? IContributorMetaBase.defaultMaturity;
    final since = annotationObj.getField('since').toStringValue() ?? IContributorMetaBase.defaultSince;

    return DocsMeta(description, details: details, since: since, maturity: maturity);
  }
}

/// Documentation metadata for an "assist" contributor.
///
/// Must be constructed by parsing the AST of an element annotated with a [DocsMeta] annotation
/// via the [DocumentedAssistContributorMeta.fromAnnotatedFieldAst] factory constructor.
class DocumentedAssistContributorMeta extends DocumentedContributorMetaBase
    implements Comparable<DocumentedAssistContributorMeta> {
  @override
  final String name;
  @override
  final String description;
  @override
  final String details;
  @override
  final String since;
  @override
  final Maturity maturity;

  DocumentedAssistContributorMeta._(this.name, this.description,
      {this.details,
      this.since = IContributorMetaBase.defaultSince,
      this.maturity = IContributorMetaBase.defaultMaturity});

  /// Creates a new instance from the field [element] annotated with a [DocsMeta] annotation.
  factory DocumentedAssistContributorMeta.fromAnnotatedFieldAst(FieldElement element) {
    final metaFromAnnotation = DocumentedContributorMetaBase.getDocsMetaFromAnnotation(element);

    final assistKindObj = element.computeConstantValue();
    final name = assistKindObj.getField('id').toStringValue();

    return DocumentedAssistContributorMeta._(
      name,
      metaFromAnnotation.description,
      details: metaFromAnnotation.details,
      since: metaFromAnnotation.since,
      maturity: metaFromAnnotation.maturity,
    );
  }

  @override
  int compareTo(DocumentedAssistContributorMeta other) {
    return name.compareTo(other.name);
  }
}

/// Documentation metadata for a "diagnostic" contributor _(e.g. lint / "rule")_.
///
/// Must be constructed by parsing the AST of an element annotated with a [DocsMeta] annotation
/// via the [DocumentedDiagnosticContributorMeta.fromAnnotatedFieldAst] factory constructor.
class DocumentedDiagnosticContributorMeta extends DocumentedContributorMetaBase
    implements Comparable<DocumentedDiagnosticContributorMeta> {
  @override
  final String name;
  @override
  final String description;
  @override
  final String details;
  @override
  final String since;
  @override
  final Maturity maturity;

  /// The severity of the error.
  ///
  /// > Should always match the [DiagnosticCode.errorSeverity] value.
  final AnalysisErrorSeverity severity;

  /// The type of error.
  ///
  /// > Should always match the [DiagnosticCode.type] value.
  final AnalysisErrorType type;

  DocumentedDiagnosticContributorMeta._(
    this.name,
    this.description, {
    @required this.severity,
    @required this.type,
    this.since,
    this.maturity = Maturity.stable,
    this.details,
  });

  /// Creates a new instance from the field [element] annotated with a [DocsMeta] annotation.
  factory DocumentedDiagnosticContributorMeta.fromAnnotatedFieldAst(FieldElement element) {
    final metaFromAnnotation = DocumentedContributorMetaBase.getDocsMetaFromAnnotation(element);

    final diagnosticCodeObj = element.computeConstantValue();
    final name = diagnosticCodeObj.getField('name').toStringValue();
    final severity = diagnosticCodeObj.getField('errorSeverity');
    final type = diagnosticCodeObj.getField('type');

    return DocumentedDiagnosticContributorMeta._(
      name,
      metaFromAnnotation.description,
      details: metaFromAnnotation.details,
      since: metaFromAnnotation.since,
      maturity: metaFromAnnotation.maturity,
      severity: getMatchingConst(severity, AnalysisErrorSeverity.VALUES),
      type: getMatchingConst(type, AnalysisErrorType.VALUES),
    );
  }

  @override
  int compareTo(DocumentedDiagnosticContributorMeta other) {
    var g = severity.name.compareTo(other.severity.name);
    if (g != 0) {
      return g;
    }
    return name.compareTo(other.name);
  }
}
