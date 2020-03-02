part of '../members.dart';

class BoilerplateComponent extends BoilerplateMember {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  annotations.Component config;
  Identifier configSubtypeOf;

  BoilerplateComponent(this.nodeHelper, int declarationConfidence)
      : node = nodeHelper.node,
        super(declarationConfidence) {
    final meta = InstantiatedComponentMeta<annotations.Component2>(node) ??
        InstantiatedComponentMeta<annotations.Component>(node);

    config = meta?.value ?? annotations.Component2();
    configSubtypeOf = meta?.subtypeOfValue;
  }

  @override
  SimpleIdentifier get name => nodeHelper.name;

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final map = <BoilerplateVersion, int>{};

    // todo do we need this and should we include other confidences in the map in this case?
    if (nodeHelper.hasAbstractKeyword) {
      map[BoilerplateVersion.noGenerate] = Confidence.high;
      return map;
    }

    if (hasComponent1OrAbstractAnnotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.high;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.high;
      map[BoilerplateVersion.v4_mixinBased] = Confidence.veryLow;
      map[BoilerplateVersion.noGenerate] = Confidence.veryLow;
    } else if (hasComponent2OrAbstractAnnotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.medium;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.medium;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.medium;
      map[BoilerplateVersion.noGenerate] = Confidence.veryLow;
    } else {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.veryLow;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.veryLow;
      map[BoilerplateVersion.v4_mixinBased] = Confidence.medium;
      map[BoilerplateVersion.noGenerate] = Confidence.medium;
    }
    return map;
  }

  bool get hasAnnotation => hasComponent1OrAbstractAnnotation || hasComponent2OrAbstractAnnotation;

  bool get hasComponent1OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component', 'AbstractComponent'});
  bool get hasComponent2OrAbstractAnnotation =>
      node.hasAnnotationWithNames({'Component2', 'AbstractComponent2'});
  bool isComponent2(BoilerplateVersion version) =>
      version == BoilerplateVersion.v4_mixinBased || hasComponent2OrAbstractAnnotation;

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.noGenerate:
        return;
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
