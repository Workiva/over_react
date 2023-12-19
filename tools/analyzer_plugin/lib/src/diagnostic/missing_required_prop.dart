import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/doc_utils/maturity.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/get_all_props.dart';
import 'package:over_react_analyzer_plugin/src/util/pretty_print.dart';
import 'package:over_react_analyzer_plugin/src/util/required_props.dart';

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
  static const lateRequiredCode = DiagnosticCode(
    'over_react_late_required_prop',
    "Missing required late prop '{0}'.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @DocsMeta(_desc, details: _details, maturity: Maturity.experimental)
  static const annotationRequiredCode = DiagnosticCode(
    'over_react_annotation_required_prop',
    "Missing required prop '{0}'.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  List<DiagnosticCode> get codes => [
        lateRequiredCode,
        annotationRequiredCode,
      ];

  static final fixKind = FixKind('add_required_prop', 200, "Add required prop '{0}'");

  static final _debugCommentPattern = getDebugCommentPattern('over_react_required_props');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // FIXME(null-safety) FED-1720 this probably needs optimization, and may benefit from caching by props element

    var builderType = usage.builder.staticType;
    // Handle generic factories (todo might not be needed)
    if (builderType is TypeParameterType) {
      builderType = builderType.typeOrBound;
    }

    final requiredFieldsByName = <String, FieldElement>{};
    final propRequirednessByName = <String, PropRequiredness>{};
    if (builderType is InterfaceType && builderType.element.name != 'UiProps') {
      for (final propField in getAllProps(builderType.element)) {
        if (requiredFieldsByName.containsKey(propField.name)) {
          // Short-circuit if we've already identified this field as required.
          // There might be duplicates if props are overridden, and there will
          // definitely be duplicates in the builder-generated code.
          continue;
        }

        final requiredness = getPropRequiredness(propField);
        propRequirednessByName[propField.name] = requiredness;
        if (requiredness.isRequired) {
          requiredFieldsByName[propField.name] = propField;
        }
      }
    }

    // FIXME we're running this pattern for every usage; can we make this more efficient?
    final debugHelper = AnalyzerDebugHelper(result, collector, enabled: _debugCommentPattern.hasMatch(result.content));
    debugHelper.log2(() {
      final propNamesByRequiredness = propRequirednessByName.keys.groupSetsBy((name) => propRequirednessByName[name]);
      final prettyMap = propNamesByRequiredness.map((key, value) => MapEntry(key!.name, value));
      return 'Prop requiredness: ${prettyPrint(prettyMap)}';
    }, () => result.locationFor(usage.builder));

    final missingRequiredFieldNames = requiredFieldsByName.keys.toSet()
      ..removeAll(usage.cascadedProps.where((prop) => !prop.isPrefixed).map((prop) => prop.name.name));

    for (final name in missingRequiredFieldNames) {
      final field = requiredFieldsByName[name]!;
      if (isRequiredPropValidationDisabled(field)) {
        continue;
      }

      const codesByRequiredness = {
        PropRequiredness.annotation: annotationRequiredCode,
        PropRequiredness.late: lateRequiredCode,
      };
      final requiredness = propRequirednessByName[name]!;
      final code = codesByRequiredness[requiredness]!;

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
