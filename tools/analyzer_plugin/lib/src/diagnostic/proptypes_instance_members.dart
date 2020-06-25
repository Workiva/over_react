import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/pseudo_static_lifecycle.dart' show instanceMemberWhitelist;
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/non_static_reference_visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/proptypes_visitors.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/utils/util.dart';

/// An error that appears when accessing instance members of a class in propTypes values
///
/// {@category Diagnostics}
/// {@subCategory Errors}
class PropTypesInstanceMembersDiagnostic extends DiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_proptypes_do_not_access_instance_members',
      'Instance members cannot be accessed within propTypes',
      AnalysisErrorSeverity.ERROR,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  @override
  computeErrors(result, collector) async {
    final visitor = PropTypesVisitor();
    result.unit.accept(visitor);

    for (final value in visitor.mapVisitor?.values) {
      final blockVisitor = ReferenceVisitor();

      value.accept(blockVisitor);
      for (final reference in blockVisitor.nonStaticReferences) {
        if (reference is SimpleIdentifier && instanceMemberWhitelist.contains(reference.name)) {
          continue;
        }

        if (reference is SuperExpression) {
          // Do not lint calls to super.propTypes
          if (reference.parent.tryCast<PropertyAccess>()?.propertyName.name == 'propTypes') continue;
        }

        collector.addError(
          code,
          result.locationFor(reference),
        );
      }
    }
  }
}
