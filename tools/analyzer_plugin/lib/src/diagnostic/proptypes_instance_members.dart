import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/pseudo_static_lifecycle.dart' show instanceMemberWhitelist;
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/non_static_reference_visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/proptypes_visitors.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = 'Never reference instance members within propTypes.';
// <editor-fold desc="Documentation Details">
const _details = '''

The function body of the callback set as the value for each key in the `propTypes` map must be treated as `static`.

Accessing instance members from within the callback is prohibited, and will cause runtime errors.

Access to `props` is made available via the `props` argument of the callback.

**GOOD:**
```
class WidgetComponent extends UiComponent2<WidgetProps> {
  @override
  get propTypes => {
    keyForProp((p) => p.prop1): (props, info) {
      // Accessing static methods is ok.
      if (!someVerbosePropEvaluation(props)) {
        return PropError.value(props.prop1, info.propName);
      }
      return null;
    },
  };
  
  static bool someVerbosePropEvaluation(WidgetProps propsMap) {
    // This method is meant to demonstrate that some prop validation logic may be verbose
    // enough to place in its own method to make the `propTypes` declaration easier to read.
    return propsMap.prop1 > 0; 
  }
}
```

**BAD:**
```
class WidgetComponent extends UiComponent2<WidgetProps> {
  @override
  get propTypes => {
    keyForProp((p) => p.prop1): (props, info) {
      // Do not access instance methods!
      if (!someVerbosePropEvaluation()) {
        // Do not access props using `this`!
        return PropError.value(this.props.prop1, info.propName);
      }
      return null;
    },
  };
  
  bool someVerbosePropEvaluation() {
    // This method is meant to demonstrate that some prop validation logic may be verbose
    // enough to place in its own method to make the `propTypes` declaration easier to read.
    return props.prop1 > 0; 
  }
}
```

''';
// </editor-fold>

/// An error that appears when accessing instance members of a class in propTypes values
///
/// {@category Diagnostics}
/// {@subCategory Errors}
class PropTypesInstanceMembersDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_proptypes_do_not_access_instance_members',
    _desc,
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    correction: 'It must be treated as a static method.',
  );

  @override
  computeErrors(result, collector) async {
    final visitor = PropTypesVisitor();
    result.unit.accept(visitor);

    for (final value in visitor.mapVisitor?.values) {
      final blockVisitor = ReferenceVisitor();

      value.accept(blockVisitor);
      for (final reference in blockVisitor.nonStaticReferences) {
        if (reference is SimpleIdentifier && instanceMemberWhitelist.contains(reference.name)) {
          continue;
        }

        if (reference is SuperExpression) {
          // Do not lint calls to super.propTypes
          if (reference.parent.tryCast<PropertyAccess>()?.propertyName?.name == 'propTypes') continue;
        }

        collector.addError(
          code,
          result.locationFor(reference),
        );
      }
    }
  }
}
