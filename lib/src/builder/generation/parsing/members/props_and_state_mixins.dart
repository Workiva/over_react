part of '../members.dart';

abstract class BoilerplatePropsOrStateMixin extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final ClassOrMixinDeclaration node;

  final ClassishDeclaration companion;

  annotations.TypedMap meta;

  @override
  SimpleIdentifier get name => node.name;

  BoilerplatePropsOrStateMixin(
    this.node, {
    @required Map<BoilerplateVersion, int> confidence,
    @required this.companion,
  }) : super(confidence) {
    meta = getPropsOrStateAnnotation(isProps, node);
  }

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  @override
  void validate(BoilerplateVersion version, ErrorCollector errorCollector) {
    void _sharedLegacyValidation() {
      if (!node.hasAnnotationWithName(propsOrStateMixinAnnotationName)) {
        errorCollector.addError(
            'Legacy boilerplate ${propsOrStateMixinString}s must be annotated with '
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
                  ?.any((type) => type.nameWithoutPrefix == propsOrStateBaseClassString) ??
              false;
          if (!isOnUiProps) {
            errorCollector.addError(
                '$propsOrStateString mixins must be `on $propsOrStateBaseClassString`',
                errorCollector.spanFor(node.onClause ?? node.name));
          }
        } else {
          // It's possible in the future that this may not always
          // be a ClassDeclaration, so fall back to node if it's not one.
          final spanNode = node.tryCast<ClassDeclaration>()?.classKeyword ?? node;
          errorCollector.addError(
              '$propsOrStateString mixins must be mixins', errorCollector.spanFor(spanNode));
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
  BoilerplatePropsMixin(
    ClassOrMixinDeclaration node,
    ClassishDeclaration companion,
    Map<BoilerplateVersion, int> confidence,
  ) : super(
          node,
          confidence: confidence,
          companion: companion,
        );

  @override
  bool get isProps => true;
}

class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin(
    ClassOrMixinDeclaration node,
    ClassishDeclaration companion,
    Map<BoilerplateVersion, int> confidence,
  ) : super(
          node,
          confidence: confidence,
          companion: companion,
        );

  @override
  bool get isProps => false;
}
