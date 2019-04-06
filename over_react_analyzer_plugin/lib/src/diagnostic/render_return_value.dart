import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class RenderReturnValueDiagnostic extends DiagnosticContributor {
  static final react15InvalidTypeErrorCode = ErrorCode(
      'over-react-invalid-render-return-type',
      "Invalid render() return type: '{0}'. Must be a ReactElement, null, false.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final react16InvalidTypeErrorCode = ErrorCode(
      'over-react-invalid-render-return-type',
      "Invalid render() return type: '{0}'. Must be a ReactElement, Fragment, null, false, or an Iterable of those types.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final preferNullOverFalseErrorCode = ErrorCode(
      'over_react_prefer_null_over_false',
      'Prefer returning null over false in render. (The dart2js bug involving null has been fixed.)',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final nullToFalseFix = FixKind(
      preferNullOverFalseErrorCode.name, 200, missingBuilderFixMessage);

  @override
   computeErrors(result, collector) async {
    // This is the return type even if it's not explicitly declared.
    final visitor = new RenderVisitor();
    result.unit.accept(visitor);

    final returnStatements = visitor.returnVisitor.returnStatements.toList();

    const allowedTypes = [
      'ReactElement',
      // 'ReactFragment',
      'Null',
      'null',
      'dynamic',
      'void',
      'bool', // support `return false;` to render nothing
    ];
    
    for (var returnStatement in returnStatements) {
      final returnExpression = returnStatement.expression;
      if (returnExpression == null) continue; // valueless returns
      final returnType = returnExpression.staticType;
      if (returnType == null || returnType.isUndefined || returnType.isObject || returnType.isVoid) {
        continue;
      }

      if (!allowedTypes.contains(returnType.name)) {
        // todo check if React 16
        final code = react15InvalidTypeErrorCode;
        final location = this.location(result, range: range.node(returnStatement));

        if (couldBeMissingBuilderInvocation(returnExpression)) {
          await collector.addErrorWithFix(code, location,
            errorMessageArgs: [returnType.name, missingBuilderMessageSuffix],
            fixKind: addBuilderInvocationFix,
            computeFix: () async {
              final builder = new DartChangeBuilder(result.session);
              await builder.addFileEdit(result.path, (builder) {
                buildMissingInvocationEdits(returnExpression, builder);
              });
              return builder.sourceChange;
            },
          );
        } else {
          await collector.addError(code, location, errorMessageArgs: [returnType.name, '']);
        }
      } else if (returnType.name == 'bool' && returnExpression is BooleanLiteral && returnExpression.value == false) {
        await collector.addErrorWithFix(
          preferNullOverFalseErrorCode,
          location(result, range: range.node(returnExpression)),
          computeFix: () async {
            final builder = new DartChangeBuilder(result.session);
            await builder.addFileEdit(result.path, (builder) {
              builder.addSimpleReplacement(range.node(returnExpression), 'null');
            });
            return builder.sourceChange;
          },
        );
      }
    }
  }
}

//
bool hasComponentAnnotation(AnnotatedNode c) =>
    c.metadata.any((m) => m.toSource().contains('Component'));

class RenderVisitor extends SimpleAstVisitor<void> {
  RenderReturnVisitor returnVisitor = new RenderReturnVisitor();

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
