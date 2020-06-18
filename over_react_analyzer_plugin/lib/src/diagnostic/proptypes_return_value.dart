import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

/// A warning that appears when `throw`ing a `PropError` instead of returning it within `UiComponent2.propTypes`.
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class PropTypesReturnValueDiagnostic extends DiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_proptypes_do_not_throw',
      "Throwing a {0} within propTypes is a no-op. Return the {0} instead.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Return the error');

  @override
  computeErrors(result, collector) async {
    final visitor = PropTypesVisitor();
    result.unit.accept(visitor);
    final throwExpressionsForPropKey = [
       ...visitor.mapVisitor?.values?.map((value) => getDescendantsOfType<ThrowExpression>(value)).toList(),
    ];

    for (final throwExpressions in throwExpressionsForPropKey) {
      for (final throwExpression in throwExpressions) {
        final throwKw = throwExpression.throwKeyword;
        await collector.addErrorWithFix(
          code,
          result.locationFor(throwKw),
          errorMessageArgs: [throwExpression.expression.staticType.getDisplayString()],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(SourceRange(throwKw.offset, throwKw.length), 'return');
          }),
        );
      }
    }
  }
}

class PropTypesVisitor extends SimpleAstVisitor<void> {
  final PropTypesMapVisitor mapVisitor = PropTypesMapVisitor();

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
    if (node.name.name == 'propTypes') {
      node.body.accept(mapVisitor);
    }
  }
}

class PropTypesMapVisitor extends RecursiveAstVisitor<void> {
  final List<FunctionExpression> values = [];

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    values.add(node.value);
  }
}

class PropTypeFunctionBlockVisitor extends RecursiveAstVisitor<void> {
  final List<ThrowExpression> throwExpressions = [];

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    throwExpressions.addAll(node.childEntities?.whereType<ThrowExpression>() ?? []);
  }
}
