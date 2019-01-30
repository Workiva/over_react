// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
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
      // Couldn't be resolved to anything specific; `Object` might be
      // problematic in some cases, but would have too many false positives.
      if (type.isDynamic || type.isObject) return;
      //
      if (type.name == 'ReactElement') return;
      if (type.isEquivalentTo(typeProvider.stringType)) return;
      // isAssignableTo to handle num, int, and double
      if (type.isAssignableTo(typeProvider.numType)) return;
      if (type.isEquivalentTo(typeProvider.nullType)) return;
      if (type.isEquivalentTo(typeProvider.boolType)) return;
      // If the children are in an iterable, make sure it's not an iterable of
      // unsupported objects.
      if (type.isSubtypeOf(typeProvider.iterableDynamicType)) {
        var typeArg = typeSystem.mostSpecificTypeArgument(type, typeProvider.iterableType);
        _validateType(typeArg, onInvalidType: onInvalidType);
//        _validateType(typeArg, onInvalidType: (type) {
//          onInvalidType(typeArg);
//        });
        return;
      }

      onInvalidType(type);
    }

    for (var argument in usage.node.argumentList.arguments) {
      _validateType(argument.staticType, onInvalidType: (invalidType) {
        if (invalidType.isSubtypeOf(typeProvider.mapType)) {
          // Sanity check that they type didn't get unwrapped or something
//          if (argument.staticType.isEquivalentTo(invalidType)) {
            if (couldBeMissingBuilderInvocation(argument)) {
              emitWarning(message: 'Invalid child of type ${invalidType.displayName}. $missingBuilderMessageSuffix',
                offset: argument.offset,
                end: argument.end,
                fixEdits: getMissingInvocationBuilderEdits(argument),
                fixMessage: missingBuilderFixMessage,
              );

              return;
            }
//            }
        }

//        if (invalidType.isSubtypeOf(typeProvider.iterableDynamicType)) {
//          emitWarning(message: 'Item type of ${invalidType.displayName} is not supported as children', offset: argument.offset, end: argument.end);
//        } else {
        // todo add special warning for Future

          emitWarning(message: '${invalidType.displayName} is not a supported child type', offset: argument.offset, end: argument.end);
//        }
      });
    }
  }
}
