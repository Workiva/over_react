// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/component_usage.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/util.dart';

class InvalidChildChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-element-invalid-child';

  @override
  String get description =>
      '';

  @override
  void visitComponentUsage(CompilationUnit unit, FluentComponentUsage usage) {
    final typeProvider = unit.declaredElement.context.typeProvider;
    final typeSystem = unit.declaredElement.context.typeSystem;

    void _validateType(DartType type, {@required void onInvalidType(DartType invalidType)}) {
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
        _validateType(typeArg, onInvalidType: onInvalidType);
        return;
      }

      onInvalidType(type);
    }

    for (var argument in usage.node.argumentList.arguments) {
      _validateType(argument.staticType, onInvalidType: (invalidType) {
        var message = 'Invalid child type: `${invalidType.displayName}`.';;
        List<SourceEdit> fixEdits;
        String fixMessage;

        if (couldBeMissingBuilderInvocation(argument)) {
          message += missingBuilderMessageSuffix;
          fixEdits = getMissingInvocationBuilderEdits(argument);
          fixMessage = missingBuilderFixMessage;
        } else {
          message += ' Must be a ReactElement, Iterable, string, number, boolean, or null.';
        }

        emitWarning(message: message, offset: argument.offset, end: argument.end, fixMessage: fixMessage, fixEdits: fixEdits);
      });
    }
  }
}
