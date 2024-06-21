import 'dart:async';

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';
import 'package:over_react_analyzer_plugin/src/util/null_safety_utils.dart' as utils;
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Do not use unsupported types as component children.';
// <editor-fold desc="Documentation Details">
const _details = '''

Children of an OverReact component must be a $supportedOverReactChildTypes

**GOOD:**
```
@override
render() {
  return Dom.div()(
    'Hi there',
  );
}
```

**GOOD:**
```
@override
render() {
  return Dom.div()(
    NavItem()('Nav\'in it, you know?'),
  );
}
```

**BAD:**
```
@override
render() {
  return Dom.div()(
    NavItem()({
      'foo': 'bar',
    }),
  );
}
```

''';
// </editor-fold>

class InvalidChildDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_invalid_child',
    "Objects of type '{0}' are not valid React children.",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_TYPE_WARNING,
    correction: 'Try using one of the supported types: $supportedOverReactChildTypes.',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final argument in usage.node.argumentList.arguments) {
      await validateReactChildType(argument.staticType, result.typeSystem, result.typeProvider,
          onInvalidType: (invalidType) async {
        final location = result.locationFor(argument);
        final withNullability = utils.withNullability(result);

        if (couldBeMissingBuilderInvocation(argument)) {
          await collector.addErrorWithFix(
            code,
            location,
            errorMessageArgs: [invalidType.getDisplayString(withNullability: withNullability), missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () => buildFileEdit(result, (builder) {
              buildMissingInvocationEdits(argument, builder);
            }),
          );
        } else if (invalidType is FunctionType || invalidType.isDartCoreFunction) {
          // Functions can be used as children
        } else {
          collector.addError(code, location, errorMessageArgs: [invalidType.getDisplayString(withNullability: withNullability)]);
        }
      });
    }
  }
}

Future<void> validateReactChildType(DartType? type, TypeSystem typeSystem, TypeProvider typeProvider,
    {required FutureOr<void> Function(DartType invalidType) onInvalidType}) async {
  // Couldn't be resolved
  if (type == null) return;
  if (type.isDartCoreNull) return;
  final nonNullType = typeSystem.promoteToNonNull(type);
  // Couldn't be resolved to anything more specific; `Object` might be
  // problematic in some cases, but would have too many false positives.
  if (nonNullType.isDynamic || nonNullType.isDartCoreObject) return;
  if (nonNullType.isReactElement) return;
  if (nonNullType.isDartCoreString) return;
  // isSubtypeOf to handle num, int, and double
  if (typeSystem.isSubtypeOf(nonNullType, typeProvider.numType)) return;
  if (nonNullType.isDartCoreBool) return;
  // If the children are in an iterable, validate its type argument.
  // To check for an iterable, type-check against `iterableDynamicType` and not
  // `iterableType` since the latter has an uninstantiated type argument of `E`.
  if (typeSystem.isSubtypeOf(nonNullType, typeProvider.iterableDynamicType)) {
    final iterableTypeArg = type.typeOrBound.asInstanceOf(typeProvider.iterableElement)?.typeArguments.firstOrNull;
    if (iterableTypeArg != null) {
      await validateReactChildType(iterableTypeArg, typeSystem, typeProvider, onInvalidType: onInvalidType);
    }
    return;
  }

  await onInvalidType(nonNullType);
}
