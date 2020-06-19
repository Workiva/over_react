import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

/// A lint for when `consumedProps` returns a list literal that could be
/// converted to `propsMeta.forMixins(...)`.
class ConsumedPropsReturnValueDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_consumed_props_return_value',
    "Return propsMeta.forMixins(...) instead of list literal.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );

  static final fixKind = FixKind(
    code.name,
    200,
    'Convert to propsMeta.forMixins(...) syntax.',
  );

  @override
  computeErrors(result, collector) async {
    final visitor = ConsumedPropsVisitor();

    result.unit.accept(visitor);

    final consumedPropsDeclarations = visitor.consumedPropsDeclarations;
    Expression expression;

    for (final consumedPropsDecl in consumedPropsDeclarations) {
      final body = consumedPropsDecl.body;
      if (body is ExpressionFunctionBody) {
        expression = body.expression;
      } else if (body is BlockFunctionBody) {
        expression = body.block.statements.whereType<ReturnStatement>()?.first?.expression;
      }

      if (expression != null && expression is ListLiteral && expression.elements.isNotEmpty) {
        final elements = (expression as ListLiteral).elements;
        final shouldAddError = elements.every((element) =>
            element is MethodInvocation &&
            element.methodName.name == 'forMixin' &&
            element.realTarget.toSource() == 'propsMeta');
        if (shouldAddError) {
          await collector.addErrorWithFix(
            code,
            result.locationFor(expression),
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addReplacement(range.node(expression), (builder) {
                var mixinList = '';
                for (final element in elements) {
                  mixinList += '${(element as MethodInvocation).argumentList.arguments.first}';
                  if (elements.length > 1) {
                    mixinList += ', ';
                  }
                }
                builder.write('propsMeta.forMixins({$mixinList});');
              });
              builder.format(range.startLength(consumedPropsDecl, consumedPropsDecl.end + 1));
            }),
          );
        }
      }
    }
  }
}

class ConsumedPropsVisitor extends SimpleAstVisitor<void> {
  List<MethodDeclaration> consumedPropsDeclarations = [];

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    node.visitChildren(this);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final classNode = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classNode.declaredElement.isComponentClass && node.name.name == 'consumedProps') {
      consumedPropsDeclarations.add(node);
    }
  }
}
