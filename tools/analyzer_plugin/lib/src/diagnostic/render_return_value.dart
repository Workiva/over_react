import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/invalid_child.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

class RenderReturnValueDiagnostic extends DiagnosticContributor {
  static final invalidTypeErrorCode = DiagnosticCode(
      'over_react_invalid_render_return_type',
      "Invalid render() return type: '{0}'. Must be a ReactElement, primitive value, or an Iterable of those types.{1}",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final preferNullOverFalseErrorCode = DiagnosticCode(
      'over_react_prefer_null_over_false',
      'Prefer returning null over false in render. (The dart2js bug involving null has been fixed.)',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

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
        final code = invalidTypeErrorCode;
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
          collector.addError(code, location, errorMessageArgs: [returnType.getDisplayString(), '']);
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
