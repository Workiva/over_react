import 'dart:async';

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Do not use unsupported types as component children.';
// <editor-fold desc="Documentation Details">
const _details = '''

Children of an OverReact component must be $supportedOverReactChildTypes

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
    "Invalid child type: '{0}'.",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_TYPE_WARNING,
    correction: 'Must be $supportedOverReactChildTypes',
  );

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final argument in usage.node.argumentList.arguments) {
      await validateReactChildType(argument.staticType, result.typeSystem, result.typeProvider,
          onInvalidType: (invalidType) async {
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
          collector.addError(code, location, errorMessageArgs: [invalidType.getDisplayString()]);
        }
      });
    }
  }
}

Future<void> validateReactChildType(DartType type, TypeSystem typeSystem, TypeProvider typeProvider,
    {FutureOr<void> Function(DartType invalidType) onInvalidType}) async {
  // Couldn't be resolved
  if (type == null) return;
  // Couldn't be resolved to anything more specific; `Object` might be
  // problematic in some cases, but would have too many false positives.
  if (type.isDynamic || type.isDartCoreObject) return;
  if (type.isReactElement) return;
  if (type.isDartCoreString) return;
  // isAssignableTo to handle num, int, and double
  if (typeSystem.isAssignableTo(typeProvider.numType, type)) return;
  if (type.isDartCoreNull) return;
  if (type.isDartCoreBool) return;
  // If the children are in an iterable, validate its type argument.
  // To check for an iterable, type-check against `iterableDynamicType` and not
  // `iterableType` since the latter has an uninstantiated type argument of `E`.
  if (typeSystem.isSubtypeOf(type, typeProvider.iterableDynamicType)) {
    // Use the least-upper-bound to get the an instance of the Iterable type with matching type arguments.
    // e.g., leastUpperBound(`List<String>`, `Iterable<bottom>`) should yield `Iterable<String>`
    final lub = typeSystem.leastUpperBound(type, typeProvider.iterableType2(typeProvider.bottomType));
    final iterableTypeArg =
        lub.isDartCoreIterable ? lub.tryCast<ParameterizedType>()?.typeArguments?.firstOrNull : null;
    if (iterableTypeArg != null) {
      await validateReactChildType(iterableTypeArg, typeSystem, typeProvider, onInvalidType: onInvalidType);
    }
    return;
  }

  await onInvalidType(type);
}
