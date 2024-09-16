import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

DartType? getTypeOfPropsInEnclosingInterface(AstNode node) {
  final enclosingInterface = _getEnclosingInterface(node);
  if (enclosingInterface == null) return null;

  return enclosingInterface.thisType.lookUpGetter2('props', enclosingInterface.library)?.returnType;
}

InterfaceElement? _getEnclosingInterface(AstNode node) {
  for (final ancestor in node.ancestors) {
    if (ancestor is ClassDeclaration) return ancestor.declaredElement;
    if (ancestor is MixinDeclaration) return ancestor.declaredElement;
    if (ancestor is ExtensionDeclaration) {
      return ancestor.declaredElement?.extendedType.typeOrBound.tryCast<InterfaceType>()?.element;
    }
  }
  return null;
}
