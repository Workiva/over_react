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

import 'ast_util.dart';
import 'declarations.dart';
import 'member_association.dart';
import 'members.dart';
import 'util.dart';
import 'error_collection.dart';
import 'version.dart';

const overReactBoilerplateAnnotations = [
  'Factory',
  'Component',
  'Component2',
  'Props',
  'State',
  'AbstractComponent',
  'AbstractComponent2',
  'AbstractProps',
  'AbstractState',
  'PropsMixin',
  'StateMixin',
];

final RegExp _maybeDeclarationPattern = RegExp(
    r'\.over_react\.g\.dart'
            // Legacy components (annotation required)
            r'|@(?:' +
        overReactBoilerplateAnnotations.join('|') +
        r')'
            // New components (references to props base classes required);
            // find other base classes for validation purposes
            r'|Ui(?:Factory|Props|Component|State)',
    caseSensitive: true);

/// Detects if [source] contains any key words related to boilerplate declarations.
bool mightContainDeclarations(String source) {
  return _maybeDeclarationPattern.hasMatch(source);
}

/// Associates boilerplate [members] with each other, grouping them into declarations and returning
/// only the ones that require code generation.
///
/// If some members cannot be grouped into a valid declaration, appropriate errors will be passed to
/// [errorCollector].
///
/// The order of evaluation is as follows:
///   1. [LegacyAbstractPropsDeclaration]
///   1. [LegacyAbstractStateDeclaration]
///   1. [PropsMixinDeclaration]
///   1. [StateMixinDeclaration]
///   // None of the above include any component boilerplate entities, only props or state
///   1. [LegacyClassComponentDeclaration] (special case for when there is only 1 of each entity in the file)
///   1. Any of: [LegacyClassComponentDeclaration], [ClassComponentDeclaration], [PropsMapViewOrFunctionComponentDeclaration]
Iterable<BoilerplateDeclaration> getBoilerplateDeclarations(
    BoilerplateMembers members, ErrorCollector errorCollector) sync* {
  if (members.isEmpty) return;

  final _consumedMembers = <BoilerplateMember>{};

  /// Indicate that [member] has been grouped into a declaration,
  /// so that it is not grouped into another declaration.
  void consume(BoilerplateMember member) {
    if (member == null) throw ArgumentError.notNull('member');

    final wasAdded = _consumedMembers.add(member);

    if (!wasAdded) throw StateError('Member should not have been consumed already: $member');
  }

  /// Returns whether [member] has already been grouped into a declaration.
  bool hasBeenConsumed(BoilerplateMember member) {
    if (member == null) throw ArgumentError.notNull('member');

    return _consumedMembers.contains(member);
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Legacy abstract props/state/component classes
  //
  // They can be declared stand-alone without needing other abstract component members, so grouping
  // them isn't helpful, and can actually cause issues for edge cases where there are other
  // `noGenerate` members with similar names.
  //
  // So, we handle them individually, similarly to mixins.
  //
  // We also want to process and consume them before the special-case one-component-per-file
  // handling, since it's possible to declare a component with mismatched names as well as
  // an abstract component in the same file.
  //

  for (final propsClass in members.props) {
    final version = resolveVersion([propsClass]);
    if (version.shouldGenerate &&
        version.version.isLegacy &&
        propsClass.node.hasAnnotationWithName('AbstractProps')) {
      consume(propsClass);
      yield LegacyAbstractPropsDeclaration(version: version.version, props: propsClass);
    }
  }

  for (final stateClass in members.states) {
    final version = resolveVersion([stateClass]);
    if (version.shouldGenerate &&
        version.version.isLegacy &&
        stateClass.node.hasAnnotationWithName('AbstractState')) {
      consume(stateClass);
      yield LegacyAbstractStateDeclaration(version: version.version, state: stateClass);
    }
  }

  for (final component in members.components) {
    final version = resolveVersion([component]);
    if (version.version.isLegacy && component.hasAbstractAnnotation) {
      consume(component);
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Props/state mixins
  //
  // Don't consume them so that they can be associated with any components
  // that use them in the shorthand syntax.
  //

  for (var propsMixin in members.propsMixins) {
    final version = resolveVersion([propsMixin]);
    if (version.shouldGenerate) {
      yield PropsMixinDeclaration(version: version.version, mixin: propsMixin);
    }
  }

  for (var stateMixin in members.stateMixins) {
    final version = resolveVersion([stateMixin]);
    if (version.shouldGenerate) {
      yield StateMixinDeclaration(version: version.version, mixin: stateMixin);
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Special-case handling: if there's only one component declared in the file,
  // and it's a legacy component, group the members together even if their names don't match.
  //
  // This is to prevent regressing these cases when switching to the new parser, since the old one
  // was name-agnostic and expected at most one non-abstract component per file.

  {
    final props = members.props.whereNot(hasBeenConsumed).toList();
    final components = members.components.whereNot(hasBeenConsumed).toList();
    final states = members.states.whereNot(hasBeenConsumed).toList();
    final factories = members.factories.whereNot(hasBeenConsumed).toList();

    if (props.length == 1 &&
        components.length == 1 &&
        factories.length == 1 &&
        states.length <= 1) {
      final propsClass = props.single;
      final state = states.isNotEmpty ? states.single : null;
      final component = components.single;
      final factory = factories.single;

      final members = [
        propsClass,
        if (state != null) state,
        component,
        factory,
      ];

      final version = resolveVersion(members);
      if (version.shouldGenerate && version.version.isLegacy) {
        members.forEach(consume);
        yield LegacyClassComponentDeclaration(
          version: version.version,
          factory: factory,
          props: propsClass,
          state: state,
          component: component,
        );
      }
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Declarations with factories (components and non-legacy map views)
  //

  // todo getPropsForFactories getComponent utils - what if there are multiple candidates?
  //  Do we just go with the first one, or do we use confidence scores? It's possible something could look like a component or props class

  // Give the more confident factories priority when grouping, so that medium-confidence related
  // factories that don't require generation (like aliased factories) don't trump the real factory.
  final factoriesMostToLeastConfidence = List.of(members.factories)
    ..sort((a, b) => b.versionConfidences.maxConfidence.confidence
        .compareTo(a.versionConfidences.maxConfidence.confidence));
  for (final factory in factoriesMostToLeastConfidence) {
    final propsClassOrMixin = getPropsFor(factory, members.props, members.propsMixins);
    final stateClassOrMixin = getStateFor(factory, members.states, members.stateMixins);
    if (propsClassOrMixin == null) {
      // will be validated below the for-loop.
      continue;
    }
    if (hasBeenConsumed(propsClassOrMixin.either) ||
        (stateClassOrMixin != null && hasBeenConsumed(stateClassOrMixin?.either))) {
      // Don't try to group if the matching class has already been consumed.
      // We do this instead of trying to get the next best match, since that can result in
      // unexpected behavior when a class has both a props class and props mixin with multiple
      // factories.
      continue;
    }

    final component = getComponentFor(factory, members.components);
    if (component != null && hasBeenConsumed(component)) {
      // Don't try to group if the matching class has already been consumed.
      continue;
    }

    void consumePropsAndState() {
      // Even though mixins are generated regardless of whether they're part of a component,
      // it's safe to remove them since they were generated above.
      // We do this because two factories can't have the same impl class generated from a single mixin
      // since they would collide (though, we could change that later if desired).
      consume(propsClassOrMixin.either);
      if (stateClassOrMixin != null) {
        consume(stateClassOrMixin.either);
      }
    }

    if (component != null) {
      consume(factory);
      consumePropsAndState();
      consume(component);

      final version = resolveVersion([
        factory,
        propsClassOrMixin.either,
        component,
        if (stateClassOrMixin != null) stateClassOrMixin.either,
      ]);

      if (version.shouldGenerate) {
        switch (version.version) {
          case Version.v2_legacyBackwardsCompat:
          case Version.v3_legacyDart2Only:
            yield LegacyClassComponentDeclaration(
                version: version.version,
                factory: factory,
                component: component,
                props: propsClassOrMixin.a,
                state: stateClassOrMixin?.a);
            break;
          case Version.v4_mixinBased:
            yield ClassComponentDeclaration(
                factory: factory,
                component: component,
                props: propsClassOrMixin,
                state: stateClassOrMixin);
            break;
        }
      }
    } else {
      final version = resolveVersion([factory, propsClassOrMixin.either]);
      // The leftover logic below will handle legacy members
      if (version.shouldGenerate && version.version == Version.v4_mixinBased) {
        consume(factory);
        consumePropsAndState();
        yield PropsMapViewOrFunctionComponentDeclaration(
          factory: factory,
          props: propsClassOrMixin,
        );
      }
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Handle leftover members that didn't get grouped into a declaration
  //
  // Where possible, attempt to provide helpful error messages.
  //

  final allUnusedMembers = [
    members.factories,
    members.props,
    members.states,
    members.components,
  ].expand((i) => i).whereNot(hasBeenConsumed);

  final unusedMembersByName = <String, List<BoilerplateMember>>{};
  for (var member in allUnusedMembers) {
    final name = normalizeNameAndRemoveSuffix(member);
    unusedMembersByName.putIfAbsent(name, () => []).add(member);
  }

  unusedMembersByName.forEach((name, group) {
    final factory = group.firstWhereType<BoilerplateFactory>(orElse: () => null);
    final propsClass = group.firstWhereType<BoilerplateProps>(orElse: () => null);
    final stateClass = group.firstWhereType<BoilerplateState>(orElse: () => null);
    final componentClass = group.firstWhereType<BoilerplateComponent>(orElse: () => null);

    //
    // Special cases

    final nonNullFactoryPropsOrComponents =
        [factory, propsClass, componentClass].whereNotNull().toList();
    if (nonNullFactoryPropsOrComponents.isEmpty) {
      assert(stateClass != null);
      if (resolveVersion([stateClass]).shouldGenerate) {
        errorCollector.addError(errorStateOnly, errorCollector.spanFor(stateClass.node));
      }
      return;
    }

    if (!resolveVersion(nonNullFactoryPropsOrComponents).shouldGenerate) return;
    switch (nonNullFactoryPropsOrComponents.length) {
      case 1:
        final single = nonNullFactoryPropsOrComponents.single;
        final span = errorCollector.spanFor(single.node);
        if (single == factory) {
          errorCollector.addError(errorFactoryOnly, span);
        } else if (single == propsClass) {
          errorCollector.addError(errorPropsClassOnly, span);
        } else if (single == componentClass) {
          errorCollector.addError(errorComponentClassOnly, span);
        }
        return;
      case 2:
        final span = errorCollector.spanFor((factory ?? propsClass).node);
        if (factory == null) {
          errorCollector.addError(errorNoFactory, span);
        } else if (propsClass == null) {
          errorCollector.addError(errorNoProps, span);
        } else if (componentClass == null) {
          errorCollector.addError(errorNoComponent, span);
        }
        return;
    }

    //
    // General case (should be rare if not impossible)
    for (var member in group) {
      errorCollector.addError(
          'Mismatched boilerplate member found', errorCollector.spanFor(member.node));
    }
  });
}

const errorStateOnly =
    'Could not find matching factory, props class, and component class in this file;'
    ' these are required to use UiState';

const errorFactoryOnly = 'Could not find matching props class in this file;'
    ' this is required to declare a props map view or function component,'
    ' and a component class is also required to declare a class-based component.';

const errorPropsClassOnly = 'Could not find matching factory in this file;'
    ' this is required to declare a props map view or function component,'
    ' and a component class is also required to declare a class-based component.';

const errorComponentClassOnly = 'Could not find matching factory and props class in this file;'
    ' these are required to declare a class-based component.';

const errorNoFactory = 'Could not find a matching factory in this file;'
    ' this is required to declare a component or props map view';

const errorNoProps = 'Could not find a matching props class in this file;'
    ' this is required to declare a component or props map view';

const errorNoComponent = 'Could not find a matching component class in this file;'
    ' this is required to declare a class-based component';
