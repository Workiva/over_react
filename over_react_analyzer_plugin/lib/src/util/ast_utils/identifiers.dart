part of over_react_analyzer_plugin.src.ast_util;

/// Returns whether any [Identifier] within [node] matches the predicate [test].
bool anyDescendantIdentifiers(AstNode node, bool Function(Identifier) test) {
  final visitor = _AnyDescendantIdentifiersVisitor(test);
  node.accept(visitor);
  return visitor.hasMatch;
}

/// Returns a single [Identifier] within [node] that matches the predicate [test].
Identifier getMatchingDescendantIdentifier(AstNode node, bool Function(Identifier) test) {
  final visitor = _AnyDescendantIdentifiersVisitor(test);
  node.accept(visitor);
  if (visitor.hasMatch) {
    return visitor.matchingIdentifier;
  }

  return null;
}

/// Returns a list of [Identifier]s within [node] that match the predicate [test].
///
/// > To act on each match as its found instead of storing an iterable of all the matches,
///   use [forEachMatchingDescendantIdentifier] instead.
List<Identifier> getAllMatchingDescendantIdentifier(AstNode node, bool Function(Identifier) test) {
  final visitor = _AllDescendantIdentifiersVisitor(test);
  node.accept(visitor);
  return visitor.matchingIdentifiers;
}

/// Recursively visits [Identifier]s that match the predicate [test], and calls [handleMatch] when visiting.
void forEachMatchingDescendantIdentifier(
    AstNode node, bool Function(Identifier) test, dynamic Function(Identifier) handleMatch) {
  final visitor = _AllDescendantIdentifiersVisitor(test, handleMatch: handleMatch);
  node.accept(visitor);
}

mixin _IdentifierMatcher on AstVisitor<void> {
  bool Function(Identifier) get test;

  @mustCallSuper
  @override
  void visitSimpleIdentifier(SimpleIdentifier identifier) {
    if (test(identifier)) {
      onMatch(identifier);
    }
  }

  dynamic onMatch(Identifier matchingIdentifier);
}

class _AnyDescendantIdentifiersVisitor extends UnifyingAstVisitor<void> with _IdentifierMatcher {
  @override
  final bool Function(Identifier) test;

  _AnyDescendantIdentifiersVisitor(this.test);

  bool hasMatch = false;
  Identifier matchingIdentifier;

  @override
  void visitNode(AstNode node) {
    // Short-circuit and stop traversing recursively.
    if (hasMatch) return;

    super.visitNode(node);
  }

  @override
  void onMatch(Identifier matchingIdentifier) {
    this.matchingIdentifier = matchingIdentifier;
    hasMatch = true;
  }
}

class _AllDescendantIdentifiersVisitor extends RecursiveAstVisitor<void> with _IdentifierMatcher {
  @override
  final bool Function(Identifier) test;
  final dynamic Function(Identifier) handleMatch;

  _AllDescendantIdentifiersVisitor(this.test, {this.handleMatch}) : matchingIdentifiers = [];

  List<Identifier> matchingIdentifiers;

  @override
  void onMatch(Identifier matchingIdentifier) {
    matchingIdentifiers.add(matchingIdentifier);
    handleMatch?.call(matchingIdentifier);
  }
}
