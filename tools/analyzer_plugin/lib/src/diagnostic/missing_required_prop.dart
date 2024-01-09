import 'package:analyzer/dart/element/element.dart';
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
    "Missing required late prop {0}.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @DocsMeta(_desc, details: _details, maturity: Maturity.experimental)
  static const annotationRequiredCode = DiagnosticCode(
    'over_react_annotation_required_prop',
    "Missing @requiredProp {0}.",
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

  static final _requiredPropsInfoCache = Expando<_RequiredPropInfo>();

  /// A wrapper around [_getRequiredPropInfo] that caches results per [element],
  /// which greatly improves performance when a component is used more than once.
  ///
  /// This cache is static so it can be shared across multiple files.
  static _RequiredPropInfo _cachedGetRequiredPropInfo(InterfaceElement element) {
    return _requiredPropsInfoCache[element] ??= _getRequiredPropInfo(element);
  }

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // [1] Don't use `ComponentUsage` APIs to get this value since builderType has extra, inefficient steps.

    // Only lint for full inline invocations, and not cases where a builder is
    // saved off to a variable and invoked later.
    if (usage.factory == null) return;

    var builderType = usage.builder.staticType; // [1]
    if (builderType == null) return;

    final propsClassElement = builderType.typeOrBound.element;  // [1]
    if (propsClassElement is! InterfaceElement) return;

    // DOM and SVG components are common and have a large number of props, none of which are required;
    // short-circuit here for performance.
    if (const {'DomProps', 'SvgProps'}.contains(propsClassElement.name)) return; // [1]

    final requiredPropInfo = _cachedGetRequiredPropInfo(propsClassElement);

    // FIXME we're running this pattern for every usage; can we make this more efficient?
    final debugHelper = AnalyzerDebugHelper(result, collector, enabled: _debugCommentPattern.hasMatch(result.content));
    debugHelper.log2(() {
      final propNamesByRequiredness = requiredPropInfo.propRequirednessByName.keys
          .groupSetsBy((name) => requiredPropInfo.propRequirednessByName[name]!);
      final prettyMap = propNamesByRequiredness.map((key, value) => MapEntry(key.name, value));
      return 'Prop requiredness: ${prettyPrint(prettyMap)}';
    }, () => result.locationFor(usage.builder));

    final presentPropNames =
        usage.cascadedProps.where((prop) => !prop.isPrefixed).map((prop) => prop.name.name).toSet();

    for (final name in requiredPropInfo.requiredPropNames) {
      if (presentPropNames.contains(name)) continue;

      final field = requiredPropInfo.requiredFieldsByName[name]!;
      if (isRequiredPropValidationDisabled(field)) {
        continue;
      }

      const codesByRequiredness = {
        PropRequiredness.annotation: annotationRequiredCode,
        PropRequiredness.late: lateRequiredCode,
      };
      final requiredness = requiredPropInfo.propRequirednessByName[name]!;
      final code = codesByRequiredness[requiredness]!;

      await collector.addErrorWithFix(
        code,
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
}

class _RequiredPropInfo {
  final Map<String, FieldElement> requiredFieldsByName;
  final Map<String, PropRequiredness> propRequirednessByName;

  _RequiredPropInfo(this.requiredFieldsByName, this.propRequirednessByName);

  Iterable<String> get requiredPropNames => requiredFieldsByName.keys;
}

_RequiredPropInfo _getRequiredPropInfo(InterfaceElement element) {
  final requiredFieldsByName = <String, FieldElement>{};
  final propRequirednessByName = <String, PropRequiredness>{};
  if (element.name != 'UiProps') {
    for (final propField in getAllProps(element)) {
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
  return _RequiredPropInfo(requiredFieldsByName, propRequirednessByName);
}
