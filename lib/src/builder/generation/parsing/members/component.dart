part of '../members.dart';

class BoilerplateComponent extends BoilerplateMember {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  ComponentNode withMeta;

  BoilerplateComponent(this.nodeHelper, int declarationConfidence)
      : node = nodeHelper.node,
        super(declarationConfidence) {
    withMeta = hasComponent1Annotation ? ComponentNode(nodeHelper.node) : Component2Node(nodeHelper.node);
  }

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final map = <BoilerplateVersion, int>{};
    if (hasComponent1Annotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.high;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.high;
    } else if (hasComponent2Annotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.medium;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.medium;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.medium;
    } else {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.veryLow;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.veryLow;
      map[BoilerplateVersion.v4_mixinBased] = Confidence.high;
    }
    return map;
  }

  bool get hasComponent1Annotation => node.hasAnnotationWithName('Component');
  bool get hasComponent2Annotation => node.hasAnnotationWithName('Component2');
  bool get hasComponent1or2Annotation => hasComponent1Annotation || hasComponent2Annotation;

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.v4_mixinBased:
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        if (!hasComponent1or2Annotation) {
          errorCollector.addError('Legacy boilerplate factories must be annotated with `@Component()` or `@Component2()`.',
              errorCollector.spanFor(node));
        }
        // Check that class name starts with [privateSourcePrefix]
        if (!node.name.name.startsWith(privateSourcePrefix)) {
          errorCollector.addError('The class `${node.name.name}` does not start with `$privateSourcePrefix`. All Props, State, '
              'AbstractProps, and AbstractState classes should begin with `$privateSourcePrefix` on Dart 2',
              errorCollector.spanFor(node));
          return;
        }
        break;
    }

    // Ensure that Component2 declarations do not use legacy lifecycle methods.
    final isComponent2 = hasComponent2Annotation || version == BoilerplateVersion.v4_mixinBased;
    if (isComponent2 && node is ClassOrMixinDeclaration) {
       Map<String, String> legacyLifecycleMethodsMap = {
         'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
         'componentWillMount': 'Use init instead.',
         'componentWillUpdate': 'Use getSnapshotBeforeUpdate instead.',
       };

       legacyLifecycleMethodsMap.forEach((methodName, helpMessage) {
         final method = (node as ClassOrMixinDeclaration).getMethod(methodName);
         if (method != null) {
           errorCollector.addError(unindent(
               '''
               When using Component2, a class cannot use ${method.name} because React 16 has removed ${method.name} 
               and renamed it UNSAFE_${method.name}.
               
               $helpMessage
               
               See https://reactjs.org/docs/react-component.html#legacy-lifecycle-methods for additional information.   
               '''
           ), errorCollector.spanFor(method));
         }
       });
    }
  }
}


// TODO: Remove when `annotations.Component` is removed in the 4.0.0 release.
@Deprecated('4.0.0')
class ComponentNode<TMeta extends annotations.Component>
    extends NodeWithMeta<NamedCompilationUnitMember, TMeta> {
  static const String _subtypeOfParamName = 'subtypeOf';

  /// The value of the `subtypeOf` parameter passed in to this node's annotation.
  Identifier subtypeOfValue;

  ComponentNode(AnnotatedNode unit) : super(unit) {
    // Perform special handling for the `subtypeOf` parameter of this node's annotation.
    //
    // If valid, omit it from `unsupportedArguments` so that the `meta` can be accessed without it
    // (with the value available via `subtypeOfValue`), given that all other arguments are valid.

    NamedExpression subtypeOfParam = this.unsupportedArguments.firstWhere((expression) {
      return expression is NamedExpression && expression.name.label.name == _subtypeOfParamName;
    }, orElse: () => null);

    if (subtypeOfParam != null) {
      if (subtypeOfParam.expression is! Identifier) {
        throw '`$_subtypeOfParamName` must be an identifier: $subtypeOfParam';
      }

      this.subtypeOfValue = subtypeOfParam.expression;
      this.unsupportedArguments.remove(subtypeOfParam);
    }
  }
}

class Component2Node extends ComponentNode<annotations.Component2> {
  Component2Node(AnnotatedNode unit) : super(unit);
}
