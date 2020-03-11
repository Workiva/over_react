part of '../members.dart';

abstract class BoilerplatePropsOrState extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  final ClassishDeclaration companion;

  @override
  annotations.TypedMap meta;

  @override
  SimpleIdentifier get name => nodeHelper.name;

  BoilerplatePropsOrState(this.nodeHelper, this.companion, VersionConfidence confidence)
      : node = nodeHelper.node,
        super(confidence) {
    meta = getPropsOrStateAnnotation(isProps, node);
  }

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  bool get hasCompanionClass => companion != null;

  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        final node = this.node;
        // FIXME is this check still needed? The node should be assigned to
        // a PropsOrStateMixinDeclaration if it's a MixinDeclaration
        if (node is MixinDeclaration) {
          // It's possible in the future that this may not always
          // be a ClassDeclaration, so fall back to node if it's not one.
          errorCollector.addError(
              '$propsOrStateClassString implementations must be concrete classes, not mixins',
              // TODO add versions to error messages
              errorCollector.spanFor(node.mixinKeyword));
        } else {
          if (nodeHelper.superclass?.nameWithoutPrefix != propsOrStateBaseClassString) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must extend directly from $propsOrStateBaseClassString',
                errorCollector.spanFor(nodeHelper.superclass ?? node));
          }

          if (node is ClassDeclaration && node.members.isNotEmpty) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must not declare any $propsOrStateFieldsName or other members.',
                errorCollector.span(node.leftBracket.offset, node.rightBracket.end));
          }

          if (nodeHelper.hasAbstractKeyword) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must not be abstract, as they cannot be extended.',
                errorCollector.spanFor(nodeHelper.abstractKeyword));
          }
        }
        break;
      case Version.v2_legacyBackwardsCompat:
        // It's possible to declare an abstract class without any props/state fields that need to be generated,
        //  so long as it doesn't have the annotation.
        if (nodeHelper.members.isNotEmpty ||
            node.hasAnnotationWithNames(
                {propsOrStateAnnotationName, propsOrStateAbstractAnnotationName})) {
          _sharedLegacyValidation(errorCollector);
          if (companion == null) {
            // Don't emit this and the prefix error.
            if (node.name.name.startsWith(privateSourcePrefix)) {
              errorCollector.addError('Should have companion class', errorCollector.spanFor(node));
            }
          } else {
            validateMetaField(companion, propsOrStateMetaStructName, errorCollector);
          }
        }
        break;
      case Version.v3_legacyDart2Only:
        _sharedLegacyValidation(errorCollector);
        if (node is ClassOrMixinDeclaration) {
          checkForMetaPresence(node as ClassOrMixinDeclaration, errorCollector);
        }
        break;
    }
  }

  void _sharedLegacyValidation(ErrorCollector errorCollector) {
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
  BoilerplateProps(
      ClassishDeclaration nodeHelper, ClassishDeclaration companion, VersionConfidence confidence)
      : super(nodeHelper, companion, confidence);

  @override
  bool get isProps => true;
}

class BoilerplateState extends BoilerplatePropsOrState {
  BoilerplateState(
      ClassishDeclaration nodeHelper, ClassishDeclaration companion, VersionConfidence confidence)
      : super(nodeHelper, companion, confidence);

  @override
  bool get isProps => false;
}
