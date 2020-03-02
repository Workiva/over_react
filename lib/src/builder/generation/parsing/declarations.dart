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
    BoilerplateMembers members, ValidationErrorCollector errorCollector) sync* {
  if (members.isEmpty) return;

  final factories = members.factories;
  final props = members.props;
  final propsMixins = members.propsMixins;
  final components = members.components;
  final states = members.states;
  final stateMixins = members.stateMixins;

  // Remove legacy map views so they don't get grouped with anything else and throw things off.
  props.removeWhere((p) => p.isLegacyMapView);

  for (final propsClass in List.of(props)) {
    final version = resolveVersion([propsClass]);
    if (version.isLegacy) {
      if (propsClass.node.hasAnnotationWithName('AbstractProps')) {
        props.remove(propsClass);
        yield LegacyAbstractClassComponentDeclaration(version: version, props: propsClass);
      }
    }
  }

  for (final stateClass in List.of(states)) {
    final version = resolveVersion([stateClass]);
    if (version.isLegacy) {
      if (stateClass.node.hasAnnotationWithName('AbstractState')) {
        states.remove(stateClass);
        yield LegacyAbstractClassComponentDeclaration(version: version, state: stateClass);
      }
    }
  }

  for (var propsMixin in propsMixins) {
    final version = resolveVersion([propsMixin]);
    switch (version) {
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
      case BoilerplateVersion.v4_mixinBased:
        yield PropsMixinDeclaration(version: version, propsMixin: propsMixin);
        break;
      case BoilerplateVersion.noGenerate:
        break;
    }
  }

  for (var stateMixin in stateMixins) {
    final version = resolveVersion([stateMixin]);
    switch (version) {
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
      case BoilerplateVersion.v4_mixinBased:
        yield StateMixinDeclaration(version: version, stateMixin: stateMixin);
        break;
      case BoilerplateVersion.noGenerate:
        break;
    }
  }

  // Special-case handling: if there's only one component declared in the file,
  // and it's a legacy component, group the members together even if their names don't match.
  if (props.length == 1 && components.length == 1 && factories.length == 1) {
    final version = resolveVersion([
      props.single,
      if (states.length == 1) states.single,
      components.single,
      factories.single,
    ]);
    if (version.isLegacy) {
      yield LegacyClassComponentDeclaration(
        version: version,
        factory: factories.removeAt(0),
        props: props.removeAt(0),
        state: states.length == 1 ? states.removeAt(0) : null,
        component: components.removeAt(0),
      );
    }
  }

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

      switch (version) {
        case BoilerplateVersion.v2_legacyBackwardsCompat:
        case BoilerplateVersion.v3_legacyDart2Only:
          yield LegacyClassComponentDeclaration(
              version: version,
              factory: factory,
              component: component,
              props: propsClassOrMixin.a,
              state: stateClassOrMixin?.a);
          break;
        case BoilerplateVersion.v4_mixinBased:
          yield ClassComponentDeclaration(
              version: version,
              factory: factory,
              component: component,
              props: propsClassOrMixin,
              state: stateClassOrMixin);
          break;
        case BoilerplateVersion.noGenerate:
          break;
      }
    } else {
      if (propsClassOrMixin == null) {
        unusedFactories.add(factoryGroup);
        continue;
      }

      if (isFunctionComponent(factory)) {
        yield FunctionComponentDeclaration(
          version: BoilerplateVersion.v4_mixinBased,
          factory: factory,
          props: propsClassOrMixin,
        );
      } else {
        final version = resolveVersion([factory, propsClassOrMixin.either]);
        switch (version) {
          case BoilerplateVersion.v2_legacyBackwardsCompat:
          case BoilerplateVersion.v3_legacyDart2Only:
            errorCollector.addError(
                'Missing component for factory/props', errorCollector.spanFor(factory.node));
            break;
          case BoilerplateVersion.v4_mixinBased:
            yield PropsMapViewDeclaration(
              version: BoilerplateVersion.v4_mixinBased,
              factory: factory,
              props: propsClassOrMixin,
            );
            break;
          case BoilerplateVersion.noGenerate:
            break;
        }
      }
    }
  }

  // Ignore remaining components without matching factories and props classes or just props classes.
  // TODO should these warn if their declarationConfidence/versionConfidence is sufficiently high?
  // These are most likely classes that aren't really components.
  for (var factoryGroup in factoryGroups) {
    if (resolveVersion([factoryGroup.bestFactory]) == BoilerplateVersion.noGenerate) {
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

abstract class BoilerplateDeclaration {
  final BoilerplateVersion version;

  BoilerplateDeclaration(this.version);

  Iterable<BoilerplateMember> get members => _members;

  void validate(ValidationErrorCollector errorCollector) {
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

  LegacyClassComponentDeclaration({
    @required BoilerplateVersion version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);

  @override
  void validate(ValidationErrorCollector errorCollector) {
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

  LegacyAbstractClassComponentDeclaration({
    @required BoilerplateVersion version,
    this.component,
    this.props,
    this.state,
  })  : assert((component ?? props ?? state) != null, 'Must provide component, props, or state'),
        super(version);

  @override
  void validate(ValidationErrorCollector errorCollector) {
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

  ClassComponentDeclaration({
    @required BoilerplateVersion version,
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

  PropsMapViewDeclaration({
    @required BoilerplateVersion version,
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

  FunctionComponentDeclaration({
    @required BoilerplateVersion version,
    @required this.factory,
    @required this.props,
  }) : super(version);
}

class PropsMixinDeclaration extends BoilerplateDeclaration {
  final BoilerplatePropsMixin propsMixin;

  @override
  get _members => [propsMixin];

  PropsMixinDeclaration({
    @required BoilerplateVersion version,
    @required this.propsMixin,
  }) : super(version);
}

class StateMixinDeclaration extends BoilerplateDeclaration {
  final BoilerplateStateMixin stateMixin;

  @override
  get _members => [stateMixin];

  StateMixinDeclaration({
    @required BoilerplateVersion version,
    @required this.stateMixin,
  }) : super(version);
}
