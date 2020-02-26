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
      map[BoilerplateVersion.v4_mixinBased] = Confidence.medium;
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
        final superclass = nodeHelper.superclass;
        if (superclass?.nameWithoutPrefix == 'UiComponent') {
          errorCollector.addError('Must extend UiComponent2, not UiComponent.',
              errorCollector.spanFor(superclass));
        }
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        if (!hasComponent1or2Annotation) {
          errorCollector.addError('Legacy boilerplate factories must be annotated with `@Component()` or `@Component2()`.',
              errorCollector.spanFor(node));
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

  ComponentNode(NamedCompilationUnitMember unit) : super(unit) {
    // Perform special handling for the `subtypeOf` parameter of this node's annotation.
    //
    // If valid, omit it from `unsupportedArguments` so that the `meta` can be accessed without it
    // (with the value available via `subtypeOfValue`), given that all other arguments are valid.

    NamedExpression subtypeOfParam = unsupportedArguments
        .whereType<NamedExpression>()
        .firstWhere(
            (expression) => expression.name.label.name == _subtypeOfParamName,
            orElse: () => null);

    if (subtypeOfParam != null) {
      final expression = subtypeOfParam.expression;
      if (expression is Identifier) {
        subtypeOfValue = expression;
        unsupportedArguments.remove(subtypeOfParam);
      } else {
        throw '`$_subtypeOfParamName` must be an identifier: $subtypeOfParam';
      }
    }
  }
}

class Component2Node extends ComponentNode<annotations.Component2> {
  Component2Node(NamedCompilationUnitMember unit) : super(unit);
}
