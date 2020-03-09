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

annotations.TypedMap getPropsOrStateAnnotation(bool isProps, AnnotatedNode node) {
  final meta = isProps
      ? (InstantiatedMeta<annotations.Props>(node) ??
          InstantiatedMeta<annotations.AbstractProps>(node) ??
          InstantiatedMeta<annotations.PropsMixin>(node))
      : (InstantiatedMeta<annotations.State>(node) ??
          InstantiatedMeta<annotations.AbstractState>(node) ??
          InstantiatedMeta<annotations.StateMixin>(node));

  return meta?.value ?? (isProps ? annotations.Props() : annotations.State());
}

/// If a [ClassMember] exists in [node] with the name `meta`, this will
/// throw an error if the member is not static and a warning if the member
/// is static.
void checkForMetaPresence(ClassOrMixinDeclaration node, ErrorCollector errorCollector) {
  final metaField = metaFieldOrNull(node);
  final metaMethod = metaMethodOrNull(node);
  final isNotNull = metaField != null || metaMethod != null;
  final isStatic = (metaField?.isStatic ?? false) || (metaMethod?.isStatic ?? false);
  if (isNotNull) {
    // If a class declares a field or method with the name of `meta` which is
    // not static, then we should error, since the static `meta` const in the
    // generated implementation will have a naming collision.
    if (!isStatic) {
      errorCollector.addError(
          'Non-static class member `meta` is declared in ${node.name.name}. '
          '`meta` is a field declared by the over_react builder, and is therefore not '
          'valid for use as a class member in any class annotated with  @Props(), @State(), '
          '@AbstractProps(), @AbstractState(), @PropsMixin(), or @StateMixin()',
          errorCollector.spanFor(metaField ?? metaMethod));
    } else {
      // warn that static `meta` definition will not be accessible by consumers.
      errorCollector.addWarning(messageWithSpan(
          'Static class member `meta` is declared in ${node.name.name}. '
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
void validateMetaField(ClassishDeclaration cd, String expectedType, ErrorCollector errorCollector) {
  final metaField = getMetaField(cd.members);
  if (metaField == null) return;

  if (metaField.fields.type?.toSource() != expectedType) {
    errorCollector.addError(
      'Static meta field in accessor class must be of type `$expectedType`',
      errorCollector.spanFor(metaField),
    );
  }

  final expectedInitializer = '${privateSourcePrefix}metaFor${cd.name.name}';

  final initializer = metaField.fields.variables.single.initializer?.toSource();
  if (!(expectedInitializer == initializer)) {
    errorCollector.addError(
      'Static $expectedType field in accessor class must be initialized to:'
      '`$expectedInitializer`',
      errorCollector.spanFor(metaField),
    );
  }
}
