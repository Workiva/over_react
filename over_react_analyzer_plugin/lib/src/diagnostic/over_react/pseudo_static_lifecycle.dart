import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';

const staticMethodNames = ['getDefaultProps', 'getDerivedStateFromProps'];
const instanceMemberWhitelist = [
  'newProps',
  'newState',
  'typedPropsFactory',
  'typedPropsFactoryJs',
  'typedStateFactory',
  'typedStateFactoryJs',
];

class PseudoStaticLifecycleChecker extends SubChecker {
  @override
  String get name => 'over_react_pseudo_static_lifecycle';

  @override
  String get description =>
      '';

  @override
  void check(ResolvedUnitResult result) {
    super.check(result);

    // This is the return type even if it's not explicitly declared.
    final visitor = new LifecycleMethodVisitor();
    result.unit.accept(visitor);

    // FIXME account for super calls
    
    for (var reference in visitor.nonStaticReferences) {
      if (reference is SimpleIdentifier && instanceMemberWhitelist.contains(reference.name)) {
        continue;
      }

      int offset;
      int end;

      final enclosingMethodName = reference.thisOrAncestorOfType<MethodDeclaration>().name;
      if (reference is SuperExpression || reference is ThisExpression) {
        // Improve error regions for these cases
        final parent = reference.parent;
        if (parent is MethodInvocation) {
          if (parent.methodName.name == enclosingMethodName.name) {
            // super-call to same method
            continue;
          } else {
            offset = parent.offset;
            end = parent.methodName.end;
          }
        } else if (parent is PropertyAccess) {
          offset = parent.offset;
          end = parent.end;
        }
      }

      offset ??= reference.offset;
      end ??= reference.end;

      emitError(message:
          '${enclosingMethodName.name} must not contain references to instance members,'
          ' other than utility methods (newProps, typedPropsFactory, etc.).',
          offset: offset, end: end);
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
    for (var member in node.members) {
      if (member is MethodDeclaration && staticMethodNames.contains(member.name.name)) {
        final visitor = new ReferenceVisitor(node);
        member.body?.accept(visitor);
        nonStaticReferences.addAll(visitor.nonStaticReferences);
      }
    }
  }
}

class ReferenceVisitor extends RecursiveAstVisitor<void> {
  ReferenceVisitor(this._classOrMixinDeclaration);

  final ClassOrMixinDeclaration _classOrMixinDeclaration;

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
    final parent = node.parent;
    if (parent is PropertyAccess) {
      if (parent.realTarget == null && _referencesCurrentClassMember(node.staticElement)) {
        // Example: `_ref;`
        nonStaticReferences.add(node);
      }
    } else if (parent is AssignmentExpression) {
      if (parent.leftHandSide == node && _referencesCurrentClassMember(node.staticElement)) {
        // Example: `_ref = ref;`
        nonStaticReferences.add(node);
      }
    } else if (parent is MethodInvocation) {
      if (parent.realTarget == null && _referencesCurrentClassMember(node.staticElement)) {
        // Example: `setState({})`
        nonStaticReferences.add(node);
      }
    } else if (parent is MethodReferenceExpression) {
      if (_referencesCurrentClassMember(node.staticElement)) {
        // Example: `setState({})`
        nonStaticReferences.add(node);
      }
    } else if (parent is PrefixedIdentifier) {
      if (node != parent.identifier) {
        // Example: `props.foo`
        if (_referencesCurrentClassMember(node.staticElement)) {
          nonStaticReferences.add(node);
        }
      } else if (parent.parent is FunctionExpressionInvocation) {
        if (_referencesCurrentClassMember(node.staticElement)) {
          nonStaticReferences.add(node);
        }
      }
    } else {
      // fixme are there other cases where an identifier can be used that need to be checked first?
      if (_referencesCurrentClassMember(node.staticElement)) {
        // Example: `props`
        nonStaticReferences.add(node);
      }
    }
    super.visitSimpleIdentifier(node);
  }

  bool _referencesCurrentClassMember(Element referencedElement) {
    if (referencedElement == null) return false;

    // TODO this needs a LOT of cleanup
    if (referencedElement is ClassMemberElement) {
      if (referencedElement.isStatic) {
        return false;
      }
//      if (_classOrMixinDeclaration.declaredElement.interfaces.contains(referencedElement.enclosingElement.type)) {
        return true;
//      }
    } else if (referencedElement is PropertyAccessorElement) {
      if (referencedElement.isStatic) {
        return false;
      }

      return true;
    } else if (referencedElement is PropertyInducingElement) {
      if (referencedElement.isStatic) {
        return false;
      }
      return true;
    } else if (referencedElement.enclosingElement is ClassMemberElement) {
      if ((referencedElement.enclosingElement as ClassMemberElement).isStatic) {
        return false;
      }
      return true;
    }


    return false;
  }
}
