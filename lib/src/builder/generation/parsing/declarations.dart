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

  {
    final propsQueue = Queue.of(props);
    while (propsQueue.isNotEmpty) {
      final propsClass = propsQueue.removeFirst();
      final version = resolveVersion([propsClass]);
      switch (version) {
        case BoilerplateVersion.v2_legacyBackwardsCompat:
        case BoilerplateVersion.v3_legacyDart2Only:
          if (propsClass.node.hasAnnotationWithName('AbstractProps')) {
            props.remove(propsClass);
            yield LegacyAbstractClassComponentDeclaration(version: version, props: propsClass);
          }
          break;
        default:
      }
    }
    
    final stateQueue = Queue.of(states);
    while (stateQueue.isNotEmpty) {
      final stateClass = stateQueue.removeFirst();
      final version = resolveVersion([stateClass]);
      switch (version) {
        case BoilerplateVersion.v2_legacyBackwardsCompat:
        case BoilerplateVersion.v3_legacyDart2Only:
          if (stateClass.node.hasAnnotationWithName('AbstractState')) {
            states.remove(stateClass);
            yield LegacyAbstractClassComponentDeclaration(version: version, state: stateClass);
          }
          break;
        default:
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
      default:
        // null. Why?
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
        default:
          // null. Why?
      }
  }

  // Special-case handling: if there's only one component declared in the file,
  // and it's a legacy component, group the members together even if their names don't match.
  if (props.length == 1 && components.length == 1) {
    if (factories.length == 1) {
      final matchingFactory = factories.removeAt(0);
      final matchingProps = props.removeAt(0);
      final matchingState = states.length == 1 ? states.removeAt(0) : null;
      final matchingComponent = components.removeAt(0);

      final version = resolveVersion([
        matchingFactory,
        matchingProps,
        if (matchingState != null) matchingState,
        matchingComponent,
      ]);
      switch (version) {
        case BoilerplateVersion.v2_legacyBackwardsCompat:
        case BoilerplateVersion.v3_legacyDart2Only:
          yield LegacyClassComponentDeclaration(
            version: version,
            factory: matchingFactory,
            props: matchingProps,
            state: matchingState,
            component: matchingComponent,
          );
          break;
        default:
      }
    } else if (factories.isEmpty) {
      final matchingProps = props.removeAt(0);
      final matchingState = states.length == 1 ? states.removeAt(0) : null;
      final matchingComponent = components.removeAt(0);

      final version = resolveVersion([
        matchingProps,
        if (matchingState != null) matchingState,
        matchingComponent,
      ]);
      switch (version) {
        case BoilerplateVersion.v2_legacyBackwardsCompat:
        case BoilerplateVersion.v3_legacyDart2Only:
          yield LegacyAbstractClassComponentDeclaration(
            version: version,
            props: matchingProps,
            state: matchingState,
            component: matchingComponent,
          );
          break;
        default:
      }
    }
  }

  final unusedFactories = <FactoryGroup>[];

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
        final version = resolveVersion([factory, propsClassOrMixin.either]);
        switch (version) {
            case BoilerplateVersion.v2_legacyBackwardsCompat:
            case BoilerplateVersion.v3_legacyDart2Only:
              errorCollector.addError('Missing component for factory/props',
                  errorCollector.spanFor(factory.node));
              break;
            case BoilerplateVersion.v4_mixinBased:
              yield PropsMapViewDeclaration(
                  version: BoilerplateVersion.v4_mixinBased,
                  factory: factory, props: propsClassOrMixin);
              break;
            case BoilerplateVersion.noGenerate:
              break;
        }
      }
    }
  }

  // Use a queue since we want to mutate components during iteration
  final componentsQueue = Queue.of(components);
  while (componentsQueue.isNotEmpty) {
    final component = componentsQueue.removeFirst();

    final propsClass = getPropsFor(component, props, propsMixins)?.a;
    final stateClass = getStateFor(component, states, stateMixins)?.a;

    if (propsClass == null) continue;

    // don't remove mixins, just classes, since mixins are generated/grouped the same as when standalone
    props.remove(propsClass);
    states.remove(stateClass);

    components.remove(component);

    final version = resolveVersion([
      propsClass,
      component,
      if (stateClass != null) stateClass,
    ]);

    switch (version) {
      case BoilerplateVersion.noGenerate:
        // Do nothing because no code generation is warranted.
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        yield LegacyAbstractClassComponentDeclaration(
            version: version,
            component: component,
            props: propsClass,
            state: stateClass);
        break;
      case BoilerplateVersion.v4_mixinBased:
        // FIXME create AbstractClassComponentDeclaration
//        yield AbstractClassComponentDeclaration(
//            version: version,
//            component: component,
//            props: propsClassOrMixin,
//            state: stateClassOrMixin);
        break;
      default:
        // This case (null) is unlikely, but it means that none of the declarations actually seem like boilerplate.
        break;
    }
  }

  // Use a queue since we want to mutate props during iteration
  final propsQueue = Queue.of(props);
  while (propsQueue.isNotEmpty) {
    final props = propsQueue.removeFirst();
    final state = getStateFor(props, states, [])?.a;

    final version = resolveVersion([props, if (state != null) state]);
    switch (version) {
      case BoilerplateVersion.noGenerate:
        // Do nothing because no code generation is warranted.
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        if (props.node.hasAnnotationWithName('AbstractProps')) {
          yield LegacyAbstractClassComponentDeclaration(
              version: version,
              props: props,
              state: state);
        }
        break;
      case BoilerplateVersion.v4_mixinBased:
        // No need to do anything? Maybe perform validation that they're not doing something wrong?
        break;
      default:
        // This case (null) is unlikely, but it means that none of the declarations actually seem like boilerplate.
        break;
    }
  }

  // Ignore remaining components without matching factories and props classes or just props classes.
  // These are most likely classes that aren't really components.

  // TODO make sure declarationConfidence isn't above a certain threshold?
//  for (var component in components) {
//    final potentialFactory = fuzzyMatch(component, factories);
//    final potentialProps =
//        fuzzyMatch(component, [...props, ...propsMixins]);
//    errorCollector.addError(
//        'Component is missing factory/props: could it be referring to $potentialFactory/$potentialProps?',
//        errorCollector.spanFor(component.node.name));
//  }

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

  // TODO make sure declarationConfidence isn't above a certain threshold?
//  for (var propsClass in props) {
//    if (resolveVersion([propsClass]) == BoilerplateVersion.noGenerate) {
//      continue;
//    }
//    final potentialFactory = fuzzyMatch(propsClass, factories);
//    final potentialComponent = fuzzyMatch(propsClass, components);
//    errorCollector.addError(
//        'Props class is missing factory/component: $potentialFactory/$potentialComponent',
//        errorCollector.spanFor(propsClass.node));
//  }

  // todo when to fail for above cases vs just warn? When they reference generated code? When their "is boilerplate" confidence score is sufficiently high?

  // todo outside of this function, Validate boilerplateDecls, which validates individual items as well

  // old version
//  final factories, propsClasses, propsMixins, components;
  //
  //  final deduplicatedFactories = findRelatedFactories();
  //  for (var factory in deuplicatedFactories) {
  //    final propsClassOrMixin = getPropsFor(factory, propsClasses, propsMixins);
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
      !(initializer
              ?.tryCast<Identifier>()
              ?.name
              ?.startsWith(RegExp(r'[_\$]')) ??
          false);
}

bool isFunctionComponent(BoilerplateFactory factory) {
  return false;
}

AstNode fuzzyMatch(
    BoilerplateMember member, Iterable<BoilerplateMember> members) {
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
      errorCollector.addError('Legacy boilerplate components must be annotated with `@Component()` or `@Component2()`.',
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
  }) : assert((component ?? props ?? state) != null, 'Must provide component, props, or state'), super(version);

  @override
  void validate(ValidationErrorCollector errorCollector) {
    super.validate(errorCollector);

    if (component != null && !component.node.hasAnnotationWithNames({'AbstractComponent', 'AbstractComponent2'})) {
      errorCollector.addWarning('Legacy boilerplate abstract components should be annotated with `@AbstractComponent()` or `@AbstractComponent2()`.',
          errorCollector.spanFor(component.node));
    }

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (props != null && props.nodeHelper.members.isNotEmpty && !props.node.hasAnnotationWithName('AbstractProps')) {
      errorCollector.addError('Legacy boilerplate abstract props must be annotated with `@AbstractProps()`.',
          errorCollector.spanFor(props.node));
    }

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (state != null && state.nodeHelper.members.isNotEmpty && !state.node.hasAnnotationWithName('AbstractState')) {
      errorCollector.addError('Legacy boilerplate abstract state must be annotated with `@AbstractState()`.',
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
