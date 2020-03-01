part of '../members.dart';

abstract class BoilerplatePropsOrStateMixin extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final ClassOrMixinDeclaration node;

  final ClassishDeclaration companion;

  annotations.TypedMap config;

  @override
  SimpleIdentifier get name => node.name;

  BoilerplatePropsOrStateMixin(this.node, int declarationConfidence, {@required this.companion}) : super(declarationConfidence) {
    config = getPropsOrStateAnnotation(isProps, node);
  }

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final isMixin = node is MixinDeclaration;
    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');

    final map = {
      BoilerplateVersion.v2_legacyBackwardsCompat: isMixin
          ? Confidence.none
          : (hasGeneratedPrefix ? Confidence.veryLow : Confidence.high),

      BoilerplateVersion.v3_legacyDart2Only: isMixin
          ? Confidence.none
          : (hasGeneratedPrefix ? Confidence.high : Confidence.veryLow),

      BoilerplateVersion.v4_mixinBased:
          isMixin ? Confidence.high : Confidence.veryLow,
    };

    final nodeHelper = node.asClassish();

    final overridesIsClassGenerated = nodeHelper.members
        .whereType<MethodDeclaration>()
        .any((member) => member.isGetter && member.name.name == r'$isClassGenerated');
    // Handle classes that look like props but are really just used as interfaces, and aren't extended from or directly used as a component's props
    if (overridesIsClassGenerated || onlyImplementsThings(nodeHelper)) {
      map[BoilerplateVersion.noGenerate] = Confidence.certain;
    } else {
      map[BoilerplateVersion.noGenerate] = Confidence.veryLow;
    }

    return map;
  }

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    void _sharedLegacyValidation() {
      if (!node.hasAnnotationWithName(propsOrStateMixinAnnotationName)) {
        errorCollector.addError('Legacy boilerplate ${propsOrStateMixinString}s must be annotated with '
            ' `@$propsOrStateMixinAnnotationName()`',
            errorCollector.spanFor(node));
      }
    }

    switch (version) {
      case BoilerplateVersion.noGenerate:
        return;
      case BoilerplateVersion.v4_mixinBased:
        final node = this.node;
        if (node is MixinDeclaration) {
          final isOnUiProps = node.onClause?.superclassConstraints
              ?.any((type) => type.nameWithoutPrefix == propsOrStateBaseClassString) ?? false;
          if (!isOnUiProps) {
            errorCollector.addError('$propsOrStateString mixins must be `on $propsOrStateBaseClassString`',
                errorCollector.spanFor(node.onClause ?? node.name));
          }
        } else {
          // It's possible in the future that this may not always
          // be a ClassDeclaration, so fall back to node if it's not one.
          final spanNode = node.tryCast<ClassDeclaration>()?.classKeyword ?? node;
          errorCollector.addError('$propsOrStateString mixins must be mixins',
              errorCollector.spanFor(spanNode));
        }
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
        _sharedLegacyValidation();
        validateMetaField(node.asClassish(), propsOrStateMetaStructName, errorCollector);
        break;
      case BoilerplateVersion.v3_legacyDart2Only:
        _sharedLegacyValidation();
        checkForMetaPresence(node, errorCollector);
        break;
    }
  }
}

class BoilerplatePropsMixin extends BoilerplatePropsOrStateMixin {
  BoilerplatePropsMixin(ClassOrMixinDeclaration node, int declarationConfidence,
      {ClassishDeclaration companion})
      : super(node, declarationConfidence, companion: companion);
  
  @override
  bool get isProps => true;
}

class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin(ClassOrMixinDeclaration node, int declarationConfidence,
      {ClassishDeclaration companion})
      : super(node, declarationConfidence, companion: companion);

  @override
  bool get isProps => false;
}
