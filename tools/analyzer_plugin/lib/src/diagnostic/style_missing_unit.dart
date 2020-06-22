import 'package:analyzer/analyzer.dart' show ConstantEvaluator;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

const _correction =
    r'Use CSS property values that are strings _with_ units, or numbers _(in which case `px` will be inferred)_.';
const _desc = r'Do not use string CSS property values without specifying a unit.';
// <editor-fold desc="Documentation Details">
const _details = '''

**ALWAYS** $_correction

**GOOD:**
```
@override
render() {
  return (Dom.div()..style = {'width': 80})(
    'I am eighty pixels wide!',
  );
}
```

**GOOD:**
```
@override
render() {
  return (Dom.div()..style = {'width': '80px'})(
    'I am also eighty pixels wide!',
  );
}
```

**BAD:**
```
@override
render() {
  return (Dom.div()..style = {'width': '80'})(
    'I never rendered because of a ReactJS runtime error :(',
  );
}
```

''';
// </editor-fold>

class StyleMissingUnitDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_style_missing_unit',
    _desc,
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.SYNTACTIC_ERROR,
    correction: _correction,
  );

  static final fixKind = FixKind(code.name, 200, "Convert to number (and treat as 'px')",
      appliedTogetherMessage: "Convert to numbers (and treat as 'px')");

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // Collect these then iterate later to make keeping things async simpler
    final styleEntries = <MapLiteralEntry>[];
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'style') {
        rhs.accept(_RecursiveMapLiteralEntryVisitor(styleEntries.add));
      }
    });

    for (final entry in styleEntries) {
      final propertyName = _stringValueIfApplicable(entry.key);
      if (propertyName == null) continue;

      if (unitlessNumberStyles.contains(propertyName) || _isCustomProperty(propertyName)) {
        continue;
      }

      // Only worry about strings, since numbers get values
      final stringValue = _stringValueIfApplicable(entry.value);
      if (stringValue == null) continue;

      if (num.tryParse(stringValue) != null) {
        final location = result.locationFor(entry.value);
        final errorArgs = [propertyName, stringValue];

        // Don't suggest the change if this is an interpolated string,
        // reference to constant variable, etc.
        if (entry.value is SimpleStringLiteral) {
          await collector.addErrorWithFix(
            code,
            location,
            errorMessageArgs: errorArgs,
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addSimpleReplacement(range.node(entry.value), stringValue);
            }),
          );
        } else {
          collector.addError(code, location, errorMessageArgs: errorArgs);
        }
      }
    }
  }
}

class _RecursiveMapLiteralEntryVisitor extends RecursiveAstVisitor<void> {
  _RecursiveMapLiteralEntryVisitor(this.onMapLiteralEntry);

  final void Function(MapLiteralEntry) onMapLiteralEntry;

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    onMapLiteralEntry(node);
    node.visitChildren(this);
  }
}

String _stringValueIfApplicable(Expression value) {
  final constantValue = value.accept(ConstantEvaluator());
  return constantValue is String ? constantValue : null;
}

bool _isCustomProperty(String propertyName) => propertyName.startsWith('--');

// From React's CssProperty
const unitlessNumberStyles = {
  'animationIterationCount',
  'borderImageOutset',
  'borderImageSlice',
  'borderImageWidth',
  'boxFlex',
  'boxFlexGroup',
  'boxOrdinalGroup',
  'columnCount',
  'flex',
  'flexGrow',
  'flexPositive',
  'flexShrink',
  'flexNegative',
  'flexOrder',
  'gridRow',
  'gridRowEnd',
  'gridRowSpan',
  'gridRowStart',
  'gridColumn',
  'gridColumnEnd',
  'gridColumnSpan',
  'gridColumnStart',
  'fontWeight',
  'lineClamp',
  'lineHeight',
  'opacity',
  'order',
  'orphans',
  'tabSize',
  'widows',
  'zIndex',
  'zoom',

  // SVG-related properties
  'fillOpacity',
  'floodOpacity',
  'stopOpacity',
  'strokeDasharray',
  'strokeDashoffset',
  'strokeMiterlimit',
  'strokeOpacity',
  'strokeWidth'
};
