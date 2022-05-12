import 'package:analyzer/dart/ast/ast.dart';
// ignore: implementation_imports
import 'package:over_react_codemod/src/util/component_usage.dart';

// FIXME(null-safety) copy this over - it's only here to help with the null-safe migration
export 'package:over_react_codemod/src/util/component_usage.dart';

extension DomNodeName on FluentComponentUsage {
  String? get domNodeName {
    if (!isDom) return null;

    final componentName = this.componentName;
    if (componentName == null) return null;

    final nodeNameMatch = RegExp(r'\bDom.(\w+)$').firstMatch(componentName);
    if (nodeNameMatch == null) return null;

    return nodeNameMatch.group(1)!;
  }
}

/// Returns all component usages in [node] and its descendants.
List<FluentComponentUsage> getAllComponentUsages(AstNode node) {
  final usages = <FluentComponentUsage>[];
  node.accept(ComponentUsageVisitor(usages.add));
  return usages;
}
