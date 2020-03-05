import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import 'ast_util.dart';
import 'member_association.dart';
import 'members.dart';
import 'util.dart';
import 'validation.dart';
import 'version.dart';

final RegExp _maybeDeclarationPattern = RegExp(
    // todo is this necessary?
    r'\.over_react\.g\.dart'
            // Legacy components (annotation required)
            r'|@(?:' +
        [
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
        ].join('|') +
        r')'
            // New components (references to props base classes required);
            // find other base classes for validation purposes
            r'|Ui(?:Factory|Props|Component|State)',
    caseSensitive: true);

bool mightContainDeclarations(String source) {
  return _maybeDeclarationPattern.hasMatch(source);
}

Iterable<BoilerplateDeclaration> getBoilerplateDeclarations(
    BoilerplateMembers members, ErrorCollector errorCollector) sync* {
  if (members.isEmpty) return;

  final factories = members.factories;
  final props = members.props;
  final propsMixins = members.propsMixins;
  final components = members.components;
  final states = members.states;
  final stateMixins = members.stateMixins;

  // -----------------------------------------------------------------------------------------------
  //
  // Legacy abstract props/state classes
  //
  // They can be declared stand-alone without needing other abstract component members, so grouping
  // them isn't helpful, and can actually cause issues for edge cases where there are other
  // `noGenerate` members with similar names.
  //
  // So, we handle them individually, similarly to mixins.
  //

  for (final propsClass in List.of(props)) {
    final version = resolveVersion([propsClass]);
    if (version.shouldGenerate && version.version.isLegacy && propsClass.node.hasAnnotationWithName('AbstractProps')) {
      props.remove(propsClass);
      yield LegacyAbstractClassComponentDeclaration(version: version.version, props: propsClass);
    }
  }

  for (final stateClass in List.of(states)) {
    final version = resolveVersion([stateClass]);
    if (version.shouldGenerate && version.version.isLegacy && stateClass.node.hasAnnotationWithName('AbstractState')) {
      states.remove(stateClass);
      yield LegacyAbstractClassComponentDeclaration(version: version.version, state: stateClass);
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Props/state mixins
  //
  // Don't remove them from the list so that they can be associated with any components
  // that use them in the shorthand syntax.
  //

  for (var propsMixin in propsMixins) {
    final version = resolveVersion([propsMixin]);
    if (version.shouldGenerate) {
      yield PropsMixinDeclaration(version: version.version, propsMixin: propsMixin);
    }
  }

  for (var stateMixin in stateMixins) {
    final version = resolveVersion([stateMixin]);
    if (version.shouldGenerate) {
      yield StateMixinDeclaration(version: version.version, stateMixin: stateMixin);
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Special-case handling: if there's only one component declared in the file,
  // and it's a legacy component, group the members together even if their names don't match.
  //
  // This is to prevent regressing these cases when switching to the new parser, since the old one
  // was name-agnostic and expected at most one non-abstract component per file.
  // FIXME do we need to remove abstract components before this point, to support a single file with both an abstract component and component?

  if (props.length == 1 && components.length == 1 && factories.length == 1 && states.length <= 1) {
    final version = resolveVersion([
      props.single,
      if (states.isNotEmpty) states.single,
      components.single,
      factories.single,
    ]);
    if (version.shouldGenerate && version.version.isLegacy) {
      yield LegacyClassComponentDeclaration(
        version: version.version,
        factory: factories.removeAt(0),
        props: props.removeAt(0),
        state: states.isNotEmpty ? states.removeAt(0) : null,
        component: components.removeAt(0),
      );
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Declarations with factories (components and non-legacy map views)
  //

  final unusedFactories = <FactoryGroup>[];

  // todo getPropsForFactories getComponent utils - what if there are multiple candidates?
  //  Do we just go with the first one, or do we use confidence scores? It's possible something could look like a component or props class

  // todo maybe just ditch factory groups and instead strip out non-best factories.
  final factoryGroups = groupFactories(factories);
  for (final factoryGroup in List.of(factoryGroups)) {
    final factory = factoryGroup.bestFactory;

    final propsClassOrMixin = getPropsFor(factory, props, propsMixins);
    final stateClassOrMixin = getStateFor(factory, states, stateMixins);

    if (propsClassOrMixin == null) {
      // will be validated below the for-loop.
      continue;
    }

    factoryGroups.remove(factoryGroup);
    factoryGroup.factories.forEach(factories.remove);
    // don't remove mixins, just classes, since mixins are generated/grouped the same as when standalone
    props.remove(propsClassOrMixin.either);
    states.remove(stateClassOrMixin?.either);

    final component = getComponentFor(factory, components);
    if (component != null) {
      components.remove(component);

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
                version: version.version,
                factory: factory,
                component: component,
                props: propsClassOrMixin,
                state: stateClassOrMixin);
            break;
        }
      }
    } else {
      if (propsClassOrMixin == null) {
        unusedFactories.add(factoryGroup);
        continue;
      }

      if (isFunctionComponent(factory)) {
        yield FunctionComponentDeclaration(
          version: Version.v4_mixinBased,
          factory: factory,
          props: propsClassOrMixin,
        );
      } else {
        final version = resolveVersion([factory, propsClassOrMixin.either]);
        if (version.shouldGenerate) {
          switch (version.version) {
            case Version.v2_legacyBackwardsCompat:
            case Version.v3_legacyDart2Only:
              errorCollector.addError(
                  'Missing component for factory/props', errorCollector.spanFor(factory.node));
              break;
            case Version.v4_mixinBased:
              yield PropsMapViewDeclaration(
                version: Version.v4_mixinBased,
                factory: factory,
                props: propsClassOrMixin,
              );
              break;
          }
        }
      }
    }
  }

  // -----------------------------------------------------------------------------------------------
  //
  // Handle leftover members that didn't get grouped into a declaration
  //

  // Ignore remaining components without matching factories and props classes or just props classes.
  // TODO should these warn if their declarationConfidence/versionConfidence is sufficiently high?
  // These are most likely classes that aren't really components.
  for (var factoryGroup in factoryGroups) {
    if (!resolveVersion([factoryGroup.bestFactory]).shouldGenerate) {
      continue;
    }
    if (isStandaloneFactory(factoryGroup.bestFactory)) {
      continue;
    }

    final potentialProps = fuzzyMatch(factoryGroup.bestFactory, [...props, ...propsMixins]);
    errorCollector.addError('Factory is missing props; did you mean $potentialProps?',
        errorCollector.spanFor(factoryGroup.bestFactory.node));
  }

  // Put em back in boilerplateMembers so we can log them outside of this function
  factories.addAll(unusedFactories.expand((group) => group.factories));

  for (var propsClass in props) {
    if (!resolveVersion([propsClass]).shouldGenerate) continue;
    errorCollector.addError('Props class is missing factory.', errorCollector.spanFor(propsClass.node));
  }
  for (var stateClass in states) {
    if (!resolveVersion([stateClass]).shouldGenerate) continue;
    errorCollector.addError('State class is missing factory and/or component.', errorCollector.spanFor(stateClass.node));
  }
  for (var componentClass in components) {
    if (!resolveVersion([componentClass]).shouldGenerate) continue;
    errorCollector.addError('componentClass class is missing factory and/or props.', errorCollector.spanFor(componentClass.node));
  }
}

class FactoryGroup {
  final List<BoilerplateFactory> factories;

  FactoryGroup(this.factories);

  BoilerplateFactory get bestFactory {
    if (factories.length == 1) return factories[0];

    final factoriesInitializedToIdentifier =
        factories.where((factory) => factory.node.firstInitializer is Identifier).toList();
    if (factoriesInitializedToIdentifier.length == 1) {
      return factoriesInitializedToIdentifier.first;
    }

    // fixme other cases
    return factories[0];
  }
}

List<FactoryGroup> groupFactories(Iterable<BoilerplateFactory> factories) {
  var factoriesByType = <String, List<BoilerplateFactory>>{};

  for (var factory in factories) {
    final typeString = factory.node.variables.type?.toSource();
    factoriesByType.putIfAbsent(typeString, () => []).add(factory);
  }

  final groups = <FactoryGroup>[];
  factoriesByType.forEach((key, value) {
    if (key == null) {
      groups.addAll(value.map((factory) => FactoryGroup([factory])));
    } else {
      groups.add(FactoryGroup(value));
    }
  });
  return groups;
}

bool isStandaloneFactory(BoilerplateFactory factory) {
  final initializer = factory.node.firstInitializer;
  return initializer != null &&
      !(initializer?.tryCast<Identifier>()?.name?.startsWith(RegExp(r'[_\$]')) ?? false);
}

bool isFunctionComponent(BoilerplateFactory factory) {
  return false;
}

AstNode fuzzyMatch(BoilerplateMember member, Iterable<BoilerplateMember> members) {
  // todo implement
  var match = members.firstOrNull?.node;

  if (match == null) return null;
  if (match is NamedCompilationUnitMember) return match.name;
  if (match is TopLevelVariableDeclaration) return match.firstVariable.name;

  throw StateError('This codepath should never be hit');
}

class BoilerplateGenerator {}

enum DeclarationType {
  functionComponentDeclaration,
  classComponentDeclaration,
  legacyClassComponentDeclaration,
  legacyAbstractClassComponentDeclaration,
  propsMixinDeclaration,
  stateMixinDeclaration,
  propsMapViewDeclaration,
}

abstract class BoilerplateDeclaration {
  final Version version;
  DeclarationType type;

  BoilerplateDeclaration(this.version);

  Iterable<BoilerplateMember> get members => _members;

  void validate(ErrorCollector errorCollector) {
    if (version == null) {
      // This should almost never happen.
      errorCollector.addError(
          'Could not determine boilerplate version.', errorCollector.spanFor(_members.first.node));
      return;
    }

    for (var member in _members) {
      member.validate(version, errorCollector);
    }
  }

  BoilerplateGenerator get generator => null;

  Iterable<BoilerplateMember> get _members;

  @override
  String toString() => '${super.toString()} (${_members.map((m) => m.name.name)})';
}

class LegacyClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final BoilerplateProps props;
  final BoilerplateState state;

  bool get isComponent2 => component.isComponent2(version);

  @override
  get _members => [factory, component, props, if (state != null) state];

  @override
  get type => DeclarationType.legacyClassComponentDeclaration;

  LegacyClassComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);

  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    if (!component.node.hasAnnotationWithNames({'Component', 'Component2'})) {
      errorCollector.addError(
          'Legacy boilerplate components must be annotated with `@Component()` or `@Component2()`.',
          errorCollector.spanFor(component.node));
    }

    if (!props.node.hasAnnotationWithNames({'Props'})) {
      errorCollector.addError('Legacy boilerplate props classes must be annotated with `@Props()`.',
          errorCollector.spanFor(props.node));
    }

    if (state != null && !state.node.hasAnnotationWithNames({'State'})) {
      errorCollector.addError('Legacy boilerplate state classes must be annotated with `@State()`.',
          errorCollector.spanFor(state.node));
    }
  }
}

// TODO split this out into LegacyAbstractPropsDeclaration and LegacyAbstractStateDeclaration
class LegacyAbstractClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateComponent component;
  final BoilerplateProps props;
  final BoilerplateState state;

  @override
  get _members => [component, props, state].whereNotNull();

  @override
  final type = DeclarationType.legacyAbstractClassComponentDeclaration;

  LegacyAbstractClassComponentDeclaration({
    @required Version version,
    this.component,
    this.props,
    this.state,
  })  : assert((component ?? props ?? state) != null, 'Must provide component, props, or state'),
        super(version);

  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    if (component != null &&
        !component.node.hasAnnotationWithNames({'AbstractComponent', 'AbstractComponent2'})) {
      errorCollector.addWarning(
          'Legacy boilerplate abstract components should be annotated with `@AbstractComponent()` or `@AbstractComponent2()`.',
          errorCollector.spanFor(component.node));
    }

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (props != null &&
        props.nodeHelper.members.isNotEmpty &&
        !props.node.hasAnnotationWithName('AbstractProps')) {
      errorCollector.addError(
          'Legacy boilerplate abstract props must be annotated with `@AbstractProps()`.',
          errorCollector.spanFor(props.node));
    }

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (state != null &&
        state.nodeHelper.members.isNotEmpty &&
        !state.node.hasAnnotationWithName('AbstractState')) {
      errorCollector.addError(
          'Legacy boilerplate abstract state must be annotated with `@AbstractState()`.',
          errorCollector.spanFor(state.node));
    }
  }
}

class ClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final Union<BoilerplateProps, BoilerplatePropsMixin> props;
  final Union<BoilerplateState, BoilerplateStateMixin> state;

  @override
  get _members => [factory, component, props.either, if (state != null) state?.either];

  @override
  get type => DeclarationType.classComponentDeclaration;

  ClassComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);
}

// todo how to tell between these two?

class PropsMapViewDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;

  final Union<BoilerplateProps, BoilerplatePropsMixin> props;

  @override
  get _members => [factory, props.either];

  @override
  get type => DeclarationType.propsMapViewDeclaration;

  PropsMapViewDeclaration({
    @required Version version,
    @required this.factory,
    @required this.props,
  }) : super(version);
}

class FunctionComponentDeclaration extends BoilerplateDeclaration {
  // will it even have this?
  final BoilerplateFactory factory;

  // will have only one of these
  final Union<BoilerplateProps, BoilerplatePropsMixin> props;

  @override
  get _members => [factory, props.either];

  @override
  get type => DeclarationType.functionComponentDeclaration;

  FunctionComponentDeclaration({
    @required Version version,
    @required this.factory,
    @required this.props,
  }) : super(version);
}

class PropsMixinDeclaration extends BoilerplateDeclaration {
  final BoilerplatePropsMixin propsMixin;

  @override
  get _members => [propsMixin];

  @override
  get type => DeclarationType.propsMixinDeclaration;

  PropsMixinDeclaration({
    @required Version version,
    @required this.propsMixin,
  }) : super(version);
}

class StateMixinDeclaration extends BoilerplateDeclaration {
  final BoilerplateStateMixin stateMixin;

  @override
  get _members => [stateMixin];

  @override
  get type => DeclarationType.stateMixinDeclaration;

  StateMixinDeclaration({
    @required Version version,
    @required this.stateMixin,
  }) : super(version);
}
