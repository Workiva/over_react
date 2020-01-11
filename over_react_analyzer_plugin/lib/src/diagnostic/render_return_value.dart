import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class RenderReturnValueDiagnostic extends DiagnosticContributor {
  static final invalidTypeErrorCode = ErrorCode(
      'over_react_invalid_render_return_type',
      "Invalid render() return type: '{0}'. Must be a ReactElement, primitive value, or an Iterable of those types.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final preferNullOverFalseErrorCode = ErrorCode(
      'over_react_prefer_null_over_false',
      'Prefer returning null over false in render. (The dart2js bug involving null has been fixed.)',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final falseToNull = FixKind(
      preferNullOverFalseErrorCode.name, 200, missingBuilderFixMessage);

  @override
   computeErrors(result, collector) async {
    final typeSystem = result.unit.declaredElement.context.typeSystem;

    // This is the return type even if it's not explicitly declared.
    final visitor = RenderVisitor();
    result.unit.accept(visitor);
    for (var returnStatement in visitor.returnVisitor.returnStatements) {
      final returnExpression = returnStatement.expression;
      if (returnExpression == null) continue; // valueless returns
      final returnType = returnExpression.staticType;
      if (returnType == null || returnType.isDynamic || returnType.isObject || returnType.isVoid) {
        continue;
      }

      await validateReactChildType(returnType, typeSystem, onInvalidType: (invalidType) async {
        final code = invalidTypeErrorCode;
        final location = this.location(result, range: range.node(returnStatement));
        if (couldBeMissingBuilderInvocation(returnExpression)) {
          await collector.addErrorWithFix(code, location,
            errorMessageArgs: [returnType.name, missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () => buildFileEdit(result, (builder) {
              buildMissingInvocationEdits(returnExpression, builder);
            }),
          );
        } else {
          collector.addError(code, location, errorMessageArgs: [returnType.name, '']);
        }
      });

      if (returnType.isDartCoreBool && returnExpression is BooleanLiteral && returnExpression.value == false) {
        await collector.addErrorWithFix(
          preferNullOverFalseErrorCode,
          location(result, range: range.node(returnExpression)),
          fixKind: falseToNull,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(range.node(returnExpression), 'null');
          }),
        );
      }
    }
  }
}

//
bool hasComponentAnnotation(ClassDeclaration c) =>
    c.declaredElement.allSupertypes.any((m) => m.name == 'Component');

class RenderVisitor extends SimpleAstVisitor<void> {
  RenderReturnVisitor returnVisitor = RenderReturnVisitor();

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (hasComponentAnnotation(node)) {
      node.visitChildren(this);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.name == 'render') {
      node.body.accept(returnVisitor);
    }
  }
}

class RenderReturnVisitor extends RecursiveAstVisitor<void> {
  List<ReturnStatement> returnStatements = [];

  @override
  void visitReturnStatement(ReturnStatement node) {
    returnStatements.add(node);
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    // Don't look inside nested functions
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Don't look inside nested functions
  }
}
