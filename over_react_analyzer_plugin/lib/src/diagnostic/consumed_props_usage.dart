import 'dart:math';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

class ConsumedPropsUsageDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_bool_prop_name_readability',
    "Return propsMeta.forMixins() instead of list literal.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );

  static final fixKind = FixKind(
    code.name,
    200,
    'Convert to propsMeta.forMixins() syntax.',
  );

  @override
  computeErrors(result, collector) async {
    final visitor = ConsumedPropsVisitor();

    result.unit.accept(visitor);

    final returnMixins = visitor.returnMixins;

    for (final r in returnMixins) {
      final body = r.body;
      if (body is ExpressionFunctionBody) {
        final expression = body.expression;
        if (expression is ListLiteral && expression.elements.isNotEmpty) {
          final elements = expression.elements;
          final shouldAddError = elements.every((element) =>
              element is MethodInvocation &&
              element.methodName.name == 'forMixin' &&
              element.realTarget.toSource() == 'propsMeta');
          if(shouldAddError) {
              await collector.addErrorWithFix(
                code,
                result.locationFor(expression),
                errorMessageArgs: [
                  (expression.elements.first as MethodInvocation).argumentList.arguments.first,
                  '',
                ],
                fixKind: fixKind,
                computeFix: () => buildFileEdit(result, (builder) {
                  builder.addReplacement(range.node(expression), (builder) {
                    var mixinList = '';
                    for (final element in elements) {
                      mixinList += '${(element as MethodInvocation).argumentList.arguments.first}';
                      if(element != elements.last) {
                        mixinList += ', ';
                      }
                    }
                    builder.write(' propsMeta.forMixins({$mixinList})');
                  });
                }),
              );
          }
        }
      }
    }
  }
}

class ConsumedPropsVisitor extends SimpleAstVisitor<void> {
  List<MethodDeclaration> returnMixins = [];

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
      returnMixins.add(node);
    }
  }
}
