import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

import '../fluent_interface_util.dart';

const _desc = r'Avoid omitting props that are required.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to always provide a value for props that are annotated a `@requiredProp`s.

If a component has a props interface like this:

```
mixin NavItemProps on UiProps {
  bool isActive;
  @requiredProp
  void Function() onDidActivate;
}
```

then the prop that is marked as "required" should always be set by the consumer:

**GOOD:**
```
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
```
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
  @DocsMeta(_desc, details: _details, maturity: Maturity.experimental)
  static const code = DiagnosticCode(
    'over_react_required_prop',
    "Missing required prop '{0}'.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 200, "Add required prop '{0}'");

  static final _debugCommentPattern = getDebugCommentPattern('over_react_required_props');

  // final debugHelper = AnalyzerDebugHelper(result, collector, enabled: _debugCommentPattern.hasMatch(result.content));

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final requiredFieldsByName = <String, FieldElement>{};

    // FIXME(null-safety) FED-1720 this probably needs optimization, and may benefit from caching by props element

    var builderType = usage.builder.staticType;
    // Handle generic factories (todo might not be needed)
    if (builderType is TypeParameterType) {
      builderType = builderType.typeOrBound;
    }

    // todo check if factory invocation
    if (builderType is InterfaceType && builderType.element.name != 'UiProps') {
      for (final propField in builderType.element.allProps) {
        if (requiredFieldsByName.containsKey(propField.name)) {
          // Short-circuit if we've already identified this field as required.
          // There might be duplicates if props are overridden, and there will
          // definitely be duplicates in the builder-generated code.
          continue;
        }

        if (isRequiredProp(propField)) {
          requiredFieldsByName[propField.name] = propField;
        }
      }
    }
    final debugHelper = AnalyzerDebugHelper(result, collector, enabled: _debugCommentPattern.hasMatch(result.content));
    debugHelper.logWithLocation('Required props: $requiredFieldsByName', result.locationFor(usage.builder));

    final missingRequiredFieldNames = requiredFieldsByName.keys.toSet()
      ..removeAll(usage.cascadedProps.where((prop) => !prop.isPrefixed).map((prop) => prop.name.name));


    for (final name in missingRequiredFieldNames) {
      await collector.addErrorWithFix(
        code,
        result.locationFor(usage.builder),
        errorMessageArgs: [name],
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
}

extension on InterfaceElement {
  Iterable<InterfaceElement> get thisAndSupertypes sync* {
    yield this;
    for (final s in allSupertypes) {
      yield s.element;
    }
  }

  Iterable<FieldElement> get allProps sync* {
    for (final c in thisAndSupertypes) {
      // FIXME(null-safety) FED-1720 handle legacy boilerplate prop mixins if it's not too much effort to implement.
      //   If so, we'll probably need something different than the `isPropsMixin` check below,
      //   and may need to more aggressively filter out supertypes up front to avoid performance issues and false positives,
      //   like UiProps and its supertypes (Map, MapBase, MapViewMixin, PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin)
      final isPropsMixin = c is MixinElement && c.superclassConstraints.any((s) => s.element.name == 'UiProps');
      if (!isPropsMixin) continue;
      if (c.source.uri.path.endsWith('.over_react.g.dart')) continue;
      yield* c.fields.where((f) => !f.isStatic);
    }
  }
}

enum PropRequiredness {
  none,
  late,
  annotation
}

bool isRequiredProp(FieldElement field) {
  if (field.isLate) return true;

  if (field.metadata.any((annotation) {
    // Common case, might be good to short circuit here for perf
    if (annotation.isOverride) return false;
    if (annotation.element?.library?.name != 'over_react.component_declaration.annotations') {
      return false;
    }
    // It's almost always going to be `requiredProp` or `Accessor`;
    // skip more checks an just try to pull `isRequired` prop off of them.
    // If it fails, it's not the annotation we're interested in anyways.
    return annotation.computeConstantValue()?.getField('isRequired')?.toBoolValue() ?? false;
  })) {
    return true;
  }

  return false;
}
