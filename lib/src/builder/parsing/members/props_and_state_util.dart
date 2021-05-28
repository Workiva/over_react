// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of '../members.dart';

extension on String {
  String capitalize() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

/// A mixin containing getters that can be used to facilitate runtime [String] checks
/// for a props and state class.
abstract class PropsStateStringHelpers {
  bool get isProps;
  String get propsOrStateString => isProps ? 'props' : 'state';
  String get propsOrStateStringCapitalized => propsOrStateString.capitalize();
  String get propsOrStateBaseClassString => 'Ui$propsOrStateStringCapitalized';
  String get propsOrStateClassString => '$propsOrStateStringCapitalized class';
  String get propsOrStateMixinString => '$propsOrStateStringCapitalized mixin';
  String get propsOrStateFieldsName => isProps ? 'props' : 'state fields';
  String get propsOrStateMetaStructName => isProps ? 'PropsMeta' : 'StateMeta';
  String get propsOrStateAnnotationName => isProps ? 'Props' : 'State';
  String get propsOrStateAbstractAnnotationName => isProps ? 'AbstractProps' : 'AbstractState';
  String get propsOrStateMixinAnnotationName => isProps ? 'PropsMixin' : 'StateMixin';

  RegExp get propsOrStateMixinNamePattern =>
      isProps ? propsMixinNamePattern : stateMixinNamePattern;

  factory PropsStateStringHelpers.props() => _PropsStateStringHelpersImpl(isProps: true);
  factory PropsStateStringHelpers.state() => _PropsStateStringHelpersImpl(isProps: false);
}

class _PropsStateStringHelpersImpl extends Object with PropsStateStringHelpers {
  @override
  final bool isProps;

  _PropsStateStringHelpersImpl({@required this.isProps});
}

/// Uses [InstantiatedMeta] to analyze [node] and determine the proper annotation.
annotations.TypedMap getPropsOrStateAnnotation(bool isProps, AnnotatedNode node) {
  final meta = isProps
      ? (InstantiatedMeta<annotations.Props>(node) ??
          InstantiatedMeta<annotations.AbstractProps>(node) ??
          // ignore: deprecated_member_use_from_same_package
          InstantiatedMeta<annotations.PropsMixin>(node))
      : (InstantiatedMeta<annotations.State>(node) ??
          InstantiatedMeta<annotations.AbstractState>(node) ??
          // ignore: deprecated_member_use_from_same_package
          InstantiatedMeta<annotations.StateMixin>(node));

  return meta?.value ?? (isProps ? annotations.Props() : annotations.State());
}

/// If a [ClassMember] exists in [node] with the name `meta`, this will
/// throw an error if the member is not static and a warning if the member
/// is static.
void checkForMetaPresence(ClassOrMixinDeclaration node, ErrorCollector/*!*/ errorCollector) {
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
void validateMetaField(ClassishDeclaration cd, String expectedType, ErrorCollector/*!*/ errorCollector) {
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
