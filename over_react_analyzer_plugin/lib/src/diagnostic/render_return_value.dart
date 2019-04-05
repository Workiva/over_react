// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class RenderReturnValueDiagnostic extends SubDiagnostic {
  @override
  String get name => 'over-react-render-return-value';

  @override
  String get description =>
      '';

  @override
  void check(ResolvedUnitResult result) {
    super.check(result);

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
      final returnTypeName = returnType?.name;

      if (!allowedTypes.contains(returnTypeName)) {
        var message = 'Invalid render() return type: `${returnType.displayName}`. Must be a ReactElement, null, or false.';
        List<SourceEdit> fixEdits;
        String fixMessage;

        if (couldBeMissingBuilderInvocation(returnExpression)) {
          message += missingBuilderMessageSuffix;
          fixEdits = getMissingInvocationBuilderEdits(returnExpression);
          fixMessage = missingBuilderFixMessage;
        }

        addError(message: message, offset: returnStatement.offset, end: returnStatement.end, fixMessage: fixMessage, fixEdits: fixEdits);
      } else if (returnTypeName == 'bool' && returnExpression is BooleanLiteral && returnExpression.value == false) {
        addHint(
          message: 'Prefer returning null over false in render. (The dart2js bug involving null has been fixed.)',
          offset: returnExpression.offset,
          end: returnExpression.end,
          fixMessage: 'Change to null',
          fixEdits: [new SourceEdit(returnExpression.offset, returnExpression.length, 'null')],
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
