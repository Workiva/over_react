import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';

String getNodeSource(
  InvocationExpression node,
  String fileContent,
  LineInfo lineInfo, {
  int indent,
  int firstLineIndent,
}) {
  final src = fileContent.substring(node.offset, node.end);
  final nodeIndent = getIndent(fileContent, lineInfo, node.offset).length;

  if (indent == null || indent == nodeIndent) return (' ' * (firstLineIndent ?? 0)) + src;

  if (indent > nodeIndent) {
    // Increase indent

    if (firstLineIndent != indent) {
      final firstLine = (' ' * (firstLineIndent ?? 0)) + src.split('\n').first;
      final restOfTheLines = src.split('\n').skip(1).map((line) => (' ' * (indent - nodeIndent)) + line);
      final allLines = [firstLine, ...restOfTheLines];
      return allLines.join('\n');
    } else {
      return src.split('\n').map((line) => (' ' * (indent - nodeIndent)) + line).join('\n');
    }
  } else {
    // Decrease indent

    if (firstLineIndent != indent) {
      final firstLine = (' ' * (firstLineIndent ?? 0)) + src.split('\n').first;
      final restOfTheLines = src.split('\n').skip(1).map((line) => (' ' * (nodeIndent - indent)) + line);
      final allLines = [firstLine, ...restOfTheLines];
      return allLines.join('\n');
    } else {
      return src.split('\n').map((line) => line.replaceFirst(' ' * (nodeIndent - indent), '')).join('\n');
    }
  }
}

/// Detects if a node is likely part of a component class declaration.
bool isClassAComponentDeclaration(AstNode node) {
  if (node is ClassDeclaration) {
    if (node.name.name.contains('Component')) return true;
  } else {
    if (node.toSource().contains('Component')) return true;
  }

  return false;
}

String getComponentName(AstNode node) {
  var fullName = RegExp('([A-Za-z]+)(Component)').firstMatch(node.toSource());
  return fullName?.group(1);
}

class ComponentClassDeclaration {
  ClassDeclaration componentClass;

  static bool isAValidComponentClass(AstNode node) {
    var result = false;

    if (node.parent is ClassDeclaration) {
      ClassDeclaration parent = node.parent;
      if (parent.name.name.contains('Component')) {
        result = true;
      }
    }

    return result;
  }
  
  List<MixinDeclaration> _mixins;
  
  MixinDeclaration get stateMixin => _mixins.firstWhere((e) => e.name.name.contains('State'));

  MixinDeclaration get propsMixin => _mixins.firstWhere((e) => e.name.name.contains('Props'));

  // Constructor around
  ComponentClassDeclaration.fromIdentifierNode(AstNode node) {
    
  }
  
  
}
