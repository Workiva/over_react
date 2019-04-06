import 'dart:async';

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class InvalidChildDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = ErrorCode(
      'over_react_invalid_child',
      "Invalid child type: '{0}'. Must be a ReactElement, Fragment, string, number, boolean, null, or an Iterable of those types.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final typeProvider = result.unit.declaredElement.context.typeProvider;
    final typeSystem = result.unit.declaredElement.context.typeSystem;

    Future<void> _validateType(DartType type, {@required FutureOr<void> onInvalidType(DartType invalidType)}) async {
      // Couldn't be resolved
      if (type == null || type.isUndefined) return;
      // Couldn't be resolved to anything more specific; `Object` might be
      // problematic in some cases, but would have too many false positives.
      if (type.isDynamic || type.isObject) return;
      if (type.name == 'ReactElement') return;
      if (type.isEquivalentTo(typeProvider.stringType)) return;
      // isAssignableTo to handle num, int, and double
      if (type.isAssignableTo(typeProvider.numType)) return;
      if (type.isEquivalentTo(typeProvider.nullType)) return;
      if (type.isEquivalentTo(typeProvider.boolType)) return;
      // If the children are in an iterable, validate its type argument.
      // To check for an iterable, type-check against `iterableDynamicType` and not
      // `iterableType` since the latter has an uninstantiated type argument of `E`.
      if (type.isSubtypeOf(typeProvider.iterableDynamicType)) {
        var typeArg = typeSystem.mostSpecificTypeArgument(type, typeProvider.iterableType);
        await _validateType(typeArg, onInvalidType: onInvalidType);
        return;
      }

      await onInvalidType(type);
    }

    for (var argument in usage.node.argumentList.arguments) {
      await _validateType(argument.staticType, onInvalidType: (invalidType) async {
        final location = this.location(result, range: range.node(argument));

        if (couldBeMissingBuilderInvocation(argument)) {
          await collector.addErrorWithFix(code, location,
            errorMessageArgs: [invalidType.displayName, missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () async {
              final builder = new DartChangeBuilder(result.session);
              await builder.addFileEdit(result.path, (builder) {
                buildMissingInvocationEdits(argument, builder);
              });
              return builder.sourceChange;
            },
          );
        } else {
          collector.addError(code, location, errorMessageArgs: [invalidType.displayName, '']);
        }
      });
    }
  }
}
