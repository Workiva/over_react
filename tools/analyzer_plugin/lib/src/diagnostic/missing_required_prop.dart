import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/pretty_print.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/props_set_by_factory.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_forwarding/forwarded_props.dart';
import 'package:over_react_analyzer_plugin/src/util/weak_map.dart';

import '../fluent_interface_util.dart';
import '../util/prop_declarations/defaulted_props.dart';
import '../util/prop_declarations/get_all_props.dart';
import '../util/prop_declarations/required_props.dart';

const _desc = r'Always provide required props.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**ALWAYS** provide a value for `late` required props, either directly or by forwarding props.

Please see the documentation for [null safety and required props](https://github.com/Workiva/over_react/blob/master/doc/null_safety_and_required_props.md)
for more information on required prop validation, which, in addition to this lint, also includes runtime `assert`s.

Those docs also note exceptions to this rule under the [Disabling required prop validation for certain props](https://github.com/Workiva/over_react/blob/master/doc/null_safety_and_required_props.md#disabling-required-prop-validation-for-certain-props) 
section, and include instructions for handling those. One common case where this doesn't apply are "wrapper" components that render another component and set some of its props within its render.

### Examples:

Given the following component with the required prop `user`:

```dart
mixin UserChipProps on UiProps {
  late User user;
  bool? isSelected;
}

UiFactory<UserChipProps> UserChip = uiFunction((props) {
  // ...
}, _$UserChipConfig);
```

Then whenever UserChip is render, that required prop must always be set by the consumer.

**GOOD:**
```dart
    (UserChip()..user = user)()
```

**BAD:**
```dart
   UserChip()()
// ^^^^^^^^^^
// warning: Missing required late prop 'user' from 'UserChipProps'.
// (over_react_late_required_prop)
```
and, that code will also throw a runtime error when asserts are enabled:

```
Uncaught Error: RequiredPropsError: Required prop `user` is missing.
   at Object.throw_ [as throw]
   at _$$UserChipProps$JsMap.new.validateRequiredProps
```

#### Prop forwarding

**GOOD:**
```dart
mixin CustomUserChipPropsMixin on UiProps {
  String? color;
}

class CustomUserChipProps = UiProps with UserChipProps, CustomUserChipPropsMixin;

UiFactory<CustomUserChipProps> CustomUserChip = uiFunction((props) {
  final color = props.color;
  
  return (UserChip()
    // Required props are correctly forwarded here by the wrapper component 
    ..addProps(props.getPropsToForward(exclude: {CustomUserChipPropsMixin})
    ..style = {
      if (color != null) 'border': '2px solid $color', 
      ...?props.style,
    } 
  )();
}, _$CustomUserChipConfig);
```

**BAD:**
```dart
UiFactory<CustomUserChipProps> CustomUserChip = uiFunction((props) {
  final color = props.color;
  
  // Required props are not forwarded, so we get:
  //   warning: Missing required late prop 'user' from 'UserChipProps'.
  //   (over_react_late_required_prop)
  return (UserChip()
    ..style = {
      if (color != null) 'border': '2px solid $color', 
      ...?props.style,
    } 
  )();
}, _$CustomUserChipConfig);
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
    correction: _correctionMessage,
  );

  // Note: this code is disabled by default in getDiagnosticContributors
  @DocsMeta(_desc, details: _details)
  static const annotationRequiredCode = DiagnosticCode(
    'over_react_annotation_required_prop',
    "Missing @requiredProp {0}.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
    correction: _correctionMessage,
  );

  static const _correctionMessage =
      "Either set this prop, or mix it into the enclosing component's props and forward it."
      " Or, if this is a wrapper component that sets this prop within its render,"
      " disable validation for this prop (see instructions in documentation link).";

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
  /// By using a [WeakMap], the returned value will be held in as long as the input element is held, and
  /// released when the element is released. This is perfect for our use-cases, since we want to optimize subsequent calls,
  /// and get new results if the inputs change (in which case, the analyzer will create new, updated elements).
  ///
  /// The returned RequiredPropInfo doesn't take up much memory, and shouldn't retain anything not already
  /// retained by the element (e.g., prop FieldElements), so this caching mechanism should not cause a significant
  /// increase in memory usage.
  static final _cachedGetAllRequiredProps = memoizeWithWeakMap(getAllRequiredProps);

  /// A wrapper around [getPropsSetByFactory] that caches results for a given factory element.
  ///
  /// [getPropsSetByFactory] involves synchronously parsing unresolved AST for the containing file,
  /// so we want to avoid doing that where possible.
  ///
  /// Similar to [_cachedGetAllRequiredProps], this [WeakMap]-based cache should result in minimal memory overhead,
  /// since the returned values are either small sets of Strings or null.
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
    // A flag to help verify during debugging/testing whether propsSetByFactory was computed.
    var hasPropsSetByFactoryBeenComputed = false;
    final debugSuppressedRequiredPropsDueToForwarding = <FieldElement>{};

    // Use late variables to compute these only when we need to.
    late final propsSetByFactory = () {
      hasPropsSetByFactoryBeenComputed = true;

      final factory = usage.factory;
      if (factory == null) return null;

      final factoryElement = getFactoryElement(factory);
      if (factoryElement == null) return null;

      return _cachedGetPropsSetByFactory(factoryElement);
    }();
    late final forwardedProps = computeForwardedProps(usage);
    late final presentPropNames =
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

      final sourcePropsClass = field.enclosingElement;
      if (sourcePropsClass is InterfaceElement) {
        if (forwardedProps != null && forwardedProps.definitelyForwardsPropsFrom(sourcePropsClass)) {
          if (debugHelper.enabled) {
            debugSuppressedRequiredPropsDueToForwarding.add(field);
          }
          continue;
        }
      }

      // Only access propsSetByFactory when we hit missing required props to avoid computing it unnecessarily.
      if (propsSetByFactory?.contains(name) ?? false) {
        continue;
      }

      // Late required prop validation is only enabled for props classes that have migrated to null safety.
      if (propsClassElement.library.isNonNullableByDefault || requiredness != PropRequiredness.late) {
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

    if (forwardedProps != null) {
      debugHelper.log(() {
        var message = StringBuffer()..writeln(forwardedProps);
        if (debugSuppressedRequiredPropsDueToForwarding.isNotEmpty) {
          final propsNamesByClassName = <String?, Set<String>>{};
          for (final field in debugSuppressedRequiredPropsDueToForwarding) {
            propsNamesByClassName.putIfAbsent(field.enclosingElement.name, () => {}).add(field.name);
          }
          message.write('Required props set only via forwarding: ${prettyPrint(propsNamesByClassName)}');
        } else {}
        return message.toString();
      }, () => result.locationFor(forwardedProps.debugSourceNode));
    }

    // Include debug info for each invocation ahout all the props and their requirednesses.
    debugHelper.log(() {
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
      // Store this before we access `propsSetByFactory` in this debug message, since that will set it to true.
      final _hasPropsSetByFactoryBeenComputed = hasPropsSetByFactoryBeenComputed;

      return 'Prop requiredness: ${prettyPrint(propNamesByRequirednessName)}'
          '\nProps with `@requiredPropValidationDisabled`: $withDisabledRequiredValidation'
          '\nProps set by factory: $propsSetByFactory'
          '\npropsSetByFactory needed to be computed: $_hasPropsSetByFactoryBeenComputed';
    }, () => result.locationFor(usage.builder));
  }
}
