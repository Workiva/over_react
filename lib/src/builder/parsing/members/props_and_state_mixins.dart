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

/// A member representing a props or state mixin.
///
/// See [BoilerplateMember] for more information.
abstract class BoilerplatePropsOrStateMixin extends BoilerplateTypedMapMember
    with PropsStateStringHelpers {
  BoilerplatePropsOrStateMixin(this.node, this.companion, VersionConfidences confidence)
      : super(confidence) {
    meta = getPropsOrStateAnnotation(isProps, node);
  }

  /// The [MixinDeclaration] backing the member
  @override
  final ClassOrMixinDeclaration node;

  /// A metadata class that lifts helpful fields out of [node] to a top level,
  /// in addition to providing additional getters relevant member parsing.
  @override
  ClassishDeclaration get nodeHelper => node.asClassish();

  /// The companion class for the props or state mixins.
  ///
  /// This will only be present for [Version.v2_legacyBackwardsCompat] classes.
  final ClassishDeclaration companion;

  /// The corresponding annotation.
  ///
  /// This is determined at runtime by detecting the type of class (props or state)
  /// based upon what annotation is present upon [node].
  @override
  annotations.TypedMap meta;

  @override
  SimpleIdentifier get name => node.name;

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  /// Verifies the correct implementation of every boilerplate props and state mixin version.
  ///
  /// Major checks included are:
  /// - Verify legacy boilerplate has the correct annotation
  /// - Enforce that the node has an abstract getter
  /// - Verify mixins are implemented correctly
  @override
  void validate(Version version, ErrorCollector errorCollector) {
    void _sharedLegacyValidation() {
      if (!node.hasAnnotationWithName(propsOrStateMixinAnnotationName)) {
        errorCollector.addError(
            'Legacy boilerplate ${propsOrStateMixinString}s must be annotated with '
            '`@$propsOrStateMixinAnnotationName()`',
            errorCollector.spanFor(node.name));
      }

      bool implementsBaseClass() =>
          node.implementsClause?.interfaces
              ?.any((type) => type.name.nameWithoutPrefix == propsOrStateBaseClassString) ??
          false;

      if (!node.hasAbstractGetter('Map', propsOrStateString) && !implementsBaseClass()) {
        errorCollector.addError(
            'For static analysis purposes, $propsOrStateMixinString classes must either:'
            ' A) `implement $propsOrStateBaseClassString`'
            ' or B) declare an abstract $propsOrStateString getter `Map get $propsOrStateString;`.',
            errorCollector.spanFor(node.name));
      }
    }

    switch (version) {
      case Version.v4_mixinBased:
        final node = this.node;
        if (node is MixinDeclaration) {
          final isOnBaseClass = node.onClause?.superclassConstraints
                  ?.any((type) => type.nameWithoutPrefix == propsOrStateBaseClassString) ??
              false;
          if (!isOnBaseClass) {
            errorCollector.addError(
                '$propsOrStateString mixins must be `on $propsOrStateBaseClassString`',
                errorCollector.spanFor(node.onClause ?? node.name));
          }
        } else {
          errorCollector.addError('$propsOrStateString mixins must be mixins',
              errorCollector.spanFor(nodeHelper.classOrMixinKeyword));
        }
        break;
      case Version.v2_legacyBackwardsCompat:
        _sharedLegacyValidation();
        validateMetaField(node.asClassish(), propsOrStateMetaStructName, errorCollector);
        break;
      case Version.v3_legacyDart2Only:
        _sharedLegacyValidation();
        checkForMetaPresence(node, errorCollector);
        break;
    }
  }
}

/// A member representing a props mixin.
///
/// See [BoilerplateMember] for more information.
class BoilerplatePropsMixin extends BoilerplatePropsOrStateMixin {
  BoilerplatePropsMixin(
      ClassOrMixinDeclaration node, ClassishDeclaration companion, VersionConfidences confidence)
      : super(node, companion, confidence);

  @override
  bool get isProps => true;
}

/// A member representing a state mixin.
///
/// See [BoilerplateMember] for more information.
class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin(
      ClassOrMixinDeclaration node, ClassishDeclaration companion, VersionConfidences confidence)
      : super(node, companion, confidence);

  @override
  bool get isProps => false;
}
