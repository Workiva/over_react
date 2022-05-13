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

class HookUsage {
  final MethodInvocation node;

  HookUsage(this.node);

  String get hookName => node.methodName.name;

  FunctionBody? get nearestFunctionBody => node.thisOrAncestorOfType<FunctionBody>();
}

class HooksUsagesVisitor extends RecursiveAstVisitor<void> {
  final hookUsages = <HookUsage>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (isHookName(node.methodName.name)) {
      hookUsages.add(HookUsage(node));
    }

    super.visitMethodInvocation(node);
  }
}
