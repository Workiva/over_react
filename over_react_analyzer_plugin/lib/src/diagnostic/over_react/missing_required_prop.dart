import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/util.dart';

class MissingRequiredPropChecker extends ComponentUsageChecker {
  @override
  String get name => 'missing-required-prop';

  @override
  String get description =>
      '';

  @override
  void visitComponentUsage(CompilationUnit unit, FluentComponentUsage usage) {
    final requiredFields = <FieldElement>[];

    // FIXME this almost definitely needs optimization/caching

    final builderType = usage.builder.staticType;
    // todo check if factory invocation
    if (builderType != null && builderType.name != 'UiProps') {
      if (builderType is InterfaceType) {
        final classAndSuperclasses = [builderType.element]..addAll(builderType.element.allSupertypes.map((t) => t.element));
        final allFields = classAndSuperclasses.expand((c) => c.fields);
        requiredFields.addAll(allFields.where((field) {
          return field.metadata.any((annotation) {
            final element = annotation.element;
            return
                element is PropertyAccessorElement &&
                element.name == 'requiredProp' &&
                element.library?.name == 'over_react.component_declaration.annotations';
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
