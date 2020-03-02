part of '../members.dart';

abstract class BoilerplatePropsOrState extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  final ClassishDeclaration companion;

  annotations.TypedMap config;

  @override
  SimpleIdentifier get name => nodeHelper.name;

  BoilerplatePropsOrState(this.nodeHelper, int declarationConfidence, {@required this.companion})
      : node = nodeHelper.node,
        super(declarationConfidence) {
    config = getPropsOrStateAnnotation(isProps, node);
  }

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final map = <BoilerplateVersion, int>{};

    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');
    if (!hasGeneratedPrefix && (node is! MixinDeclaration && nodeHelper.hasAbstractKeyword)) {
      map[BoilerplateVersion.noGenerate] = Confidence.high;
      map[BoilerplateVersion.v4_mixinBased] = Confidence.veryLow;
      return map;
    }

    if (isLegacyMapView) {
      map[BoilerplateVersion.noGenerate] = Confidence.high;
    } else {
      final isMixin = node is MixinDeclaration;
      if (isMixin) {
        // todo might need to rethink these, as well as in the mixin classes, to be able to provide better error messages when people make things mixins

        // It has never been possible to declare a props class with a mixin
        map[BoilerplateVersion.v2_legacyBackwardsCompat] = Confidence.none;
        map[BoilerplateVersion.v3_legacyDart2Only] = Confidence.none;
        // fixme this ain't right
        map[BoilerplateVersion.v4_mixinBased] = Confidence.high;
      } else {
        map[BoilerplateVersion.v2_legacyBackwardsCompat] =
            (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.medium : Confidence.veryLow;
        map[BoilerplateVersion.v3_legacyDart2Only] =
            (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.veryLow : Confidence.medium;
        map[BoilerplateVersion.v4_mixinBased] = Confidence.veryLow;
      }

      final overridesIsClassGenerated = nodeHelper.members
          .whereType<MethodDeclaration>()
          .any((member) => member.isGetter && member.name.name == r'$isClassGenerated');
      // Handle classes that look like props but are really just used as interfaces, and aren't extended from or directly used as a component's props
      if (overridesIsClassGenerated || onlyImplementsThings(nodeHelper)) {
        map[BoilerplateVersion.noGenerate] = Confidence.certain;
      }
    }

    return map;
  }

  bool get isLegacyMapView =>
      name.name.endsWith('MapView') &&
      nodeHelper.members.whereType<ConstructorDeclaration>().isNotEmpty;

  bool get hasCompanionClass => companion != null;

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.noGenerate:
        return;
      case BoilerplateVersion.v4_mixinBased:
        final node = this.node;
        if (node is MixinDeclaration) {
          // It's possible in the future that this may not always
          // be a ClassDeclaration, so fall back to node if it's not one.
          errorCollector.addError(
              '$propsOrStateClassString implementations must be concrete classes, not mixins', // TODO add versions to error messages
              errorCollector.spanFor(node.mixinKeyword));
        } else {
          if (nodeHelper.superclass?.nameWithoutPrefix != propsOrStateBaseClassString) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must extend directly from $propsOrStateBaseClassString',
                errorCollector.spanFor(nodeHelper.superclass ?? node));
          }

          if (node is ClassDeclaration && node.members.isNotEmpty) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must not declare any $propsOrStateFieldsName or other memberss.',
                errorCollector.span(node.leftBracket.offset, node.rightBracket.end));
          }

          if (nodeHelper.hasAbstractKeyword) {
            // todo what about the abstract interface case? Do we special case the "Abstract" prefix?
            errorCollector.addError(
                '$propsOrStateClassString implementations must not be abstract, as they cannot be extended.',
                errorCollector.spanFor(nodeHelper.abstractKeyword));
          }
        }
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
        // It's possible to declare an abstract class without any props/state fields that need to be generated.
        if (nodeHelper.members.isNotEmpty) {
          _sharedLegacyValidation(errorCollector);
          if (companion == null) {
            //todo log error
          } else {
            validateMetaField(companion, propsOrStateMetaStructName, errorCollector);
          }
        }
        break;
      case BoilerplateVersion.v3_legacyDart2Only:
        _sharedLegacyValidation(errorCollector);
        if (node is ClassOrMixinDeclaration) {
          checkForMetaPresence(node as ClassOrMixinDeclaration, errorCollector);
        }
        break;
    }
  }

  void _sharedLegacyValidation(ValidationErrorCollector errorCollector) {
    if (node is! ClassOrMixinDeclaration) {
      errorCollector.addError(
          'Legacy boilerplate must use classes or mixins, and not shorthand class declaration',
          errorCollector.spanFor(node));
    }

    // Check that class name starts with [privateSourcePrefix]
    if (!node.name.name.startsWith(privateSourcePrefix)) {
      errorCollector.addError(
          'The class `${node.name.name}` does not start with `$privateSourcePrefix`. All Props, State, '
          'AbstractProps, and AbstractState classes should begin with `$privateSourcePrefix` on Dart 2',
          errorCollector.spanFor(node));
    }
  }
}

class BoilerplateProps extends BoilerplatePropsOrState {
  BoilerplateProps(ClassishDeclaration nodeHelper, int declarationConfidence,
      {ClassishDeclaration companion})
      : super(nodeHelper, declarationConfidence, companion: companion);

  @override
  bool get isProps => true;
}

class BoilerplateState extends BoilerplatePropsOrState {
  BoilerplateState(ClassishDeclaration nodeHelper, int declarationConfidence,
      {ClassishDeclaration companion})
      : super(nodeHelper, declarationConfidence, companion: companion);

  @override
  bool get isProps => false;
}
