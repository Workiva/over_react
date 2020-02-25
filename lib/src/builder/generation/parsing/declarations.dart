import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import 'ast_util.dart';
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

  for (var propsMixin in propsMixins) {
    yield PropsMixinDeclaration(version: resolveVersion([propsMixin]), propsMixin: propsMixin);
  }
  for (var stateMixin in stateMixins) {
    yield StateMixinDeclaration(version: resolveVersion([stateMixin]), stateMixin: stateMixin);
  }

  final unusedFactories = <FactoryGroup>[];

  // todo assume one component per file here, group if the counts are correct

  // ...

  // todo getPropsForFactories getComponent utils - what if there are multiple candidates?
  //  Do we just go with the first one, or do we use confidence scores? It's possible something could look like a component or props class

  // todo maybe just ditch factory groups and instead strip out non-best factories.
  // Use a queue since we want to mutate factories during iteration
  final factoryGroups = groupFactories(factories);
  final factoryGroupsQueue = Queue.of(factoryGroups);
  while (factoryGroupsQueue.isNotEmpty) {
    final factoryGroup = factoryGroupsQueue.removeFirst();
    final factory = factoryGroup.bestFactory;

    // fixme what about companion classes?
    final propsClassOrMixin = getPropsForFactory(factory, props, propsMixins);
    final stateClassOrMixin = getStateForFactory(factory, states, stateMixins);

    if (propsClassOrMixin == null) {
      // will be validated below the for-loop.
      continue;
    }

    factoryGroups.remove(factoryGroup);
    factoryGroup.factories.forEach(factories.remove);
    // don't remove mixins, just classes, since mixins are generated/grouped the same as when standalone
    props.remove(propsClassOrMixin.either);
    states.remove(stateClassOrMixin?.either);

    final component = getComponent(factory, propsClassOrMixin, components);
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
        default:
          // This case (null) is unlikely, but it means that none of the declarations actually seem like boilerplate.
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
            factory: factory, props: propsClassOrMixin);
      } else {
        final versions = resolveVersions([factory, propsClassOrMixin.either]);
        if (versions.contains(BoilerplateVersion.v4_mixinBased)) {
          yield PropsMapViewDeclaration(
              version: BoilerplateVersion.v4_mixinBased,
              factory: factory, props: propsClassOrMixin);
        } else {
          errorCollector.addError('Missing component for factory/props',
              errorCollector.spanFor(factory.node));
        }
      }
    }
  }

  for (var component in components) {
    final potentialFactory = fuzzyMatch(component, factories);
    final potentialProps =
        fuzzyMatch(component, [...props, ...propsMixins]);
    errorCollector.addError(
        'Component is missing factory/props: could it be referring to $potentialFactory/$potentialProps?',
        errorCollector.spanFor(component.node.name));
  }

  for (var factoryGroup in factoryGroups) {
    if (isStandaloneFactory(factoryGroup.bestFactory)) {
      continue;
    }

    final potentialProps = fuzzyMatch(factoryGroup.bestFactory, [...props, ...propsMixins]);
    errorCollector.addError('Factory is missing props: $potentialProps');
  }

  for (var propsClass in props) {
    final potentialFactory = fuzzyMatch(propsClass, factories);
    final potentialComponent = fuzzyMatch(propsClass, components);
    errorCollector.addError(
        'Props class is missing factory/component: $potentialFactory/$potentialComponent');
  }

  // todo when to fail for above cases vs just warn? When they reference generated code? When their "is boilerplate" confidence score is sufficiently high?

  // todo outside of this function, Validate boilerplateDecls, which validates individual items as well

  // old version
//  final factories, propsClasses, propsMixins, components;
  //
  //  final deduplicatedFactories = findRelatedFactories();
  //  for (var factory in deuplicatedFactories) {
  //    final propsClassOrMixin = getPropsForFactory(factory, propsClasses, propsMixins);
  //    propsClasses.remove(propsClassOrMixin);
  //    final propsImplInfo = generatePropsImpl(propsClassOrMixin);
  //
  //    final component = getComponent(factory, propsClassOrMixin);
  //    if (component != null) {
  //      components.remove(component);
  //      generateComponentImpl(component, propsImplInfo);
  //      generateComponentFactoryProxy(component, propsImplInfo);
  //    } else {
  //      // Props MapViews and Function components, also bad components?
  //      generateThrowingComponentFactoryProxy();
  //    }
  //  }
  //
  //  for (var factory in propsMixins) {
  //  }
}

Union<BoilerplateProps, BoilerplatePropsMixin> getPropsForFactory(
  BoilerplateFactory factory,
  Iterable<BoilerplateProps> props,
  Iterable<BoilerplatePropsMixin> propsMixins,
) {
  final name = factory.node.variables.variables.first.name.name
      .replaceAll(RegExp(r'^[_$]*'), '');
  final expectedPropsName = '${name}Props';
  final expectedPropsMixinName = '${name}PropsMixin';

  final matchingProps = props.firstWhere(
      (element) =>
          element.node.name.name == expectedPropsName ||
          element.node.name.name == expectedPropsMixinName,
      orElse: () => null);
  if (matchingProps != null) return Union.a(matchingProps);

  final matchingPropsMixin = propsMixins.firstWhere(
      (element) =>
          element.node.name.name == expectedPropsName ||
          element.node.name.name == expectedPropsMixinName,
      orElse: () => null);
  if (matchingPropsMixin != null) return Union.b(matchingPropsMixin);

  return null;
}

Union<BoilerplateState, BoilerplateStateMixin> getStateForFactory(
  BoilerplateFactory factory,
  Iterable<BoilerplateState> states,
  Iterable<BoilerplateStateMixin> stateMixins,
) {
  final name =
      factory.node.firstVariable.name.name.replaceAll(RegExp(r'^[_$]*'), '');
  final expectedPropsName = '${name}Props';
  final expectedPropsMixinName = '${name}PropsMixin';

  final matchingState = states.firstWhere(
      (element) => element.node.name.name == expectedPropsName,
      orElse: () => null);
  if (matchingState != null) return Union.a(matchingState);

  final matchingStateMixin = stateMixins.firstWhere(
      (element) =>
          element.node.name.name == expectedPropsName ||
          element.node.name.name == expectedPropsMixinName,
      orElse: () => null);
  if (matchingStateMixin != null) return Union.b(matchingStateMixin);

  return null;
}

BoilerplateComponent getComponent(
  BoilerplateFactory factory,
  Union<BoilerplateProps, BoilerplatePropsMixin> propsClassOrMixin,
  List<BoilerplateComponent> components,
) {
  final name =
      factory.node.firstVariable.name.name.replaceAll(RegExp(r'^[_$]*'), '');
  return components.firstWhere(
      (component) => component.node.name.name == '${name}Component',
      orElse: () => null);
}

class FactoryGroup {
  final List<BoilerplateFactory> factories;

  FactoryGroup(this.factories);

  BoilerplateFactory get bestFactory {
    if (factories.length == 1) return factories[0];

    final factoriesInitializedToIdentifier = factories
        .where((factory) => factory.node.firstInitializer is Identifier)
        .toList();
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
    final typeName = factory.node.variables.type?.typeNameWithoutPrefix;
    factoriesByType.putIfAbsent(typeName, () => []).add(factory);
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
      !(initializer
              ?.tryCast<Identifier>()
              ?.name
              ?.startsWith(RegExp(r'[_\$]')) ??
          false);
}

bool isFunctionComponent(BoilerplateFactory factory) {
  //todo implement
}

CompilationUnitMember fuzzyMatch(
    BoilerplateMember member, Iterable<BoilerplateMember> members) {
  // todo implement
  return members.firstOrNull?.node;
}

class BoilerplateGenerator {}

abstract class BoilerplateDeclaration {
  final BoilerplateVersion version;

  BoilerplateDeclaration(this.version);

  void validate(ValidationErrorCollector errorCollector) {
    if (version == null) {
      // This should almost never happen.
      errorCollector.addError('Could not determine boilerplate version.',
          errorCollector.spanFor(_members.first.node));
      return;
    }

    for (var member in _members) {
      member.validate(version, errorCollector);
    }
  }

  BoilerplateGenerator get generator => null;

  Iterable<BoilerplateMember> get _members;
}

class LegacyClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final BoilerplateProps props;
  final BoilerplateState state;

  bool get isComponent2 => component.hasComponent2Annotation;

  @override
  get _members => [factory, component, props, state];

  LegacyClassComponentDeclaration({
    @required BoilerplateVersion version,
    @required this.factory,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);
}

class LegacyAbstractClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateComponent component;
  final BoilerplateProps props;
  final BoilerplateState state;

  @override
  get _members => [component, props, state];

  LegacyAbstractClassComponentDeclaration({
    @required BoilerplateVersion version,
    @required this.component,
    @required this.props,
    this.state,
  }) : super(version);
}

class ClassComponentDeclaration extends BoilerplateDeclaration {
  final BoilerplateFactory factory;
  final BoilerplateComponent component;
  final Union<BoilerplateProps, BoilerplatePropsMixin> props;
  final Union<BoilerplateState, BoilerplateStateMixin> state;

  @override
  get _members => [factory, component, props.either, state.either];

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
