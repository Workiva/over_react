import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import 'ast_util.dart';
import 'member_association.dart';
import 'members.dart';
import 'util.dart';
import 'validation.dart';
import 'version.dart';

final RegExp _maybeDeclarationPattern = RegExp(
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
  // Legacy abstract props/state/component classes
  //
  // They can be declared stand-alone without needing other abstract component members, so grouping
  // them isn't helpful, and can actually cause issues for edge cases where there are other
  // `noGenerate` members with similar names.
  //
  // So, we handle them individually, similarly to mixins.
  //
  // We also want to process and remove them before the special-case one-component-per-file
  // handling, since it's possible to declare a component with mismatched names as well as
  // an abstract component in the same file.
  //

  for (final propsClass in List.of(props)) {
    final version = resolveVersion([propsClass]);
    if (version.shouldGenerate &&
        version.version.isLegacy &&
        propsClass.node.hasAnnotationWithName('AbstractProps')) {
      props.remove(propsClass);
      yield LegacyAbstractPropsDeclaration(version: version.version, props: propsClass);
    }
  }

  for (final stateClass in List.of(states)) {
    final version = resolveVersion([stateClass]);
    if (version.shouldGenerate &&
        version.version.isLegacy &&
        stateClass.node.hasAnnotationWithName('AbstractState')) {
      states.remove(stateClass);
      yield LegacyAbstractStateDeclaration(version: version.version, state: stateClass);
    }
  }

  components.removeWhere((component) {
    final version = resolveVersion([component]);
    return version.version.isLegacy && component.node.hasAnnotationWithName('AbstractComponent');
  });

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
      yield PropsMixinDeclaration(version: version.version, mixin: propsMixin);
    }
  }

  for (var stateMixin in stateMixins) {
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

    final component = getComponentFor(factory, components);

    void consumeFactory() {
      factoryGroups.remove(factoryGroup);
      factoryGroup.factories.forEach(factories.remove);
    }

    void consumePropsAndState() {
      // don't remove mixins, just classes, since mixins are generated/grouped the same as when standalone
      props.remove(propsClassOrMixin.either);
      states.remove(stateClassOrMixin?.either);
    }

    void consumeComponent() => components.remove(component);

    if (component != null) {
      consumeFactory();
      consumePropsAndState();
      consumeComponent();

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
      if (isFunctionComponent(factory)) {
        consumeFactory();
        consumePropsAndState();
        yield FunctionComponentDeclaration(
          version: Version.v4_mixinBased,
          factory: factory,
          props: propsClassOrMixin,
        );
      } else {
        final version = resolveVersion([factory, propsClassOrMixin.either]);
        // The leftover logic below will handle legacy members
        if (version.shouldGenerate && version.version == Version.v4_mixinBased) {
          consumeFactory();
          consumePropsAndState();
          yield PropsMapViewDeclaration(
            version: Version.v4_mixinBased,
            factory: factory,
            props: propsClassOrMixin,
          );
        }
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
    factoryGroups.map((group) => group.bestFactory),
    props,
    states,
    components,
  ].expand((i) => i);

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
    // General case

    if ([factory, propsClass, stateClass, componentClass].whereNotNull().length != group.length) {
      for (var member in group) {
        errorCollector.addError(
            'Mismatched boilerplate member found', errorCollector.spanFor(member.node));
      }
      return;
    }

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
        break;
      case 2:
        final span = errorCollector.spanFor((factory ?? propsClass).node);
        if (factory == null) {
          errorCollector.addError(errorNoFactory, span);
        } else if (propsClass == null) {
          errorCollector.addError(errorNoProps, span);
        } else if (componentClass == null) {
          errorCollector.addError(errorNoComponent, span);
        }
        break;
    }
  });
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

/// The possible declaration types that the builder will look for.
enum DeclarationType {
  functionComponentDeclaration,
  classComponentDeclaration,
  legacyClassComponentDeclaration,
  legacyAbstractPropsDeclaration,
  legacyAbstractStateDeclaration,
  propsMixinDeclaration,
  stateMixinDeclaration,
  propsMapViewDeclaration,
}

abstract class BoilerplateDeclaration {
  final Version version;

  /// The explicit type of declaration this class is tied to.
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

class LegacyAbstractPropsDeclaration extends BoilerplateDeclaration {
  final BoilerplateProps props;

  @override
  get _members => [props];

  @override
  get type => DeclarationType.legacyAbstractPropsDeclaration;

  LegacyAbstractPropsDeclaration({
    @required Version version,
    @required this.props,
  }) : super(version);

  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (props.nodeHelper.members.isNotEmpty && !props.node.hasAnnotationWithName('AbstractProps')) {
      errorCollector.addError(
          'Legacy boilerplate abstract props must be annotated with `@AbstractProps()`.',
          errorCollector.spanFor(props.node));
    }
  }
}

class LegacyAbstractStateDeclaration extends BoilerplateDeclaration {
  final BoilerplateState state;

  @override
  get _members => [state];

  @override
  get type => DeclarationType.legacyAbstractStateDeclaration;

  LegacyAbstractStateDeclaration({
    @required Version version,
    @required this.state,
  }) : super(version);

  @override
  void validate(ErrorCollector errorCollector) {
    super.validate(errorCollector);

    // It's possible to declare an abstract class without any props/state fields that need to be generated.
    if (state.nodeHelper.members.isNotEmpty && !state.node.hasAnnotationWithName('AbstractState')) {
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

  List<Identifier> get allPropsMixins => props.switchCase(
        (a) => a.nodeHelper.mixins.map((name) => name.name).toList(),
        (b) => [b.name],
      );

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

mixin PropsOrStateMixinDeclaration on BoilerplateDeclaration {
  BoilerplatePropsOrStateMixin get mixin;

  @override
  get _members => [mixin];
}

class PropsMixinDeclaration extends BoilerplateDeclaration with PropsOrStateMixinDeclaration {
  @override
  final BoilerplatePropsMixin mixin;

  @override
  get type => DeclarationType.propsMixinDeclaration;

  PropsMixinDeclaration({
    @required Version version,
    @required this.mixin,
  }) : super(version);
}

class StateMixinDeclaration extends BoilerplateDeclaration with PropsOrStateMixinDeclaration {
  @override
  final BoilerplateStateMixin mixin;

  @override
  get type => DeclarationType.stateMixinDeclaration;

  StateMixinDeclaration({
    @required Version version,
    @required this.mixin,
  }) : super(version);
}

const errorStateOnly =
    'Could not find matching factory, props class, and component class in this file;'
    ' these are required to use UiState';

const errorFactoryOnly = 'Could not find matching component class and props class in this file;'
    ' these are required to declare a class-based component.';

const errorPropsClassOnly = 'Could not find matching factory and component class in this file;'
    ' these are required to declare a class-based component.';

const errorComponentClassOnly = 'Could not find matching factory and props class in this file;'
    ' these are required to declare a class-based component.';

const errorNoFactory = 'Could not find a matching factory in this file;'
    ' this is required to declare a class-based component';

const errorNoProps = 'Could not find a matching props class in this file;'
    ' this is required to declare a class-based component';

const errorNoComponent = 'Could not find a matching component class in this file;'
    ' this is required to declare a class-based component';
