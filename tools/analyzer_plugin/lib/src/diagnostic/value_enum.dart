import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

class ValueEnumDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_prop_value_enum',
    "Prop '{0}' was set to '{1}'. It must be one of the following values: {2}",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  static final fixKind = FixKind(code.name, 200, 'Use one of the allowed values.');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    var builderType = usage.builder.staticType;
    // Handle generic factories (todo might not be needed)
    while (builderType is TypeParameterType) {
      builderType = (builderType as TypeParameterType).bound;
    }
    final configForProp = <String, ValueEnumConfig>{};

    // todo check if factory invocation
    if (builderType is InterfaceType &&
        builderType.element?.name != 'UiProps') {
      final classAndSuperclasses = [
        builderType.element,
        ...builderType.element.allSupertypes.map((t) => t.element)
      ];
      final allFields = classAndSuperclasses.expand((c) => c.fields);
      for (final field in allFields) {
        for (final annotation in field.metadata) {
          // Common case, might be good to short circuit here for perf
          if (annotation.isOverride) continue;
          if (annotation.element?.thisOrAncestorOfType<ClassElement>()?.name == 'Enum') {
            final constantValue = annotation.computeConstantValue();

            final allowedValuesFieldValue = constantValue?.getField('allowedValues');
            final classWithAllowedValuesFieldValue = constantValue?.getField('classWithAllowedValues');
            if (!(allowedValuesFieldValue?.isNull ?? true)) {
              final values = allowedValuesFieldValue
                  .toSetValue()
                  // todo deep convert?
                  ?.map((o) => o.toWhateverValue())
                  ?.toSet();
              if (values != null) {
                configForProp[field.name] = ValueEnumConfig.fromValues(values);
              }
            } else if (!(classWithAllowedValuesFieldValue?.isNull ?? true)) {
              final classWithAllowedValues = classWithAllowedValuesFieldValue.toTypeValue()?.element?.tryCast<ClassElement>();
              if (classWithAllowedValues != null) {
                configForProp[field.name] = ValueEnumConfig.fromClass(classWithAllowedValues);
              }
            }
          }
        }
      }
    }

    for (final prop in usage.cascadedProps) {
      final allowedValues = configForProp[prop.name.name];
      if (allowedValues == null) continue;

      final constantValue = prop.rightHandSide.accept(ConstantEvaluator());
      if (constantValue != ConstantEvaluator.NOT_A_CONSTANT && !allowedValues.values.contains(constantValue)) {
        await collector.addErrorWithFix(
          code,
          result.locationFor(prop.rightHandSide),
          errorMessageArgs: [
            prop.name,
            "$constantValue",
            allowedValues.valuesString,
          ],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addReplacement(range.node(prop.rightHandSide), (builder) {
              builder.addSimpleLinkedEdit(
                'value',
                allowedValues.suggestedValueSources.firstOrNull ?? '',
                kind: LinkedEditSuggestionKind.VARIABLE,
                suggestions: allowedValues.suggestedValueSources,
              );
            });
          }),
        );
      }
    }
  }
}

class ValueEnumConfig {
  final Set<Object> values;
  final String valuesString;
  final List<String> suggestedValueSources;

  ValueEnumConfig._(this.values, this.valuesString, this.suggestedValueSources);
  ValueEnumConfig.fromValues(this.values) : valuesString = values.map((value) => "'$value'").join(', '),
        suggestedValueSources = values.map((value) => value is String ? _stringLiteral(value) : value.toString()).toList();

  factory ValueEnumConfig.fromClass(ClassElement classElement) {
    final values = <Object>{};
    final valueStrings = <String>[];
    final suggestedValueSources = <String>[];
    for (final field in classElement.fields.where((f) => f.isStatic && f.isConst)) {
      final value = field.computeConstantValue()?.toWhateverValue();
      values.add(value);
      suggestedValueSources.add('${classElement.name}.${field.name}');
      valueStrings.add("'$value' (${classElement.name}.${field.name})");
    }
    return ValueEnumConfig._(values, valueStrings.join(', '), suggestedValueSources);
  }

  // FIXME use a real implementation
  static String _stringLiteral(String string) {
    final useSingleQuote = !string.contains("'");
    final quoteToUse = useSingleQuote ? "'" : '"';
    final kindaEscaped = string
        .replaceAll(r'$', r'\\')
        .replaceAll(r'\', r'\\')
        .replaceAll(quoteToUse, r'\' + quoteToUse);
    return quoteToUse + kindaEscaped + quoteToUse;
  }
}
