import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/node.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Use of non defaulted props in function components';
// <editor-fold desc="Documentation Details">
const _details = r'''

This diagnostic detects when a prop that has a default value in a function component is used directly instead of its defaulted equivalent,
since this is usually a mistake, and can result in unexpected null errors.

**BAD:** `props.content` is used instead of `content` which defaults the prop.
```
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    // Default props
    final content = props.content ?? 'abc';

    return Dom.div()(props.content);
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {
  String content;
}
```

**GOOD:**
```
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    // Default props
    final content = props.content ?? 'abc';

    return Dom.div()(content);
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {
  String content;
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

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 400, "Use local variable '{0}' with default value");

  @override
  computeErrors(result, collector) async {
    final notUsingDefaults = <Tuple2<Expression, VariableDeclaration>>[];

    result.unit.accept(FunctionComponentVisitor((component) {
      final visitor = NonDefaultedPropVisitor();
      component.body.accept(visitor);
      visitor.defaultedPropVariablesByPropName.forEach((propName, variable) {
        visitor.propAccessesByName[propName]?.where((access) => !variable.containsEntity(access)).forEach(
          (access) => notUsingDefaults.add(Tuple2(access, variable)),
        );
      });
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
      final parts = getSimpleTargetAndPropertyName(initializer.leftOperand, allowMethodInvocation: true);
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

    if (node.target.tryCast<SimpleIdentifier>()?.name == 'props') {
      propAccessesByName.putIfAbsent(node.propertyName.name, () => []).add(node);
    }
  }
}
