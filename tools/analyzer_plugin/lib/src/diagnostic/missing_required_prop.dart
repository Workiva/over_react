import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/pretty_print.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/props_set_by_factory.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:over_react_analyzer_plugin/src/util/weak_map.dart';

import '../fluent_interface_util.dart';
import '../util/prop_declarations/defaulted_props.dart';
import '../util/prop_declarations/get_all_props.dart';
import '../util/prop_declarations/required_props.dart';

const _desc = r'Always provide required props.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**ALWAYS** provide a value for `late` required props.

If a component has a props interface like this:

```dart
mixin NavItemProps on UiProps {
  bool? isActive;

  late void Function() onDidActivate;
}
```

Then the late required prop must always be set by the consumer:

**GOOD:**
```dart
@override
render() {
  return (NavItem()
    ..onDidActivate = () {
      // Do something
    }
  )(
    'Activate me',
  );
}
```

**BAD:**
```dart
@override
render() {
  return NavItem()(
    'You probably cannot activate me :(',
  );
}
```

''';
// </editor-fold>

class MissingRequiredPropDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const lateRequiredCode = DiagnosticCode(
    'over_react_late_required_prop',
    "Missing required late prop {0}.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  // Note: this code is disabled by default in getDiagnosticContributors
  @DocsMeta(_desc, details: _details)
  static const annotationRequiredCode = DiagnosticCode(
    'over_react_annotation_required_prop',
    "Missing @requiredProp {0}.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
  );

  static DiagnosticCode _codeForRequiredness(PropRequiredness requiredness) {
    switch (requiredness) {
      case PropRequiredness.late:
        return lateRequiredCode;
      case PropRequiredness.annotation:
        return annotationRequiredCode;
      case PropRequiredness.ignoredViaDefault:
      case PropRequiredness.ignoredByConsumingClass:
      case PropRequiredness.none:
        throw ArgumentError('Only values considered required can be passed; got PropRequiredness.none', 'requiredness');
    }
  }

  @override
  List<DiagnosticCode> get codes => [
        lateRequiredCode,
        annotationRequiredCode,
      ];

  static final fixKind = FixKind('add_required_prop', 200, "Add required prop '{0}'");

  static final _debugCommentPattern = getDebugCommentPattern('over_react_required_props');

  /// Returns whether the debug helper should be enabled, caching results per result
  /// so we don't have to run it in in every [computeErrorsForUsage].
  ///
  /// TODO Add shared debug flag computation in DiagnosticContributor/DiagnosticCollector
  final _cachedIsDebugHelperEnabled =
      memoizeWithWeakMap<ResolvedUnitResult, bool>((result) => _debugCommentPattern.hasMatch(result.content));

  /// A wrapper around [getAllRequiredProps] that caches results per props type [InterfaceElement],
  /// which greatly improves performance of this diagnostic when a component is used more than once.
  ///
  /// The main performance bottlenecks being optimized here are the [getDefaultedPropsForComponentWithPropsClass]
  /// and [getAllProps] calls within [getAllRequiredProps].
  ///
  /// This cache is static so it can be shared across multiple files (each of which gets a new diagnostic instance).
  ///
  /// By using an expando, the returned [RequiredPropInfo] will be held in as long as the input element is held, and
  /// released when the element is released. This is perfect for our use-case, since we want to optimize subsequent calls,
  /// and get new results if the inputs change (in which case, the analyzer will create new, updated elements).
  ///
  /// The returned RequiredPropInfo doesn't take up much memory, and shouldn't retain anything not already
  /// retained by the element (e.g., prop FieldElements), so this caching mechanism should not cause a significant
  /// increase in memory usage.
  static final _cachedGetAllRequiredProps = memoizeWithWeakMap(getAllRequiredProps);

  static final _cachedGetPropsSetByFactory = memoizeWithWeakMap(getPropsSetByFactory);

  /// Whether to include diagnostics for props marked required for annotations.
  final bool lintForAnnotationRequiredProps;

  MissingRequiredPropDiagnostic({required this.lintForAnnotationRequiredProps});

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // [1] Don't use `ComponentUsage` APIs to get this value since builderType has extra, inefficient steps.

    // Only lint for full inline invocations, and not cases where a builder is
    // saved off to a variable and invoked later.
    if (usage.factory == null) return;

    var builderType = usage.builder.staticType; // [1]
    if (builderType == null) return;

    final propsClassElement = builderType.typeOrBound.element; // [1]
    if (propsClassElement is! InterfaceElement) return;

    // DOM and SVG components are common and have a large number of props, none of which are required;
    // short-circuit here for performance.
    if (const {'DomProps', 'SvgProps'}.contains(propsClassElement.name)) return; // [1]

    // Calling `disableRequiredPropValidation` disables runtime validation,
    // so we'll also disable static validation.
    final validationDisabledForUsage = usage.cascadedMethodInvocations
        .any((invocation) => invocation.methodName.name == 'disableRequiredPropValidation');
    if (validationDisabledForUsage) return;

    final requiredPropInfo = _cachedGetAllRequiredProps(propsClassElement);

    final debugHelper = AnalyzerDebugHelper(result, collector, enabled: _cachedIsDebugHelperEnabled(result));

    // Compute this only when we need to.
    Set<String>? propsSetByFactory() {
      final factoryElement = usage.factory.tryCast<Identifier>()?.staticElement;
      if (factoryElement == null) return null;
      return _cachedGetPropsSetByFactory(factoryElement);
    }

    // Include debug info for each invocation ahout all the props and their requirednesses.
    debugHelper.log(
      () => _requiredPropsDebugMessage(requiredPropInfo, propsSetByFactory: propsSetByFactory()),
      () => result.locationFor(usage.builder),
    );

    final presentPropNames =
        usage.cascadedProps.where((prop) => !prop.isPrefixed).map((prop) => prop.name.name).toSet();

    for (final name in requiredPropInfo.requiredPropNames) {
      if (presentPropNames.contains(name)) continue;

      final field = requiredPropInfo.requiredFieldsByName[name]!;
      if (isRequiredPropValidationDisabled(field)) {
        continue;
      }

      final requiredness = requiredPropInfo.propRequirednessByName[name]!;
      if (!lintForAnnotationRequiredProps && requiredness == PropRequiredness.annotation) {
        continue;
      }

      // TODO(FED-2034) don't warn when we know required props are being forwarded

      // Only access propsSetByFactory when we hit missing required props to avoid computing it unnecessarily.
      if (propsSetByFactory()?.contains(name) ?? false) {
        continue;
      }

      await collector.addErrorWithFix(
        _codeForRequiredness(requiredness),
        result.locationFor(usage.builder),
        errorMessageArgs: ["'$name' from '${field.enclosingElement.name}'"],
        fixKind: fixKind,
        fixMessageArgs: [name],
        computeFix: () => buildFileEdit(result, (builder) {
          addProp(usage, builder, result.content, result.lineInfo, name: name, buildValueEdit: (builder) {
            builder.selectHere();
          });
        }),
      );
    }
  }

  static String _requiredPropsDebugMessage(RequiredPropInfo requiredPropInfo, {Set<String>? propsSetByFactory}) {
    final propNamesByRequirednessName = <String, Set<String>>{};
    final withDisabledRequiredValidation = <String>{};
    requiredPropInfo.propRequirednessByName.forEach((name, requiredness) {
      propNamesByRequirednessName.putIfAbsent(requiredness.name, () => {}).add(name);
      if (requiredness.isRequired) {
        final propField = requiredPropInfo.requiredFieldsByName[name]!;
        if (isRequiredPropValidationDisabled(propField)) {
          withDisabledRequiredValidation.add(name);
        }
      }
    });
    return 'Prop requiredness: ${prettyPrint(propNamesByRequirednessName)}'
        '\nProps with `@requiredPropValidationDisabled`: $withDisabledRequiredValidation'
        '\nProps set by factory: $propsSetByFactory';
  }
}
