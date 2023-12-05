import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/class_components.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

// FIXME add description, maybe borrow from JS lint
const _desc = r'';
// <editor-fold desc="Documentation Details">
const _details = r'''

''';
// </editor-fold>

class NestedComponentDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
      'over_react_nested_components',
      "Don't declare components within {0}.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING,
      url: 'https://react.dev/learn/preserving-and-resetting-state#:~:text=This%20is%20why%20you%20should%20not%20nest%20component%20function%20definitions.',
      correction: 'Try making this component a top level variable instead, and passing in any data as props.');

  @override
  List<DiagnosticCode> get codes => [code];

  @override
  computeErrors(result, collector) async {
    final expressions = <Expression>[];

    result.unit.accept(ComponentDeclarationExpressionVisitor(expressions.add));

    for (final expression in expressions) {
      late final isWithinFunctionComponent = getClosestFunctionComponentBody(expression) != null;
      late final isWithinClassComponent = getClosestClassComponent(expression) != null;
      if (isWithinFunctionComponent || isWithinClassComponent) {
        collector.addError(code, result.locationFor(expression), errorMessageArgs: ['other components']);
      }
    }
  }
}

class ComponentDeclarationExpressionVisitor extends RecursiveAstVisitor<void> {
  final void Function(Expression) onComponent;

  ComponentDeclarationExpressionVisitor(this.onComponent);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (const {'uiFunction', 'uiForwardRef', 'connect', 'memo'}.contains(node.methodName.name)) {
      final element = node.methodName.staticElement;
      if (element != null && element.isDeclaredInPackage('over_react') && element.enclosingElement is CompilationUnitElement) {
        onComponent(node);
      }
    }
  }
}
