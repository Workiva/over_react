import 'dart:async';

import 'package:analyzer/dart/element/type.dart';
// ignore: implementation_imports
import 'package:analyzer/src/generated/type_system.dart' show TypeSystem;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class InvalidChildDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_invalid_child',
      "Invalid child type: '{0}'. Must be a ReactElement, Fragment, string, number, boolean, null, or an Iterable of those types.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final typeSystem = result.libraryElement.typeSystem;

    for (final argument in usage.node.argumentList.arguments) {
      await validateReactChildType(argument.staticType, typeSystem, onInvalidType: (invalidType) async {
        final location = result.locationFor(argument);

        if (couldBeMissingBuilderInvocation(argument)) {
          await collector.addErrorWithFix(
            code,
            location,
            errorMessageArgs: [invalidType.getDisplayString(), missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () => buildFileEdit(result, (builder) {
              buildMissingInvocationEdits(argument, builder);
            }),
          );
        } else {
          collector.addError(code, location, errorMessageArgs: [invalidType.getDisplayString(), '']);
        }
      });
    }
  }
}

Future<void> validateReactChildType(DartType type, TypeSystem typeSystem,
    {FutureOr<void> Function(DartType invalidType) onInvalidType}) async {
  // Couldn't be resolved
  if (type == null) return;
  // Couldn't be resolved to anything more specific; `Object` might be
  // problematic in some cases, but would have too many false positives.
  if (type.isDynamic || type.isDartCoreObject) return;
  if (type.isReactElement) return;
  if (type.isDartCoreString) return;
  // isAssignableTo to handle num, int, and double
  if (typeSystem.isAssignableTo(typeSystem.typeProvider.numType, type)) return;
  if (type.isDartCoreNull) return;
  if (type.isDartCoreBool) return;
  // If the children are in an iterable, validate its type argument.
  // To check for an iterable, type-check against `iterableDynamicType` and not
  // `iterableType` since the latter has an uninstantiated type argument of `E`.
  if (typeSystem.isSubtypeOf(type, typeSystem.typeProvider.iterableDynamicType)) {
    var typeArg = typeSystem.mostSpecificTypeArgument(type, typeSystem.typeProvider.iterableDynamicType);
    await validateReactChildType(typeArg, typeSystem, onInvalidType: onInvalidType);
    return;
  }

  await onInvalidType(type);
}
