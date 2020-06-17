import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class BadKeyDiagnostic extends ComponentUsageDiagnosticContributor {
  static final hashCodeCode = DiagnosticCode(
      'over_react_hash_code_as_key',
      "Keys should not be derived from 'hashCode' since it is not unique.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final toStringCode = DiagnosticCode(
      'over_react_object_to_string_as_key',
      "The type '{0}' does not produce unique 'toString()' values, and thus should not be used as a key.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final dynamicOrObjectCode = DiagnosticCode(
      'over_react_unknown_key_type',
      "Key is of type '{0}', meaning the instance may not produce a unique 'toString()' value.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final lowQualityCode = DiagnosticCode(
      'over_react_low_quality_key',
      "Keys of type '{0}' have a high chance of colliding.",
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

      Location errorLocation;
      DartType keyType;
      // Special case for calling toString() on an object explicitly
      if (rhs is MethodInvocation && rhs.methodName.name == 'toString') {
        errorLocation = result.locationFor(rhs.realTarget);
        keyType = rhs.realTarget.staticType;
      } else {
        errorLocation = result.locationFor(rhs);
        keyType = rhs.staticType;
      }

      if (keyType == null) return;

      // Special-case for Iterables and Maps: check if their (keys and) values are allowed types.
      // Need to make sure it's not null since null is a subtype of all nullable-types.
      final isIterableOrMap = !keyType.isDartCoreNull && {
        result.typeProvider.iterableObjectType,
        result.typeProvider.mapObjectObjectType,
      }.any((type) => result.typeSystem.isSubtypeOf(keyType, type));

      final keyTypesToProcess = {
        if (isIterableOrMap) ...(keyType as InterfaceType).typeArguments else keyType,
      };

      final hasObjectKey = keyTypesToProcess.remove(result.typeProvider.objectType);
      final hasDynamicKey = keyTypesToProcess.remove(result.typeProvider.dynamicType);
      final hasBoolKey = keyTypesToProcess.remove(result.typeProvider.boolType);
      final hasNullKey = keyTypesToProcess.remove(result.typeProvider.nullType);
      final typesWithObjectToString = keyTypesToProcess.where((type) {
        // Ignore core types that have good `Object.toString` implementations values.
        if (type.isDartCoreInt || type.isDartCoreDouble || type.isDartCoreString || type.isDartCoreSymbol) {
          return false;
        }

        final concreteToString = rhs.staticType?.element //
            ?.tryCast<ClassElement>()
            ?.lookUpConcreteMethod('toString', result.libraryElement);

        final toStringDeclaringClassType = concreteToString?.thisOrAncestorOfType<ClassElement>()?.thisType;
        return toStringDeclaringClassType?.isDartCoreObject ?? false;
      });

      if (hasObjectKey) {
        collector.addError(dynamicOrObjectCode, errorLocation, errorMessageArgs: ['Object']);
      }
      if (hasDynamicKey) {
        collector.addError(dynamicOrObjectCode, errorLocation, errorMessageArgs: ['dynamic']);
      }
      if (hasBoolKey) {
        collector.addError(lowQualityCode, errorLocation, errorMessageArgs: ['bool']);
      }
      if (hasNullKey) {
        collector.addError(lowQualityCode, errorLocation, errorMessageArgs: ['Null']);
      }
      for (final type in typesWithObjectToString) {
        var typesString = "'$type'";
        if (type != keyType) {
          typesString += ' (from $keyType)';
        }

        collector.addError(toStringCode, errorLocation, errorMessageArgs: [typesString]);
      }
    });
  }
}

extension _TryCast<T> on T {
  S tryCast<S extends T>() => this is S ? this : null;
}
