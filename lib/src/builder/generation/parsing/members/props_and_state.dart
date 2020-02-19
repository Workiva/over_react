part of '../members.dart';

extension on String {
  String capitalize() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

mixin PropsStateStringHelpers {
  bool get isProps;
  String get propsOrStateString => isProps ? 'props' : 'state';
  String get propsOrStateBaseClassString => 'Ui${propsOrStateString.capitalize()}';
  String get propsOrStateClassString => '${propsOrStateString.capitalize()} class';
  String get propsOrStateMixinString => '${propsOrStateString.capitalize()} mixin';
  String get propsOrStateFieldsName => isProps ? 'props' : 'state fields';
}

abstract class BoilerplatePropsOrState extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final CompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  BoilerplatePropsOrState(this.nodeHelper, int declarationConfidence) : node = nodeHelper.node, super(declarationConfidence);

  @override
  Map<BoilerplateVersion, int> get versionConfidence => {
    // todo might need to rethink these, as well as in the mixin classes, to be able to provide better error messages when people make things mixins
    BoilerplateVersion.v2_legacyBackwardsCompat: node is MixinDeclaration ? Confidence.veryLow : Confidence.high,
    BoilerplateVersion.v3_legacyDart2Only: node is MixinDeclaration ? Confidence.veryLow : Confidence.high,
    BoilerplateVersion.v4_mixinBased: node is MixinDeclaration ? Confidence.high : Confidence.veryLow,
  };

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.v4_mixinBased:
        final node = this.node;
        if (node is MixinDeclaration) {
          // It's possible in the future that this may not always
          // be a ClassDeclaration, so fall back to node if it's not one.
          errorCollector.addError('$propsOrStateClassString implementations must be concrete classes, not mixins',// TODO add versions to error messages
              errorCollector.spanFor(node.mixinKeyword));
        } else {
          if (nodeHelper.superclass?.nameWithoutPrefix != 'UiProps') {
            errorCollector.addError('$propsOrStateClassString implementations must extend directly from `on $propsOrStateBaseClassString`',
                errorCollector.spanFor(nodeHelper.superclass ?? node));
          }

          if (node is ClassDeclaration && node.members.isNotEmpty) {
            errorCollector.addError('$propsOrStateClassString implementations must not declare any $propsOrStateFieldsName or other memberss.',
                errorCollector.span(node.leftBracket.offset, node.rightBracket.end));
          }

          if (nodeHelper.isAbstract) {
            // todo what about the abstract interface case? Do we special case the "Abstract" prefix?
            errorCollector.addError('$propsOrStateClassString implementations must not be abstract, as they cannot be extended.',
            errorCollector.spanFor(nodeHelper.abstractKeyword));
          }
        }
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
        // TODO: Handle this case.
        break;
      case BoilerplateVersion.v3_legacyDart2Only:
        // TODO: Handle this case.
        break;
    }
  }
}

class BoilerplateProps extends BoilerplatePropsOrState {
  BoilerplateProps(ClassishDeclaration nodeHelper, int declarationConfidence) : super(nodeHelper, declarationConfidence);

  @override
  bool get isProps => true;
}

class BoilerplateState extends BoilerplatePropsOrState {
  BoilerplateState(ClassishDeclaration nodeHelper, int declarationConfidence) : super(nodeHelper, declarationConfidence);

  @override
  bool get isProps => false;
}

abstract class BoilerplatePropsOrStateMixin extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final CompilationUnitMember node;

  BoilerplatePropsOrStateMixin(this.node, int declarationConfidence) : super(declarationConfidence);

  @override
  Map<BoilerplateVersion, int> get versionConfidence => {
    BoilerplateVersion.v2_legacyBackwardsCompat: node is MixinDeclaration ? Confidence.veryLow : Confidence.high,
    BoilerplateVersion.v3_legacyDart2Only: node is MixinDeclaration ? Confidence.veryLow : Confidence.high,
    BoilerplateVersion.v4_mixinBased: node is MixinDeclaration ? Confidence.high : Confidence.veryLow,
  };

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
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
        // TODO: Handle this case.
        break;
      case BoilerplateVersion.v3_legacyDart2Only:
        // TODO: Handle this case.
        break;
    }
  }
}

class BoilerplatePropsMixin extends BoilerplatePropsOrStateMixin {
  BoilerplatePropsMixin(CompilationUnitMember node, int declarationConfidence) : super(node, declarationConfidence);

  @override
  bool get isProps => true;
}


class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin(CompilationUnitMember node, int declarationConfidence) : super(node, declarationConfidence);

  @override
  bool get isProps => false;
}
