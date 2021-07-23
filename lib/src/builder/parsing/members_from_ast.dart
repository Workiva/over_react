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

import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../util.dart';
import 'ast_util.dart';
import 'members.dart';
import 'util.dart';
import 'version.dart';

/// A pattern that can detect a props class or mixin (assuming it follows naming convention).
final propsOrMixinNamePattern = RegExp(r'Props(?:Mixin)?$');

/// A pattern that can detect a props mixin (assuming it follows naming convention).
final propsMixinNamePattern = propsOrMixinNamePattern;

/// A pattern that can detect a state class or mixin (assuming it follows naming convention).
final stateMixinNamePattern = RegExp(r'State(?:Mixin)?$');

/// A pattern that can detect a props class (assuming it follows naming convention).
final propsNamePattern = RegExp(r'Props$');

/// A pattern that can detect a state class (assuming it follows naming convention).
final stateNamePattern = RegExp(r'State$');

/// Returns an unmodifiable collection of all potential boilerplate members
/// detected within [unit], with appropriate [BoilerplateMember.versionConfidences] scores.
BoilerplateMembers detectBoilerplateMembers(CompilationUnit unit) {
  final factories = <BoilerplateFactory>[];
  final props = <BoilerplateProps>[];
  final propsMixins = <BoilerplatePropsMixin>[];
  final components = <BoilerplateComponent>[];
  final states = <BoilerplateState>[];
  final stateMixins = <BoilerplateStateMixin>[];

  _BoilerplateMemberDetector(
    onFactory: factories.add,
    onProps: props.add,
    onPropsMixin: propsMixins.add,
    onComponent: components.add,
    onState: states.add,
    onStateMixin: stateMixins.add,
  ).detect(unit);

  return BoilerplateMembers(
    factories: UnmodifiableListView(factories),
    props: UnmodifiableListView(props),
    propsMixins: UnmodifiableListView(propsMixins),
    components: UnmodifiableListView(components),
    states: UnmodifiableListView(states),
    stateMixins: UnmodifiableListView(stateMixins),
  );
}

/// Helper class that contains logic for detecting boilerplate entities for a given compilation unit
/// and determining their version confidences.
///
/// See: [VersionConfidences], [BoilerplateMember].
class _BoilerplateMemberDetector {
  Map<String, NamedCompilationUnitMember>? _classishDeclarationsByName;

  // Callbacks that will be triggered when the detector finds the correlating entity.
  final void Function(BoilerplateFactory) onFactory;
  final void Function(BoilerplateProps) onProps;
  final void Function(BoilerplateState) onState;
  final void Function(BoilerplatePropsMixin) onPropsMixin;
  final void Function(BoilerplateStateMixin) onStateMixin;
  final void Function(BoilerplateComponent) onComponent;

  _BoilerplateMemberDetector({
    required this.onFactory,
    required this.onProps,
    required this.onState,
    required this.onPropsMixin,
    required this.onStateMixin,
    required this.onComponent,
  });

  /// Process [unit] looking for boilerplate members, calling the appropriate 'on'
  /// methods (e.g. [onFactory]) upon discovery.
  ///
  /// Uses [_BoilerplateMemberDetectorVisitor] to visit the relevant entity types,
  /// looking for boilerplate members.
  void detect(CompilationUnit unit) {
    _classishDeclarationsByName = {};
    final visitor = _BoilerplateMemberDetectorVisitor(
      onClassishDeclaration: (node) => _classishDeclarationsByName![node.name.name] = node,
      onTopLevelVariableDeclaration: _processTopLevelVariableDeclaration,
    );

    unit.accept(visitor);

    _classishDeclarationsByName!.values.forEach(_processClassishDeclaration);
    _classishDeclarationsByName = null;
  }

  void _processTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    _detectFactory(node);
  }

  void _processClassishDeclaration(NamedCompilationUnitMember node) {
    // If this is a companion class, ignore it.
    final sourceClass = _getSourceClassForPotentialCompanion(node);
    if (sourceClass != null) return;

    if (_isMixinStub(node)) return;

    final classish = node.asClassish();
    final companion = _getCompanionClass(node)?.asClassish();

    if (_detectClassBasedOnAnnotations(classish, companion)) return;
    if (_detectNonLegacyPropsStateOrMixin(classish, companion)) return;
    if (_detectPotentialComponent(classish)) return;
  }

  //
  // _classishDeclarationsByName-related utilities
  //

  /// For `FooProps`, returns `_$FooProps`
  NamedCompilationUnitMember? _getSourceClassForPotentialCompanion(NamedCompilationUnitMember node) {
    final name = node.name.name;
    if (name.startsWith(privateSourcePrefix)) {
      return null;
    }
    final sourceName = '$privateSourcePrefix$name';
    return _classishDeclarationsByName![sourceName];
  }

  /// For `_$FooProps`, returns `FooProps`
  NamedCompilationUnitMember? _getCompanionClass(NamedCompilationUnitMember node) {
    final name = node.name.name;
    if (!name.startsWith(privateSourcePrefix)) {
      return null;
    }
    final sourceName = name.replaceFirst(privateSourcePrefix, '');
    return _classishDeclarationsByName![sourceName];
  }

  /// Returns whether it's the `$FooPropsMixin` to a `_$FooPropsMixin`
  bool _isMixinStub(NamedCompilationUnitMember node) {
    final name = node.name.name;
    return name.startsWith(r'$') && _classishDeclarationsByName!.containsKey('_$name');
  }

  //
  // _processTopLevelVariableDeclaration helpers
  //

  void _detectFactory(TopLevelVariableDeclaration node) {
    if (node.hasAnnotationWithName('Factory')) {
      onFactory(BoilerplateFactory(node, VersionConfidences.all(Confidence.likely)));
      return;
    }

    final rightHandSide = node.variables.firstInitializer;
    if (rightHandSide != null && node.usesAGeneratedConfig) {
      onFactory(BoilerplateFactory(
          node,
          VersionConfidences(
            v4_mixinBased: Confidence.likely,
            v3_legacyDart2Only: Confidence.none,
            v2_legacyBackwardsCompat: Confidence.none,
          )));
      return;
    }

    final type = node.variables.type;
    if (type != null) {
      if (type.typeNameWithoutPrefix == 'UiFactory') {
        final firstVar = node.variables.variables.first;
        final name = firstVar.name.name;
        final initializer = firstVar.initializer;

        // Check for `Foo = _$Foo` or `Foo = $Foo` (which could be a typo)
        final generatedFactoryName = '_\$$name';
        final typoGeneratedFactoryName = '\$$name';
        final referencesGeneratedFactory = initializer != null &&
            anyDescendantIdentifiers(initializer, (identifier) {
              return identifier.name == generatedFactoryName ||
                  identifier.name == typoGeneratedFactoryName;
            });

        if (referencesGeneratedFactory) {
          onFactory(BoilerplateFactory(
              node,
              VersionConfidences(
                v4_mixinBased: Confidence.likely,
                v3_legacyDart2Only: Confidence.none,
                v2_legacyBackwardsCompat: Confidence.none,
              )));
          return;
        } else {
          onFactory(BoilerplateFactory(
              node,
              VersionConfidences(
                v4_mixinBased: Confidence.neutral,
                v2_legacyBackwardsCompat: Confidence.none,
                v3_legacyDart2Only: Confidence.none,
              )));
          return;
        }
      }
    }

    return;
  }

  //
  // _processClassishDeclaration helpers
  //

  bool _detectClassBasedOnAnnotations(ClassishDeclaration classish, ClassishDeclaration? companion) {
    final node = classish.node;
    for (final annotation in classish.metadata) {
      switch (annotation.name.nameWithoutPrefix) {
        case 'Props':
          // It has never been possible to declare a props class with a mixin, so we can safely
          // assume that Dart mixins are not concrete props classes.
          //
          // Special-case: `@Props()` is allowed on the new boilerplate mixins
          if (node is MixinDeclaration) {
            onPropsMixin(BoilerplatePropsMixin(
                node,
                companion,
                _annotatedPropsOrStateMixinConfidence(classish, companion,
                    disableAnnotationAssert: true)));
          } else {
            onProps(BoilerplateProps(
                classish, companion, _annotatedPropsOrStateConfidence(classish, companion)));
          }
          return true;

        case 'State':
          // It has never been possible to declare a state class with a mixin, so we can safely
          // assume that Dart mixins are not concrete state classes.
          //
          // Special-case: `@State()` is allowed on the new boilerplate mixins
          if (node is MixinDeclaration) {
            onStateMixin(BoilerplateStateMixin(
                node,
                companion,
                _annotatedPropsOrStateMixinConfidence(classish, companion,
                    disableAnnotationAssert: true)));
          } else {
            onState(BoilerplateState(
                classish, companion, _annotatedPropsOrStateConfidence(classish, companion)));
          }
          return true;

        case 'PropsMixin':
          onPropsMixin(BoilerplatePropsMixin(node as ClassOrMixinDeclaration, companion,
              _annotatedPropsOrStateMixinConfidence(classish, companion)));
          return true;

        case 'StateMixin':
          onStateMixin(BoilerplateStateMixin(node as ClassOrMixinDeclaration, companion,
              _annotatedPropsOrStateMixinConfidence(classish, companion)));
          return true;

        case 'Component':
        case 'Component2':
          // Don't have lower confidence for mixin-based when `@Component`;
          // we want it equal so that it can resolve to mixin-based based on the other parts, and
          // warn for not having `@Component2`.
          onComponent(BoilerplateComponent(classish, VersionConfidences.all(Confidence.likely)));
          return true;

        case 'AbstractProps':
          onProps(BoilerplateProps(
              classish, companion, _annotatedAbstractPropsOrStateConfidence(classish, companion)));
          return true;

        case 'AbstractState':
          onState(BoilerplateState(
              classish, companion, _annotatedAbstractPropsOrStateConfidence(classish, companion)));
          return true;

        case 'AbstractComponent':
        case 'AbstractComponent2':
          onComponent(BoilerplateComponent(classish, VersionConfidences.none()));
          return true;
      }
    }

    return false;
  }

  VersionConfidences _annotatedPropsOrStateConfidence(
      ClassishDeclaration classish, ClassishDeclaration? companion) {
    final node = classish.node;
    assert(node.hasAnnotationWithNames(const {'Props', 'State'}),
        'this function assumes that all nodes passed to this function are annotated');

    assert(node is! MixinDeclaration,
        'Mixins should never make it in here they should be classified as Props/State mixins');

    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');
    final hasCompanionClass = companion != null;

    if (hasCompanionClass) {
      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.likely,
        v3_legacyDart2Only: Confidence.unlikely,
        v4_mixinBased: Confidence.unlikely,
      );
    } else if (hasGeneratedPrefix) {
      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.unlikely,
        v3_legacyDart2Only: Confidence.likely,
        v4_mixinBased: Confidence.unlikely,
      );
    } else {
      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.unlikely,
        v3_legacyDart2Only: Confidence.unlikely,
        v4_mixinBased: Confidence.likely,
      );
    }
  }

  VersionConfidences _annotatedAbstractPropsOrStateConfidence(
      ClassishDeclaration classish, ClassishDeclaration? companion) {
    final node = classish.node;
    assert(node.hasAnnotationWithNames(const {'AbstractProps', 'AbstractState'}),
        'this function assumes that all nodes passed to this function are annotated');

    final hasCompanionClass = companion != null;

    if (hasCompanionClass) {
      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.likely,
        v3_legacyDart2Only: Confidence.unlikely,
        // Annotated abstract props/state don't exist to the new boilerplate
        v4_mixinBased: Confidence.none,
      );
    } else {
      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.unlikely,
        v3_legacyDart2Only: Confidence.likely,
        // Annotated abstract props/state don't exist to the new boilerplate
        v4_mixinBased: Confidence.none,
      );
    }
  }

  VersionConfidences _annotatedPropsOrStateMixinConfidence(
      ClassishDeclaration classish, ClassishDeclaration? companion,
      {bool disableAnnotationAssert = false}) {
    final node = classish.node;
    assert(
        disableAnnotationAssert || node.hasAnnotationWithNames(const {'PropsMixin', 'StateMixin'}),
        'this function assumes that all nodes passed to this function are annotated');

    final isMixin = node is MixinDeclaration;
    final hasGeneratedPrefix = node.name.name.startsWith(r'_$');

    return VersionConfidences(
      v2_legacyBackwardsCompat: isMixin
          ? Confidence.none
          : (hasGeneratedPrefix ? Confidence.unlikely : Confidence.likely),
      v3_legacyDart2Only: isMixin
          ? Confidence.none
          : (hasGeneratedPrefix ? Confidence.likely : Confidence.unlikely),
      v4_mixinBased: isMixin ? Confidence.likely : Confidence.unlikely,
    );
  }

  bool _detectNonLegacyPropsStateOrMixin(
      ClassishDeclaration classish, ClassishDeclaration? companion) {
    final name = classish.name.name;
    final node = classish.node;

    // By this point, this is a node that has no annotation.
    // Thus, it's non-legacy boilerplate.

    VersionConfidences getConfidence() {
      // Handle classes that look like props but are really just used as interfaces, and aren't extended from or directly used as a component's props.
      // Watch out for empty mixins, though; those are valid props/state mixins.
      if (_overridesIsClassGenerated(classish) ||
          (node is! MixinDeclaration && onlyImplementsThings(classish))) {
        return VersionConfidences.none();
      } else if (classish.members.whereType<ConstructorDeclaration>().isNotEmpty) {
        // If there's a constructor, it's a no-generate class. For example, a props map view.
        return VersionConfidences.none();
      }

      return VersionConfidences(
        v2_legacyBackwardsCompat: Confidence.none,
        v3_legacyDart2Only: Confidence.none,
        v4_mixinBased: Confidence.likely,
      );
    }

    if (node is MixinDeclaration) {
      if (propsMixinNamePattern.hasMatch(name) && node.hasSuperclassConstraint('UiProps')) {
        onPropsMixin(BoilerplatePropsMixin(node, companion, getConfidence()));
        return true;
      }
      if (stateMixinNamePattern.hasMatch(name) && node.hasSuperclassConstraint('UiState')) {
        onStateMixin(BoilerplateStateMixin(node, companion, getConfidence()));
        return true;
      }
    } else {
      // We never generate for abstract classes in the new boilerplate.
      if (classish.abstractKeyword != null) return false;

      final superclassName = classish.superclass?.typeNameWithoutPrefix;
      if (propsNamePattern.hasMatch(name) && superclassName == 'UiProps') {
        onProps(BoilerplateProps(classish, companion, getConfidence()));
        return true;
      }
      if (stateNamePattern.hasMatch(name) && superclassName == 'UiState') {
        onState(BoilerplateState(classish, companion, getConfidence()));
        return true;
      }
    }

    return false;
  }

  /// UiComponent, UiComponent2, UiStatefulComponent, FluxUiComponent, CustomUiComponent, ...
  static final _componentBaseClassPattern = RegExp(r'Ui\w*Component');

  bool _detectPotentialComponent(ClassishDeclaration classish) {
    // Don't detect react-dart components as boilerplate components, since they cause issues with grouping
    // if they're in the same file as an OverReact component with non-matching names.
    if (!const {'Component', 'Component2'}.contains(classish.superclass?.nameWithoutPrefix)) {
      if (classish.name.name.endsWith('Component') ||
          classish.allSuperTypes
              .map((t) => t.typeNameWithoutPrefix)
              .whereNotNull()
              .any(_componentBaseClassPattern.hasMatch) ||
          [...?classish.superclass?.typeArguments?.arguments]
              .map((t) => t.typeNameWithoutPrefix)
              .whereNotNull()
              .any(propsOrMixinNamePattern.hasMatch)) {
        const mixinBoilerplateBaseClasses = {
          'UiComponent2',
          'UiStatefulComponent2',
          'FluxUiComponent2',
          'FluxUiStatefulComponent2'
        };
        final confidences = VersionConfidences(
          // If the component extends from a base class known to be supported by the new boilerplate,
          // has no annotation, is not abstract, and does not have $isClassGenerated, then it's
          // most likely intended to be part of a new boilerplate class component declaration.
          //
          // Make this `likely` so that components that don't get associated with factory/props
          // due to naming issues aren't silently ignored.
          v4_mixinBased: !classish.hasAbstractKeyword &&
                  !_overridesIsClassGenerated(classish) &&
                  mixinBoilerplateBaseClasses.contains(classish.superclass?.nameWithoutPrefix)
              ? Confidence.likely
              : Confidence.neutral,
          v2_legacyBackwardsCompat: Confidence.neutral,
          v3_legacyDart2Only: Confidence.neutral,
        );
        onComponent(BoilerplateComponent(classish, confidences));

        return true;
      }
    }

    return false;
  }

  static bool _overridesIsClassGenerated(ClassishDeclaration classish) => classish.members
      .whereType<MethodDeclaration>()
      .any((member) => member.isGetter && member.name.name == r'$isClassGenerated');
}

class _BoilerplateMemberDetectorVisitor extends SimpleAstVisitor<void> {
  final void Function(NamedCompilationUnitMember) onClassishDeclaration;
  final void Function(TopLevelVariableDeclaration) onTopLevelVariableDeclaration;

  _BoilerplateMemberDetectorVisitor({
    required this.onClassishDeclaration,
    required this.onTopLevelVariableDeclaration,
  });

  @override
  void visitCompilationUnit(CompilationUnit node) => node.visitChildren(this);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) =>
      onTopLevelVariableDeclaration(node);

  @override
  void visitClassDeclaration(ClassDeclaration node) => onClassishDeclaration(node);

  @override
  void visitClassTypeAlias(ClassTypeAlias node) => onClassishDeclaration(node);

  @override
  void visitMixinDeclaration(MixinDeclaration node) => onClassishDeclaration(node);
}
