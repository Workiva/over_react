import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/constants.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

const _invalidTypeDesc = r'Do not return unsupported types from the render method.';
// <editor-fold desc="Invalid Type Documentation Details">
const _invalidTypeDetails = '''

The return value of a component `render()` method must be $supportedOverReactChildTypes

**GOOD:**
```
@override
render() {
  return Dom.div()(
    'Hi there',
  );
}
```

**GOOD:**
```
@override
render() {
  return Fragment()(
    Dom.div()(
      NavItem()('Nav\'in it, you know?'),
    ),
    (Dom.button()..type = 'button')('Click me'),
  );
}
```

**GOOD:**
```
@override
render() {
  return null;
}
```

**BAD:**
```
@override
render() {
  return {
    'foo': 'bar',
  };
}
```

''';
// </editor-fold>

const _preferNullDesc = r'Avoid returning false from the render method.';
// <editor-fold desc="Prefer Null Documentation Details">
const _preferNullDetails = r'''

**PREFER** to use a return value of `null` when your intention is to have a component render nothing.

**GOOD:**
```
@override
render() {
  if (props.models.isEmpty) return null;
  
  return Fragment()(
    props.models.map(_renderItemFromModel),
  );
}
```

**BAD:**
```
@override
render() {
  if (props.models.isEmpty) return false;
  
  return Fragment()(
    props.models.map(_renderItemFromModel),
  );
}
```

''';
// </editor-fold>

class RenderReturnValueDiagnostic extends DiagnosticContributor {
  @DocsMeta(_invalidTypeDesc, details: _invalidTypeDetails)
  static const invalidTypeErrorCode = DiagnosticCode(
    'over_react_invalid_render_return_type',
    "Invalid 'render()' return type: '{0}'.",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_TYPE_WARNING,
    correction: 'Try returning one of the supported types: $supportedOverReactChildTypes.',
  );

  @DocsMeta(_preferNullDesc, details: _preferNullDetails)
  static const preferNullOverFalseErrorCode = DiagnosticCode(
    'over_react_prefer_null_over_false_render_return_type',
    _preferNullDesc,
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
    correction: 'Return null instead.',
  );

  static final falseToNull = FixKind(preferNullOverFalseErrorCode.name, 200, missingBuilderFixMessage);

  @override
  computeErrors(result, collector) async {
    // This is the return type even if it's not explicitly declared.
    final visitor = RenderVisitor();
    result.unit.accept(visitor);
    for (final returnExpression in visitor.renderReturnExpressions) {
      final returnType = returnExpression.staticType;
      if (returnType == null || returnType.isDynamic || returnType.isDartCoreObject || returnType.isVoid) {
        continue;
      }

      await validateReactChildType(returnType, result.typeSystem, result.typeProvider,
          onInvalidType: (invalidType) async {
        const code = invalidTypeErrorCode;
        final location = result.locationFor(returnExpression);
        if (couldBeMissingBuilderInvocation(returnExpression)) {
          await collector.addErrorWithFix(
            code,
            location,
            errorMessageArgs: [returnType.getDisplayString(), missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () => buildFileEdit(result, (builder) {
              buildMissingInvocationEdits(returnExpression, builder);
            }),
          );
        } else {
          collector.addError(code, location, errorMessageArgs: [returnType.getDisplayString()]);
        }
      });

      if (returnType.isDartCoreBool && returnExpression is BooleanLiteral && returnExpression.value == false) {
        await collector.addErrorWithFix(
          preferNullOverFalseErrorCode,
          result.locationFor(returnExpression),
          fixKind: falseToNull,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(range.node(returnExpression), 'null');
          }),
        );
      }
    }
  }
}

class RenderVisitor extends SimpleAstVisitor<void> {
  final renderReturnExpressions = <Expression>[];

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.declaredElement.isComponentClass) {
      node.visitChildren(this);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.name == 'render') {
      renderReturnExpressions.addAll(node.body.returnExpressions);
    }
  }
}
