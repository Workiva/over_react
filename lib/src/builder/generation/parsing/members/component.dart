part of '../members.dart';

class BoilerplateComponent extends BoilerplateMember {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  BoilerplateComponent(this.nodeHelper, int declarationConfidence) : node = nodeHelper.node, super(declarationConfidence);

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final map = <BoilerplateVersion, int>{};
    if (hasComponent1Annotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.high;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.high;
    } else if (hasComponent2Annotation) {
      map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.medium;
      map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.medium;
      // todo maybe just make this possible
      map[BoilerplateVersion.v4_mixinBased] = nodeHelper is ClassTypeAlias ? Confidence.high : Confidence.medium;
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
//        if (!hasFactoryAnnotation) {
//          errorCollector.addError('Legacy boilerplate factories must be annotated with `@Factory()`.');
//        }
        break;
    }

  }
}

