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

/// A member representing a props or state class.
///
/// See [BoilerplateMember] for more information.
abstract class BoilerplatePropsOrState extends BoilerplateTypedMapMember
    with PropsStateStringHelpers {
  BoilerplatePropsOrState(this.nodeHelper, this.companion, VersionConfidences confidence)
      : node = nodeHelper.node,
        super(confidence) {
    meta = getPropsOrStateAnnotation(isProps, node);
  }

  /// The [ClassDeclaration] backing the member
  @override
  final NamedCompilationUnitMember node;

  /// A metadata class that lifts helpful fields out of [node] to a top level,
  /// in addition to providing additional getters relevant member parsing.
  @override
  final ClassishDeclaration nodeHelper;

  /// The companion class for the props or state.
  ///
  /// This will only be present for [Version.v2_legacyBackwardsCompat] classes.
  final ClassishDeclaration companion;

  /// The corresponding annotation.
  ///
  /// This is determined at runtime by detecting the type of class (props, state, abstract)
  /// based upon what annotation is present upon [node].
  @override
  annotations.TypedMap meta;

  @override
  SimpleIdentifier get name => nodeHelper.name;

  @override
  String get debugString => '${super.debugString}, companion: ${companion?.name}';

  /// Verifies the correct implementation of every boilerplate props and state version.
  ///
  /// Major checks included are:
  /// - Preventing the class from being a mixin
  /// - Checking for the correct super class (and not being abstract)
  /// - Enforcing that no members are instantiated
  /// - Verifying legacy prefixes and companions are present
  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        final node = this.node;
        if (node is MixinDeclaration) {
          // It is not expected that this case will ever occur. However, for
          // completeness it is as a case that will error.
          errorCollector.addError(
              '$propsOrStateClassString implementations must be concrete classes, not mixins',
              errorCollector.spanFor(node.mixinKeyword));
        } else {
          if (nodeHelper.superclass?.nameWithoutPrefix != propsOrStateBaseClassString) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must extend directly from $propsOrStateBaseClassString',
                errorCollector.spanFor(nodeHelper.superclass ?? node));
          }

          if (node is ClassDeclaration && !node.members.every(isStaticMember)) {
            errorCollector.addError(
                '$propsOrStateClassString implementations must not declare any $propsOrStateFieldsName or other non-static members.',
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
        if (!nodeHelper.members.every(isStaticMember) ||
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

/// A member representing a props class.
///
/// See [BoilerplateMember] for more information.
class BoilerplateProps extends BoilerplatePropsOrState {
  BoilerplateProps(
      ClassishDeclaration nodeHelper, ClassishDeclaration companion, VersionConfidences confidence)
      : super(nodeHelper, companion, confidence);

  @override
  bool get isProps => true;
}

/// A member representing a state class.
///
/// See [BoilerplateMember] for more information.
class BoilerplateState extends BoilerplatePropsOrState {
  BoilerplateState(
      ClassishDeclaration nodeHelper, ClassishDeclaration companion, VersionConfidences confidence)
      : super(nodeHelper, companion, confidence);

  @override
  bool get isProps => false;
}
