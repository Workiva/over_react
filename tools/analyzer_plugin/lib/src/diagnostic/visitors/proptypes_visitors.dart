import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

/// Aggregates the values of the `propTypes` map.
class PropTypesVisitor extends SimpleAstVisitor<void> {
  final PropTypesMapVisitor mapVisitor = PropTypesMapVisitor();

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.declaredElement?.isComponentClass ?? false) {
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
    final value = node.value;
    if (value is FunctionExpression) {
      values.add(value);
    }
  }
}
