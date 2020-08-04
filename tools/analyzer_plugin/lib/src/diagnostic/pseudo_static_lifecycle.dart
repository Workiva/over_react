import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/non_static_reference_visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

const staticMethodNames = ['getDefaultProps', 'defaultProps', 'getDerivedStateFromProps', 'propTypes'];
const allowedInstanceMembers = [
  'newProps',
  'newState',
  'typedPropsFactory',
  'typedPropsFactoryJs',
  'typedStateFactory',
  'typedStateFactoryJs',
  'keyForProp',
];

const _desc = r'Never reference instance members within ReactJS "static" lifecycle methods.';
// <editor-fold desc="Documentation Details">
const _details = '''

The ReactJS `defaultProps` and `propTypes` getters and `getDerivedStateFromProps` lifecycle methods are considered `static`.

As opposed to being called on each component instance, these lifecycle methods are called on a special, 
unmounted singleton of the component.  As a result, it's impossible to access fields or other information specific to
the "current" component instance, and doing so an cause unexpected behavior and runtime errors.

The only exceptions are the following instance members:

```
newProps
newState
typedPropsFactory
typedPropsFactoryJs
typedStateFactory
typedStateFactoryJs
keyForProp
```

''';
// </editor-fold>

class PseudoStaticLifecycleDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_pseudo_static_lifecycle',
    "Unsupported instance member used inside of '{0}', which should be treated as if it were 'static'."
        " Only super-calls and the following utility methods are allowed:"
        " 'newProps', 'newState', 'typedPropsFactory', 'typedStateFactory', 'keyForProp'.",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    correction: "Try using only information provided in arguments"
        " and converting any custom prop/state helper methods in use to be 'static'.",
  );

  @override
  computeErrors(result, collector) async {
    // This is the return type even if it's not explicitly declared.
    final visitor = LifecycleMethodVisitor();
    result.unit.accept(visitor);

    for (final reference in visitor.nonStaticReferences) {
      if (reference is SimpleIdentifier && allowedInstanceMembers.contains(reference.name)) {
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
