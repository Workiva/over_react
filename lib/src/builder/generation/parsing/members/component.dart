part of '../members.dart';

class BoilerplateComponent extends BoilerplateMember {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  annotations.Component meta;
  Identifier configSubtypeOf;

  BoilerplateComponent(this.nodeHelper, Map<BoilerplateVersion, int> confidence)
      : node = nodeHelper.node,
        super(confidence) {
    final meta = InstantiatedComponentMeta<annotations.Component2>(node) ??
        InstantiatedComponentMeta<annotations.Component>(node);

    this.meta = meta?.value ?? annotations.Component2();
    configSubtypeOf = meta?.subtypeOfValue;
  }

  @override
  SimpleIdentifier get name => nodeHelper.name;

  TypeAnnotation get propsGenericArg {
    return nodeHelper.superclass.typeArguments?.arguments
        ?.firstWhere((type) => type.typeNameWithoutPrefix.endsWith('Props'), orElse: () => null);
  }

  bool get hasAnnotation => hasComponent1OrAbstractAnnotation || hasComponent2OrAbstractAnnotation;

  bool get hasComponent1OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component', 'AbstractComponent'});
  bool get hasComponent2OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component2', 'AbstractComponent2'});
  bool isComponent2(BoilerplateVersion version) =>
      version == BoilerplateVersion.v4_mixinBased || hasComponent2OrAbstractAnnotation;

  @override
  void validate(BoilerplateVersion version, ErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.v4_mixinBased:
        final superclass = nodeHelper.superclass;
        if (superclass?.nameWithoutPrefix == 'UiComponent') {
          errorCollector.addError(
              'Must extend UiComponent2, not UiComponent.', errorCollector.spanFor(superclass));
        }
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        break;
    }

    // Ensure that Component2 declarations do not use legacy lifecycle methods.
    if (isComponent2(version) && node is ClassOrMixinDeclaration) {
      Map<String, String> legacyLifecycleMethodsMap = {
        'componentWillReceiveProps': 'Use getDerivedStateFromProps instead.',
        'componentWillMount': 'Use init instead.',
        'componentWillUpdate': 'Use getSnapshotBeforeUpdate instead.',
      };

      legacyLifecycleMethodsMap.forEach((methodName, helpMessage) {
        final method = (node as ClassOrMixinDeclaration).getMethod(methodName);
        if (method != null) {
          errorCollector.addError(unindent('''
               When using Component2, a class cannot use ${method.name} because React 16 has removed ${method.name} 
               and renamed it UNSAFE_${method.name}.
               
               $helpMessage
               
               See https://reactjs.org/docs/react-component.html#legacy-lifecycle-methods for additional information.   
               '''), errorCollector.spanFor(method));
        }
      });
    }
  }
}
