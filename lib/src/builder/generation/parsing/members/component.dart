part of '../members.dart';

class BoilerplateComponent extends BoilerplateMember {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  @override
  // ignore: deprecated_member_use_from_same_package
  annotations.Component meta;
  Identifier configSubtypeOf;

  BoilerplateComponent(this.nodeHelper, VersionConfidence confidence)
      : node = nodeHelper.node,
        super(confidence) {
    final meta = InstantiatedComponentMeta<annotations.Component2>(node) ??
        // ignore: deprecated_member_use_from_same_package
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
  bool isComponent2(Version version) =>
      version == Version.v4_mixinBased || hasComponent2OrAbstractAnnotation;

  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        final superclass = nodeHelper.superclass;
        if (const ['UiComponent', 'UiStatefulComponent', 'FluxUiComponent']
            .contains(superclass?.nameWithoutPrefix)) {
          errorCollector.addError(
              'Must extend UiComponent2, not UiComponent.', errorCollector.spanFor(superclass));
        }
        break;
      case Version.v2_legacyBackwardsCompat:
      case Version.v3_legacyDart2Only:
        break;
    }

    const reservedMembers = {
      'typedPropsFactory',
      'typedPropsFactoryJs',
      'typedStateFactory',
      'typedStateFactoryJs',
    };
    nodeHelper.members
        .whereType<MethodDeclaration>()
        .where((member) => !member.isStatic && reservedMembers.contains(member.name.name))
        .forEach((member) {
      // This is a warning since emitting an error would break existing code that's doing this.
      errorCollector.addWarning(
          'Components should not add their own implementions of ${member.name.name}.',
          errorCollector.spanFor(member));
    });

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
