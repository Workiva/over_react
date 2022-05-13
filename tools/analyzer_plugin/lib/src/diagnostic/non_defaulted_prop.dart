//@dart=2.9
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/node.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Use of non defaulted props in funcgtion components';
// <editor-fold desc="Documentation Details">
const _details = r'''

This diagnostic detects syntax errors related to the parentheses around over_react builder cascades.

**Well-formed:**
```
@override
render() {
  return (Dom.div()
    ..id = 'foo'
    ..className = 'foo--variant'
  )(
    'Hi there',
  );
}
```

**Syntax errors due to missing parentheses:**
```
@override
render() {
  return Dom.div()
    ..id = 'foo'
    ..className = 'foo--variant'
  (
    'Hi there',
  );
}
```

''';
// </editor-fold>

class NonDefaultedPropDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_non_defaulted_prop',
    "This prop is used directly. Did you mean to use the '{0}' local variable, which defaults that prop?",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  static final fixKind = FixKind(code.name, 400, "Use local variable '{0}' with default value");

  @override
  computeErrors(result, collector) async {
    final notUsingDefaults = <Tuple2<Expression, VariableDeclaration>>[];

    result.unit.accept(FunctionComponentVisitor((body) {
      final visitor = NonDefaultedPropVisitor();
      body.accept(visitor);
      visitor.defaultedPropVariablesByPropName.forEach((propName, variable) {
        visitor.propAccessesByName[propName]
            ?.where((access) => !variable.containsEntity(access))
            ?.forEach((access) => notUsingDefaults.add(Tuple2(access, variable)));
      });
      // final debug = AnalyzerDebugHelper(result, collector);
      // debug.log('defaultedPropVariablesByPropName: ${visitor.defaultedPropVariablesByPropName}, propAccessesByName: ${visitor.propAccessesByName}');
    }));

    for (final tuple in notUsingDefaults) {
      final access = tuple.item1;
      final variable = tuple.item2;

      final variableName = variable.name.name;

      await collector.addErrorWithFix(
        code,
        result.locationFor(access),
        fixKind: fixKind,
        computeFix: () => buildGenericFileEdit(result, (builder) {
          builder.addSimpleReplacement(range.node(access), variableName);
        }),
        errorMessageArgs: [variableName],
        fixMessageArgs: [variableName],
      );
    }
  }
}

class NonDefaultedPropVisitor extends GeneralizingAstVisitor<void> {
  final propAccessesByName = <String, List<Expression>>{};

  // TODO short-circuit by looking for top-level variable declarations first?
  final defaultedPropVariablesByPropName = <String, VariableDeclaration>{};

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    super.visitVariableDeclaration(node);

    final initializer = node.initializer;
    if (initializer == null) return;

    // todo probably improve this?
    if (initializer is BinaryExpression && initializer.operator.type == TokenType.QUESTION_QUESTION) {
      final parts = getSimpleTargetAndPropertyName(initializer.leftOperand);
      if (parts != null) {
        final targetName = parts.item1;
        if (targetName.name == 'props') {
          final propertyName = parts.item2;
          defaultedPropVariablesByPropName[propertyName.name] = node;
        }
      }
    }
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    super.visitPrefixedIdentifier(node);

    if (node.prefix.name == 'props') {
      propAccessesByName.putIfAbsent(node.identifier.name, () => []).add(node);
    }
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    super.visitPropertyAccess(node);

    final parts = getSimpleTargetAndPropertyName(node);
    if (parts != null) {
      final targetName = parts.item1;
      if (targetName.name == 'props') {
        final propertyName = parts.item2;
        propAccessesByName.putIfAbsent(propertyName.name, () => []).add(node);
      }
    }
  }
}
