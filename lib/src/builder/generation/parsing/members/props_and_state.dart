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
  String get propsOrStateMetaStructName => isProps ? 'PropsMeta' : 'StateMeta';
  String get propsOrStateAnnotationName => isProps ? 'Props' : 'State';
  String get propsOrStateAbstractAnnotationName => isProps ? 'AbstractProps' : 'AbstractState';
  String get propsOrStateMixinAnnotationName => isProps ? 'PropsMixin' : 'StateMixin';
}

abstract class BoilerplatePropsOrState extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final NamedCompilationUnitMember node;

  final ClassishDeclaration nodeHelper;

  final ClassishDeclaration companionClass;

  NodeWithMeta<NamedCompilationUnitMember, annotations.TypedMap> get withMeta;

  @override
  SimpleIdentifier get name => nodeHelper.name;

  BoilerplatePropsOrState(this.nodeHelper, int declarationConfidence, {@required this.companionClass}) : node = nodeHelper.node, super(declarationConfidence);

  @override
  String get debugString => '${super.debugString}, companion: ${companionClass?.name}';

  @override
  Map<BoilerplateVersion, int> get versionConfidence {
    final map = <BoilerplateVersion, int>{};

    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');
    if (!hasGeneratedPrefix && (node is! MixinDeclaration && nodeHelper.isAbstract)) {
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
        map[BoilerplateVersion.v2_legacyBackwardsCompat] = (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.medium : Confidence.veryLow;
        map[BoilerplateVersion.v3_legacyDart2Only] = (hasCompanionClass || !hasGeneratedPrefix) ? Confidence.veryLow : Confidence.medium;
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

  bool get isLegacyMapView => name.name.endsWith('MapView') && nodeHelper.members.whereType<ConstructorDeclaration>().isNotEmpty;

  bool get hasCompanionClass => companionClass != null;

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
          errorCollector.addError('$propsOrStateClassString implementations must be concrete classes, not mixins',// TODO add versions to error messages
              errorCollector.spanFor(node.mixinKeyword));
        } else {
          if (nodeHelper.superclass?.nameWithoutPrefix != propsOrStateBaseClassString) {
            errorCollector.addError('$propsOrStateClassString implementations must extend directly from $propsOrStateBaseClassString',
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
        // It's possible to declare an abstract class without any props/state fields that need to be generated.
        if (nodeHelper.members.isNotEmpty) {
          _sharedLegacyValidation(errorCollector);
          if (companionClass == null) {
            //todo log error
          } else {
            validateMetaField(companionClass, propsOrStateMetaStructName, errorCollector);
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
      errorCollector.addError('Legacy boilerplate must use classes or mixins, and not shorthand class declaration',
          errorCollector.spanFor(node));
    }

    // Check that class name starts with [privateSourcePrefix]
    if (!node.name.name.startsWith(privateSourcePrefix)) {
      errorCollector.addError('The class `${node.name.name}` does not start with `$privateSourcePrefix`. All Props, State, '
          'AbstractProps, and AbstractState classes should begin with `$privateSourcePrefix` on Dart 2',
          errorCollector.spanFor(node));
    }
  }
}

class BoilerplateProps extends BoilerplatePropsOrState {
  BoilerplateProps(ClassishDeclaration nodeHelper, int declarationConfidence,
      {ClassishDeclaration companionClass})
      : withMeta = nodeHelper.node.hasAnnotationWithName('AbstractProps')
            ? NodeWithMeta<NamedCompilationUnitMember, annotations.AbstractProps>(nodeHelper.node)
            : NodeWithMeta<NamedCompilationUnitMember, annotations.Props>(nodeHelper.node),
        super(nodeHelper, declarationConfidence,
            companionClass: companionClass);

  @override
  final NodeWithMeta<NamedCompilationUnitMember, annotations.TypedMap> withMeta;

  @override
  bool get isProps => true;
}

class BoilerplateState extends BoilerplatePropsOrState {
  BoilerplateState(ClassishDeclaration nodeHelper, int declarationConfidence,
      {ClassishDeclaration companionClass})
      : withMeta = nodeHelper.node.hasAnnotationWithName('AbstractState')
            ? NodeWithMeta<NamedCompilationUnitMember, annotations.AbstractState>(nodeHelper.node)
            : NodeWithMeta<NamedCompilationUnitMember, annotations.State>(nodeHelper.node),
        super(nodeHelper, declarationConfidence,
            companionClass: companionClass);

  @override
  final NodeWithMeta<NamedCompilationUnitMember, annotations.TypedMap> withMeta;

  @override
  bool get isProps => false;
}

abstract class BoilerplatePropsOrStateMixin extends BoilerplateMember with PropsStateStringHelpers {
  @override
  final ClassOrMixinDeclaration node;

  final ClassishDeclaration companionClass;

  NodeWithMeta<ClassOrMixinDeclaration, annotations.TypedMap> get withMeta;

  @override
  SimpleIdentifier get name => node.name;

  BoilerplatePropsOrStateMixin(this.node, int declarationConfidence, {@required this.companionClass}) : super(declarationConfidence);

  @override
  String get debugString => '${super.debugString}, companion: ${companionClass?.name}';

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

/// If a [ClassMember] exists in [node] with the name `meta`, this will
/// throw an error if the member is not static and a warning if the member
/// is static.
void checkForMetaPresence(ClassOrMixinDeclaration node, ValidationErrorCollector errorCollector) {
  final metaField = metaFieldOrNull(node);
  final metaMethod = metaMethodOrNull(node);
  final isNotNull = metaField != null || metaMethod != null;
  final isStatic = (metaField?.isStatic ?? false) || (metaMethod?.isStatic ?? false);
  if (isNotNull) {
    // If a class declares a field or method with the name of `meta` which is
    // not static, then we should error, since the static `meta` const in the
    // generated implementation will have a naming collision.
    if (!isStatic) {
      errorCollector.addError('Non-static class member `meta` is declared in ${node.name.name}. '
          '`meta` is a field declared by the over_react builder, and is therefore not '
          'valid for use as a class member in any class annotated with  @Props(), @State(), '
          '@AbstractProps(), @AbstractState(), @PropsMixin(), or @StateMixin()',
          errorCollector.spanFor(metaField ?? metaMethod));
    } else {
      // warn that static `meta` definition will not be accessible by consumers.
      errorCollector.addWarning(messageWithSpan('Static class member `meta` is declared in ${node.name.name}. '
          '`meta` is a field declared by the over_react builder, and therefore this '
          'class member will be unused and should be removed or renamed.',
          span: errorCollector.spanFor(metaField ?? metaMethod)));
    }
  }
}

/// Validates that `meta` field in a companion class or props/state mixin
/// is formatted as expected.
///
/// Meta fields should have the following format:
///   `static const {Props|State}Meta meta = _$metaFor{className};`
///
/// [cd] should be either a [ClassDeclaration] instance for the companion
/// class of a props/state/abstract props/abstract state class, or the
/// [ClassDeclaration] for a props or state mixin class.
void validateMetaField(ClassishDeclaration cd, String expectedType, ValidationErrorCollector errorCollector) {
  final metaField = getMetaField(cd.members);
  if (metaField == null) return;

  if (metaField.fields.type?.toSource() != expectedType) {
    errorCollector.addError(
      'Static meta field in accessor class must be of type `$expectedType`',
      errorCollector.spanFor(metaField),
    );
  }

  final expectedInitializer = '${privateSourcePrefix}metaFor${cd.name.name}';

  final initializer = metaField.fields.variables.single.initializer
      ?.toSource();
  if (!(expectedInitializer == initializer)) {
    errorCollector.addError(
      'Static $expectedType field in accessor class must be initialized to:'
          '`$expectedInitializer`',
      errorCollector.spanFor(metaField),
    );
  }
}

class BoilerplatePropsMixin extends BoilerplatePropsOrStateMixin {
  BoilerplatePropsMixin(ClassOrMixinDeclaration node, int declarationConfidence,
      {ClassishDeclaration companionClass})
      : withMeta = NodeWithMeta(node),
        super(node, declarationConfidence, companionClass: companionClass);

  @override
  final NodeWithMeta<ClassOrMixinDeclaration, annotations.PropsMixin> withMeta;

  @override
  bool get isProps => true;
}

class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin(ClassOrMixinDeclaration node, int declarationConfidence,
      {ClassishDeclaration companionClass})
      : withMeta = NodeWithMeta(node),
        super(node, declarationConfidence, companionClass: companionClass);

  @override
  final NodeWithMeta<ClassOrMixinDeclaration, annotations.StateMixin> withMeta;

  @override
  bool get isProps => false;
}
