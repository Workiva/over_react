import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'ast_util.dart';
import 'util.dart';

/// Catch all identifiers that begin with "use" followed by an uppercase Latin
/// character to exclude identifiers like "user".
///
/// Also accept hooks prefixed with `_` and `$`.
final _hookNamePattern = RegExp(r'^[_$]*use[A-Z0-9].*$');
bool isHookName(String s) => _hookNamePattern.hasMatch(s);

FunctionBody? getClosestCustomHookFunction(AstNode node) =>
    node.ancestors.whereType<FunctionBody>().firstWhereOrNull(isCustomHookFunction);

bool isCustomHookFunction(FunctionBody body) {
  final declaration = body.parentDeclaration;
  return declaration != null && isHookName(declaration.name.name);
}

/// A utility class that provides information about a usage of a React hook.
class HookUsage {
  final MethodInvocation node;

  HookUsage(this.node);

  @override
  bool operator==(other) => other is HookUsage && other.node == node;

  @override
  int get hashCode => node.hashCode;

  /// The name of the hook being invoked.
  Identifier get hookName => node.methodName;
}

/// Returns all usages of React Hooks components in [node] and its descendants.
List<HookUsage> getAllHookUsages(AstNode node) {
  final usages = <HookUsage>[];
  node.accept(HookUsageVisitor(usages.add));
  return usages;
}

/// A recursive visitor that calls [onHookUsage] for each usages of React hooks it encounters.
class HookUsageVisitor extends RecursiveAstVisitor<void> {
  final void Function(HookUsage) onHookUsage;

  HookUsageVisitor(this.onHookUsage);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (isHookName(node.methodName.name)) {
      onHookUsage(HookUsage(node));
    }

    super.visitMethodInvocation(node);
  }
}
