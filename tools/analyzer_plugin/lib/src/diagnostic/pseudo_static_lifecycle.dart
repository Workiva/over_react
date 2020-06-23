import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

const staticMethodNames = ['getDefaultProps', 'defaultProps', 'getDerivedStateFromProps'];
const instanceMemberWhitelist = [
  'newProps',
  'newState',
  'typedPropsFactory',
  'typedPropsFactoryJs',
  'typedStateFactory',
  'typedStateFactoryJs',
];

class PseudoStaticLifecycleDiagnostic extends DiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_pseudo_static_lifecycle',
      '\'{0}\' must be treated as a static method; only super-calls '
          'and props/state utility methods (like \'newProps\' and \'typedPropsFactory\') are allowed.',
      AnalysisErrorSeverity.ERROR,
      AnalysisErrorType.STATIC_WARNING);

  @override
  computeErrors(result, collector) async {
    // This is the return type even if it's not explicitly declared.
    final visitor = LifecycleMethodVisitor();
    result.unit.accept(visitor);

    for (final reference in visitor.nonStaticReferences) {
      if (reference is SimpleIdentifier && instanceMemberWhitelist.contains(reference.name)) {
        continue;
      }

      int offset;
      int end;

      final enclosingMethodName = reference.thisOrAncestorOfType<MethodDeclaration>().name;
      if (reference is SuperExpression || reference is ThisExpression) {
        final parent = reference.parent;
        if (parent is MethodInvocation) {
          if (parent.methodName.name == enclosingMethodName.name) {
            // Ignore super-calls to same method
            continue;
          } else {
            // Include the `super.`/`this.` in the error region
            offset = parent.offset;
            end = parent.methodName.end;
          }
        } else if (parent is PropertyAccess) {
          if (parent.propertyName.name == enclosingMethodName.name) {
            // Ignore super-calls to same getter
            continue;
          } else {
            // Include the `super.`/`this.` in the error region
            offset = parent.offset;
            end = parent.end;
          }
        }
      }

      offset ??= reference.offset;
      end ??= reference.end;

      collector.addError(
        code,
        result.location(offset: offset, end: end),
        errorMessageArgs: [enclosingMethodName.name],
      );
    }
  }
}

class LifecycleMethodVisitor extends GeneralizingAstVisitor<void> {
  List<Expression> nonStaticReferences = [];

  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    visitClassOrMixinDeclaration(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    visitClassOrMixinDeclaration(node);
  }

  void visitClassOrMixinDeclaration(ClassOrMixinDeclaration node) {
    for (final member in node.members) {
      if (member is MethodDeclaration && staticMethodNames.contains(member.name.name)) {
        final visitor = ReferenceVisitor();
        member.body?.accept(visitor);
        nonStaticReferences.addAll(visitor.nonStaticReferences);
      }
    }
  }
}

class ReferenceVisitor extends RecursiveAstVisitor<void> {
  List<Expression> nonStaticReferences = [];

  @override
  void visitThisExpression(ThisExpression node) {
    nonStaticReferences.add(node);
    super.visitThisExpression(node);
  }

  @override
  void visitSuperExpression(SuperExpression node) {
    nonStaticReferences.add(node);
    super.visitSuperExpression(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (referencesImplicitThis(node)) {
      nonStaticReferences.add(node);
    }
    super.visitSimpleIdentifier(node);
  }
}

/// Returns whether the given [identifier] implicitly references 'this'.
///
/// Adapted from `_checkForImplicitThisReferenceInInitializer` in dart-lang/sdk:
/// <https://github.com/dart-lang/sdk/blob/2.2.0/pkg/analyzer/lib/src/generated/error_verifier.dart#L3642>
///
/// Copyright 2012, the Dart project authors. All rights reserved.
/// Redistribution and use in source and binary forms, with or without
/// modification, are permitted provided that the following conditions are
/// met:
///     * Redistributions of source code must retain the above copyright
///       notice, this list of conditions and the following disclaimer.
///     * Redistributions in binary form must reproduce the above
///       copyright notice, this list of conditions and the following
///       disclaimer in the documentation and/or other materials provided
///       with the distribution.
///     * Neither the name of Google Inc. nor the names of its
///       contributors may be used to endorse or promote products derived
///       from this software without specific prior written permission.
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
/// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
/// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
/// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
/// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
/// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
/// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
/// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
/// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
/// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
/// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
bool referencesImplicitThis(SimpleIdentifier identifier) {
  // prepare element
  final element = identifier.staticElement;
  if (!(element is MethodElement || element is PropertyAccessorElement)) {
    return false;
  }
  // static element
  final executableElement = element as ExecutableElement;
  if (executableElement.isStatic) {
    return false;
  }
  // not a class member
  final enclosingElement = element.enclosingElement;
  if (enclosingElement is! ClassElement) {
    return false;
  }
  // comment
  final parent = identifier.parent;
  if (parent is CommentReference) {
    return false;
  }
  // qualified method invocation
  if (parent is MethodInvocation) {
    if (identical(parent.methodName, identifier) && parent.realTarget != null) {
      return false;
    }
  }
  // qualified property access
  if (parent is PropertyAccess) {
    if (identical(parent.propertyName, identifier) && parent.realTarget != null) {
      return false;
    }
  }
  if (parent is PrefixedIdentifier) {
    if (identical(parent.identifier, identifier)) {
      return false;
    }
  }

  return true;
}
