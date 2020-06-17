import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
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

      plugin.Location errorLocation;
      DartType topLevelKeyType;
      // Special case for calling toString() on an object explicitly
      if (rhs is MethodInvocation && rhs.methodName.name == 'toString') {
        errorLocation = result.locationFor(rhs.realTarget);
        topLevelKeyType = rhs.realTarget.staticType;
      } else {
        errorLocation = result.locationFor(rhs);
        topLevelKeyType = rhs.staticType;
      }

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
    });
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
