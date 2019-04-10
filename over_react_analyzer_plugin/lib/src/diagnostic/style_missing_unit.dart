import 'package:analyzer/analyzer.dart' show ConstantEvaluator;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class StyleMissingUnitDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = new ErrorCode(
      'over_react_style_missing_unit',
      // TODO upgrade to error in React 16
      "React CSS values must be strings with units, or numbers (in which case 'px' will be used). This will break in React 16.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final fixKind = FixKind(code.name, 200,
      "Convert to number (and treat as 'px')",
      appliedTogetherMessage: "Convert to numbers (and treat as 'px')");

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // Collect these then iterate later to make keeping things async simpler
    final styleEntries = <MapLiteralEntry>[];
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'style') {
        rhs.accept(new _RecursiveMapLiteralEntryVisitor(styleEntries.add));
      }
    });

    for (var entry in styleEntries) {
      final propertyName = _stringValueIfApplicable(entry.key);
      if (propertyName == null) continue;

      if (unitlessNumberStyles.contains(propertyName) || _isCustomProperty(propertyName)) {
        continue;
      }

      // Only worry about strings, since numbers get values
      final stringValue = _stringValueIfApplicable(entry.value);
      if (stringValue == null) continue;

      if (num.tryParse(stringValue) != null) {
        final location = this.location(result, range: range.node(entry.value));
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

