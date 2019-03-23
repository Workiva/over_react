import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class MissingRequiredPropChecker extends ComponentUsageChecker {
  @override
  String get name => 'missing-required-prop';

  @override
  String get description =>
      '';

  ClassElement _cachedAccessorClass;

  @override
  void check(ResolvedUnitResult result) {
    _cachedAccessorClass = null;
    super.check(result);
  }

  @override
  void visitComponentUsage(CompilationUnit unit, FluentComponentUsage usage) {
    final requiredFields = <FieldElement>[];

    // FIXME this almost definitely needs optimization/caching

    final builderType = usage.builder.staticType;
    // todo check if factory invocation
    if (builderType != null && builderType.name != 'UiProps') {
      if (builderType is InterfaceType) {
        final classAndSuperclasses = [builderType.element]
          ..addAll(builderType.element.allSupertypes.map((t) => t.element));
        final allFields = classAndSuperclasses.expand((c) => c.fields);
        requiredFields.addAll(allFields.where((field) {
          return field.metadata.any((annotation) {
            // Common case, might be good to short circuit here for perf
            if (annotation.isOverride) return false;

            final value = annotation.computeConstantValue();
            final type = value?.type;
            final typeLibrary = type?.element?.library;
            if (typeLibrary?.name != 'over_react.component_declaration.annotations') {
              return false;
            }

            _cachedAccessorClass ??= typeLibrary.getType('Accessor');
            if (!type.isAssignableTo(_cachedAccessorClass.type)) {
              return false;
            }

            // This is null when isRequired does not have a valid value
            // (e.g., as the user is typing it in)
            return value.getField('isRequired').toBoolValue() ?? false;
          });
        }));
      } else {
        // todo TypeParameterType
      }
    }

    final missingRequiredFieldNames = requiredFields.map((f) => f.name).toSet();

    forEachCascadedProp(usage, (lhs, rhs) {
      missingRequiredFieldNames.remove(lhs.propertyName.name);
    });

    for (var name in missingRequiredFieldNames) {
      emitWarning(
        message: 'Missing required prop `$name`',
        offset: usage.builder.offset,
        end: usage.builder.end,
        // todo fix to add prop
      );
    }
  }
}
