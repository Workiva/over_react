import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/component_usage.dart';

class DuplicatePropCascadeChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-duplicate-prop-cascade';

  @override
  String get description =>
      'Verifies that props aren\'t set more than once in the same cascade, which is usually a typo.';

  @override
  void visitComponentUsage(
      CompilationUnitElement element, FluentComponentUsage usage) {
    final cascade = usage.cascadeExpression;
    if (cascade == null) {
      return;
    }

    final settersByName = <String, List<AssignmentExpression>>{};

    for (var section in cascade.cascadeSections) {
      if (section is AssignmentExpression) {
        final lhs = section.leftHandSide;
        if (lhs is PropertyAccess) {
          (settersByName[lhs.propertyName.name] ??= []).add(section);
        }
      }
    }

    settersByName.forEach((name, setters) {
      if (setters.length > 1) {
        for (var i = 0; i < setters.length; i++) {
          var setter = setters[i];
          emitHint(
            message:
                'Prop `$name` is cascaded multiple times (${i + 1} of ${setters.length}). This is most likely a typo.',
            offset: setter.leftHandSide.offset,
            end: setter.leftHandSide.end,
          );
        }
      }
    });
  }
}
