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

/// The class that represents a boilerplate props or state mixin.
abstract class BoilerplatePropsOrStateMixin extends BoilerplateAccessorsMember
    with PropsStateStringHelpers {
  BoilerplatePropsOrStateMixin({
    @required this.node,
    @required this.companion,
    @required this.mixinStub,
    @required VersionConfidence confidence,
  }) : super(confidence) {
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

  /// The $-prefixed class stubbed in for this mixin, for [Version.v2_legacyBackwardsCompat]
  /// compatibility
  ///
  /// This will only be present for [Version.v3_legacyDart2Only] classes.
  final ClassishDeclaration mixinStub;

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
            errorCollector.spanFor(node));
      }

      if (!node.hasAbstractGetter('Map', propsOrStateString)) {
        errorCollector.addError(
            '$propsOrStateMixinString classes must declare an abstract $propsOrStateString getter `Map get $propsOrStateString;` '
            'so that they can be statically analyzed properly.',
            errorCollector.spanFor(node));
      }
    }

    switch (version) {
      case Version.v4_mixinBased:
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

        if (mixinStub == null || getMetaField(mixinStub.members) == null) {
          final path = errorCollector.spanFor(node).file?.url?.toString() ?? '';
          final shouldIgnore = path.startsWith('web/component1/') || path.startsWith('test/over_react/');
          final isOverReactLib = path.startsWith('package:over_react');

          if (!shouldIgnore) {
            final stubName = name.name.replaceFirst(privateSourcePrefix, r'$');
            assert(mixinStub == null || mixinStub.name.name == stubName);
            (isOverReactLib ? errorCollector.addError : errorCollector.addWarning)(
                'For compatibility with the new mixin-based boilerplate, this $propsOrStateMixinString'
                    ' should stub in a "$stubName" class with valid meta field, which are both used by generated code:\n\n'
                    'abstract class $stubName {\n'
                    '  static const $propsOrStateMetaStructName meta = _\$metaFor${name.name};\n'
                    '}',
                errorCollector.spanFor(mixinStub?.node ?? node));
          }
        }
        break;
    }

    if (version != Version.v3_legacyDart2Only && mixinStub != null) {
      errorCollector.addWarning(
          'This class will be generated, and is only valid for the legacy Dart-2-only boilerplate.'
              ' Is this left over from the boilerplate upgrade?',
          errorCollector.spanFor(mixinStub.node));
    }
  }
}

/// The implementation class for boilerplate props mixins
class BoilerplatePropsMixin extends BoilerplatePropsOrStateMixin {
  BoilerplatePropsMixin({
    @required ClassOrMixinDeclaration node,
    @required ClassishDeclaration companion,
    @required ClassishDeclaration mixinStub,
    @required VersionConfidence confidence,
  }) : super(
          node: node,
          companion: companion,
          mixinStub: mixinStub,
          confidence: confidence,
        );

  @override
  bool get isProps => true;
}

/// The implementation class for boilerplate state mixins
class BoilerplateStateMixin extends BoilerplatePropsOrStateMixin {
  BoilerplateStateMixin({
    @required ClassOrMixinDeclaration node,
    @required ClassishDeclaration companion,
    @required ClassishDeclaration mixinStub,
    @required VersionConfidence confidence,
  }) : super(
          node: node,
          companion: companion,
          mixinStub: mixinStub,
          confidence: confidence,
        );

  @override
  bool get isProps => false;
}
