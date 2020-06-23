import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

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

    for (final consumedPropsDecl in consumedPropsDeclarations) {
      final expression = consumedPropsDecl.body.returnExpressions.firstOrNull;
      if (expression is ListLiteral && expression.elements.isNotEmpty) {
        final elements = expression.elements;
        final shouldAddError = elements.every((element) =>
            element is MethodInvocation &&
            element.methodName.name == 'forMixin' &&
            element.realTarget.tryCast<Identifier>()?.name == 'propsMeta');
        if (shouldAddError) {
          await collector.addErrorWithFix(
            code,
            result.locationFor(expression),
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addReplacement(range.node(expression), (builder) {
                var mixinList = elements
                    .map((element) => (element as MethodInvocation).argumentList.arguments.firstOrNull?.toSource())
                    .join(', ');
                if (elements.length > 1) {
                  mixinList += ', ';
                }
                builder.write('propsMeta.forMixins({$mixinList})');
              });
              builder.format(range.node(consumedPropsDecl));
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
    if (node.declaredElement.isComponentClass) {
      node.visitChildren(this);
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    if (node.declaredElement.isComponentClass) {
      node.visitChildren(this);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.name == 'consumedProps') {
      consumedPropsDeclarations.add(node);
    }
  }
}
