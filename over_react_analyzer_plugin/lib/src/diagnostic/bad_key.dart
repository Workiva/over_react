import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class BadKeyDiagnostic extends ComponentUsageDiagnosticContributor {
  static final hashCodeCode = DiagnosticCode(
      'over_react_hash_code_as_key',
      "Keys shouldn't be derived from 'hashCode' since it is not unique."
          " While 'hashCode' may seem like it is 'unique enough', 'hashCode' values by design"
          " can collide with each other, and may collide often based on how they're implemented.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final toStringCode = DiagnosticCode(
      'over_react_object_to_string_as_key',
      "Keys shouldn't be derived from '{0}.toString()' since the value is the same for all instances."
          " Try using other information, such as an 'id' field on the object, or an index, to construct the key instead.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final dynamicOrObjectCode = DiagnosticCode(
      'over_react_unknown_key_type',
      "Keys derived from '{0}.toString()' may not be unique."
          " Try using more specific typing, or using other information to construct the key.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final lowQualityCode = DiagnosticCode(
      'over_react_low_quality_key',
      "Keys shouldn't be derived from '{0}.toString()' since they have a high chance of colliding.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  @override
  computeErrorsForUsage(result, collector, usage) async {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name != 'key') return;

      if (rhs.toSource().contains('.hashCode')) {
        collector.addError(hashCodeCode, result.locationFor(rhs));
        return;
      }

      // Handle the top-level key expression, which is toString-ed under the hood.
      processToStringedExpressionInKey(result, collector, rhs);

      // Handle calling toString() on an object explicitly or interpolating it
      // anywhere nested inside the rhs.
      final visitor = ToStringedVisitor();
      rhs.accept(visitor);
      for (final expression in visitor.toStringedExpressions) {
        processToStringedExpressionInKey(result, collector, expression);
      }
    });
  }

  static void processToStringedExpressionInKey(
    ResolvedUnitResult result,
    DiagnosticCollector collector,
    Expression expression,
  ) {
    final topLevelKeyType = expression.staticType;
    final errorLocation = result.locationFor(expression);

    // Type can't be resolved; bail out.
    if (topLevelKeyType == null) return;

    // Special-case for Iterables and Maps: check if their (keys and) values are allowed types.
    final isIterableOrMap =
        // Need to make sure it's not null since null is a subtype of all nullable-types.
        !topLevelKeyType.isDartCoreNull &&
            [
              result.typeProvider.iterableObjectType,
              result.typeProvider.mapObjectObjectType,
            ].any((type) => result.typeSystem.isSubtypeOf(topLevelKeyType, type));

    final keyTypesToProcess = {
      if (isIterableOrMap) ...(topLevelKeyType as InterfaceType).typeArguments else topLevelKeyType,
    };

    for (final type in keyTypesToProcess) {
      if (type.isDartCoreInt || type.isDartCoreDouble || type.isDartCoreString || type.isDartCoreSymbol) {
        // Ignore core types that have good `Object.toString` implementations values.
      } else if (type.isDartCoreObject || type.isDynamic) {
        collector.addError(dynamicOrObjectCode, errorLocation, errorMessageArgs: [type.getDisplayString()]);
      } else if (type.isDartCoreBool || type.isDartCoreNull) {
        collector.addError(lowQualityCode, errorLocation, errorMessageArgs: [type.getDisplayString()]);
      } else if (inheritsToStringImplFromObject(type?.element)) {
        var typesString = "'$type'";
        // Provide context if this type was derived from a Map/Iterable type argument.
        if (type != topLevelKeyType) {
          typesString += ' (from $topLevelKeyType)';
        }

        collector.addError(toStringCode, errorLocation, errorMessageArgs: [typesString]);
      }
    }
  }

  static bool inheritsToStringImplFromObject(Element element) => element
      ?.tryCast<ClassElement>()
      ?.lookUpConcreteMethod('toString', element.library)
      ?.thisOrAncestorOfType<ClassElement>()
      ?.thisType
      ?.isDartCoreObject;
}

extension _TryCast<T> on T {
  S tryCast<S extends T>() => this is S ? this : null;
}

/// Recursively collects expressions that are used to effectively call `toString()`:
///
/// - toString calls
/// - string interpolation
class ToStringedVisitor extends RecursiveAstVisitor<void> {
  final toStringedExpressions = <Expression>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (node.methodName.name == 'toString') {
      toStringedExpressions.add(node.realTarget);
    }
  }

  @override
  void visitInterpolationExpression(InterpolationExpression node) {
    super.visitInterpolationExpression(node);

    final expression = node.expression;
    // Don't add `toString` calls; visitMethodInvocation will handle adding
    // the target of those.
    if (!(expression is MethodInvocation && expression.methodName.name != 'toString')) {
      toStringedExpressions.add(expression);
    }
  }
}
