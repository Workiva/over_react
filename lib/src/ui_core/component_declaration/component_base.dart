library web_skin_dart.component_declaration.component_base;

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_type_checking.dart';
import 'package:web_skin_dart/ui_core.dart' show
    ClassNameBuilder,
    CssClassPropsMixin,
    ReactPropsMixin,
    UbiquitousDomPropsMixin,
    getPropsToForward,
    DummyComponent,
    ValidationUtil,
    unindent,
    PropError;

export 'package:web_skin_dart/src/ui_core/component_declaration/component_type_checking.dart' show isComponentOfType, isValidElementOfType;

/// Helper function that wraps react.registerComponent, and allows attachment of additional
/// component factory metadata.
///
/// * [isWrapper]: whether the component clones or passes through its children and needs to be
/// treated as if it were the wrapped component.
///
/// * [builderFactory]/[componentClass]: the [UiFactory] and [UiComponent] members to be potentially
/// used as types for [isComponentOfType]/[getComponentFactory].
///
/// * [displayName]: the name of the component for use when debugging.
ReactDartComponentFactoryProxy registerComponent(react.Component dartComponentFactory(), {
    bool isWrapper: false,
    ReactDartComponentFactoryProxy parentType,
    UiFactory builderFactory,
    Type componentClass,
    String displayName
}) {
  ReactDartComponentFactoryProxy reactComponentFactory = react.registerComponent(dartComponentFactory);

  if (displayName != null) {
    reactComponentFactory.reactClass.displayName = displayName;
  }

  registerComponentTypeAlias(reactComponentFactory, builderFactory);
  registerComponentTypeAlias(reactComponentFactory, componentClass);

  setComponentTypeMeta(reactComponentFactory, isWrapper: isWrapper, parentType: parentType);

  return reactComponentFactory;
}

/// Helper function that wraps [registerComponent], and allows an easier way to register abstract components with the
/// main purpose of type-checking against the abstract component.
///
/// __The result must be stored in a variable that is named very specifically:__
///
///     var $`AbstractComponentClassName`Factory = registerAbstractComponent(`AbstractComponentClassName`);
ReactDartComponentFactoryProxy registerAbstractComponent(Type abstractComponentClass, {ReactDartComponentFactoryProxy parentType}) =>
    registerComponent(() => new DummyComponent(), componentClass: abstractComponentClass, parentType: parentType);

/// A function that returns a new [TProps] instance, optionally backed by the specified [backingProps].
///
/// For use in wrapping existing Maps in typed getters and setters, and for creating React components
/// via a fluent-style builder interface.
typedef TProps UiFactory<TProps extends UiProps>([Map backingProps]);

/// A utility variation on [UiFactory], __without__ a `backingProps` parameter.
///
/// I.e., a function that takes no parameters and returns a new [TProps] instance backed by a new, empty Map.
///
/// For use as a Function variable type when the `backingProps` argument is not required.
typedef TProps BuilderOnlyUiFactory<TProps extends UiProps>();

typedef dynamic _RefTypedef(String ref);

/// The basis for a web_skin_dart component, extending [react.Component]. (Successor to [BaseComponent]).
///
/// Includes support for strongly-typed props and utilities for prop and CSS classname forwarding.
abstract class UiComponent<TProps extends UiProps> extends react.Component {
  /// Returns the component of the specified [ref].
  /// > `react.Component` if it is a Dart component
  /// > DOM node if it is a DOM component.
  ///
  /// Overridden for strong typing.
  @override
  _RefTypedef get ref => super.ref;

  /// The props for the non-forwarding props defined in this component.
  Iterable<ConsumedProps> get consumedProps => null;

  /// Returns a copy of this component's props with [consumedPropKeys] omitted.
  Map copyUnconsumedProps() {
    var consumedPropKeys = consumedProps?.map((ConsumedProps consumedProps) => consumedProps.keys) ?? const [];

    return copyProps(keySetsToOmit: consumedPropKeys);
  }

  /// Returns a copy of this component's props with [consumedPropKeys] and non-DOM props omitted.
  Map copyUnconsumedDomProps() {
    var consumedPropKeys = consumedProps?.map((ConsumedProps consumedProps) => consumedProps.keys) ?? const [];

    return copyProps(onlyCopyDomProps: true, keySetsToOmit: consumedPropKeys);
  }

  /// Returns a copy of this component's props with React props optionally omitted, and
  /// with the specified [keysToOmit] and [keySetsToOmit] omitted.
  Map copyProps({bool omitReservedReactProps: true, bool onlyCopyDomProps: false, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
    return getPropsToForward(this.props,
        omitReactProps: omitReservedReactProps,
        onlyCopyDomProps: onlyCopyDomProps,
        keysToOmit: keysToOmit,
        keySetsToOmit: keySetsToOmit
    );
  }

  void validateRequiredProps(Map appliedProps) {
    consumedProps?.forEach((ConsumedProps consumedProps) {
      consumedProps.props.forEach((PropDescriptor prop) {
            if (!prop.isRequired) return;
            if (prop.isNullable && appliedProps.containsKey(prop.key)) return;
            if (!prop.isNullable && appliedProps[prop.key] != null) return;

            throw new PropError.required(prop.key, prop.errorMessage);
          });
    });
  }

  /// Returns a new ClassNameBuilder with className and blacklist values added from [CssClassProps.className] and
  /// [CssClassProps.classNameBlackList], if they are specified.
  ///
  /// This method should be used as the basis for the classNames of components receiving forwarded props.
  ClassNameBuilder forwardingClassNameBuilder() {
    return new ClassNameBuilder.fromProps(this.props);
  }

  @override
  void componentWillReceiveProps(Map newProps) {
    validateRequiredProps(newProps);
  }

  @override
  void componentWillMount() {
    validateRequiredProps(props);
  }


  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  //   BEGIN Typed props helpers
  //

  // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedPropsCache = new Expando();

  /// A typed props object corresponding to the current untyped props Map ([unwrappedProps]).
  ///
  /// Created using [typedPropsFactory] and cached for each Map instance.
  @override
  TProps get props {
    var unwrappedProps = this.unwrappedProps;
    TProps typedProps = _typedPropsCache[unwrappedProps];
    if (typedProps == null) {
      typedProps = typedPropsFactory(unwrappedProps);
      _typedPropsCache[unwrappedProps] = typedProps;
    }
    return typedProps;
  }
  /// Equivalent to setting [unwrappedProps], but needed by react-dart to effect props changes.
  @override
  set props(Map value) => super.props = value;

  /// The props Map that will be used to create the typed [props] object.
  Map get unwrappedProps => super.props;
  set unwrappedProps(Map value) => super.props = value;

  /// Returns a typed props object backed by the specified [propsMap].
  /// Required to properly instantiate the generic [TProps] class.
  TProps typedPropsFactory(Map propsMap);

  /// Returns a typed props object backed by a new Map.
  /// Convenient for use with [getDefaultProps].
  TProps newProps() => typedPropsFactory({});

  //
  //   END Typed props helpers
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
}

/// The basis for a stateful web_skin_dart component, extending [react.Component]. (Successor to [BaseComponentWithState]).
///
/// Includes support for strongly-typed props and state and utilities for prop and CSS classname forwarding.
abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState> extends UiComponent<TProps> {
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  //   BEGIN Typed state helpers
  //

   // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedStateCache = new Expando();

  /// A typed state object corresponding to the current untyped state Map ([unwrappedState]).
  ///
  /// Created using [typedStateFactory] and cached for each Map instance.
  @override
  TState get state {
    var unwrappedState = this.unwrappedState;
    TState typedState = _typedStateCache[unwrappedState];
    if (typedState == null) {
      typedState = typedStateFactory(unwrappedState);
      _typedStateCache[unwrappedState] = typedState;
    }
    return typedState;
  }
  /// Equivalent to setting [unwrappedState], but needed by react-dart to effect props changes.
  @override
  set state(Map value) => super.state = value;

  /// The state Map that will be used to create the typed [state] object.
  Map get unwrappedState => super.state;
  set unwrappedState(Map value) => super.state = value;

  /// Returns a typed state object backed by the specified [stateMap].
  /// Required to properly instantiate the generic [TState] class.
  TState typedStateFactory(Map stateMap);

  /// Returns a typed state object backed by a new Map.
  /// Convenient for use with [getInitialState] and [setState].
  TState newState() => typedStateFactory({});

  //
  //   END Typed state helpers
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
}


/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React state.
///
/// Note: Implements MapViewMixin instead of extending it so that the abstract [State] declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiState extends Object with MapViewMixin, StateMapViewMixin implements Map {}

/// The string used by default for the key of the attribute added by [UiProps.addTestId].
const defaultTestIdKey = 'data-test-id';

/// Enforces that a function take a single parameter of type [Map].
///
/// Used in [UiProps.modifyProps].
typedef PropsModifier(Map props);

/// A [dart.collection.MapView]-like class with strongly-typed getters/setters for React props that
/// is also capable of creating React component instances.
///
/// For use as a typed view into existing props [Maps], or as a builder to create new component
/// instances via a fluent-style interface.
///
/// Note: Implements MapViewMixin instead of extending it so that the abstract [Props] declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiProps
    extends Object with MapViewMixin, PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin
    implements Map {
  /// Adds an arbitrary prop key-value pair.
  void addProp(propKey, value) {
    props[propKey] = value;
  }

  /// Adds a Map of arbitrary props. [props] may be null.
  void addProps(Map propMap) {
    if (propMap == null) {
      return;
    }

    props.addAll(propMap);
  }

  /// Allows [modifier] to alter this instance of props.
  void modifyProps(PropsModifier modifier){
    if (modifier == null) return;

    modifier(this);
  }

  /// Whether [UiProps] is in a testing environment.
  static bool testMode = false;

  /// Whether [UiProps] is in a testing environment at build time.
  static const bool _testModeFromEnvironment = const bool.fromEnvironment('testing');

  /// Whether [UiProps] is in a testing environment at build time or otherwise.
  ///
  /// Used in [addTestId].
  ///
  /// TODO: Only use bool.fromEnvironment() when it is supported in Dartium.
  /// See: <https://github.com/dart-lang/pub/issues/798>.
  bool get _inTestMode => testMode || _testModeFromEnvironment;

  /// Adds [value] to the prop [key] for use in a testing environment by using space-delimiting.
  ///
  /// Allows for an element to have multiple test IDs to prevent overwriting when cloning elements or components.
  void addTestId(String value, {String key: defaultTestIdKey}) {
    if (!_inTestMode || value == null) {
      return;
    }

    String testId = getTestId(key: key);

    if (testId == null) {
      props[key] = value;
    } else {
      props[key] = getTestId(key: key) + ' $value';
    }
  }

  /// Gets the `data-test-id` prop or one testId from the prop (or custom [key] prop value) for use in a testing
  /// environment.
  String getTestId({String key: defaultTestIdKey}) {
    return props[key];
  }

  /// Gets the `data-test-id` prop key to [value] for use in a testing environment.
  @Deprecated('2.0.0')
  String get testId {
    return getTestId();
  }

  /// Returns a new component with this builder's props and the specified children.
  ReactElement build([dynamic children]) {
    assert(_validateChildren(children));

    return componentFactory(props, children);
  }

  /// Creates a new component with this builder's props and the specified [children].
  /// (alias for [build] with support for variadic children)
  ///
  /// This method actually takes any number of children as arguments ([c2], [c3], ...) via [noSuchMethod].
  ///
  /// Restricted statically to 40 arguments until the dart2js fix in
  /// <https://github.com/dart-lang/sdk/pull/26032> is released.
  ReactElement call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);

  /// Supports variadic children of the form `call([child1, child2, child3...])`.
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call && invocation.isMethod) {
      var parameters = []
        ..add(props)
        ..addAll(invocation.positionalArguments);

      assert(() {
        // These checks are within the assert so they are not done in production.
        var children = invocation.positionalArguments;

        if (children.length == 1) {
          children = children.single;
        }

        return _validateChildren(children);
      });

      return Function.apply(componentFactory, parameters);
    }

    return super.noSuchMethod(invocation);
  }

  /// Validates that no [children] are instances of [UiProps], and prints a helpful message for a better debugging
  /// experiance.
  bool _validateChildren(dynamic children) {
    // Should not validate non-list iterables to avoid more than one iteration.
    if (children != null && (children is! Iterable || children is List)) {
      if (children is! List) {
        children = [children];
      }

      if (children.any((child) => child is UiProps)) {
        var errorMessage = unindent(
            '''
            It looks like you are trying to use a non-invoked builder as a child. That is an invalid use of UiProps, try
            invoking the builder before passing it as a child.
            '''
        );

        // TODO: Remove ValidationUtil.warn call when https://github.com/dart-lang/sdk/issues/26093 is resolved.
        ValidationUtil.warn(errorMessage);
        throw new ArgumentError(errorMessage);
      }
    }

    return true;
  }

  Function get componentFactory;
}

/// Works in conjunction with [MapViewMixin] to provide [dart.collection.MapView]-like
/// functionality to [UiProps] subclasses.
abstract class PropsMapViewMixin {
  /// The props maintained by this builder and used passed into the component when built.
  /// In this case, it's the current MapView object.
  Map get props;
  Map get _map => this.props;

  @override
  String toString() => '$runtimeType: $_map';
}

/// Works in conjunction with [MapViewMixin] to provide [dart.collection.MapView]-like
/// functionality to [UiState] subclasses.
abstract class StateMapViewMixin {
  Map get state;
  Map get _map => this.state;

  @override
  String toString() => '$runtimeType: $_map';
}

/// Provides [dart.collection.MapView]-like behavior by proxying an internal map.
///
/// Works in conjunction with [PropsMapViewMixin] and [StateMapViewMixin] to implement [Map]
/// in [UiProps] and [UiState] subclasses.
///
/// For use by concrete [UiProps] and [UiState] implementations (either generated or manual),
/// and thus must remain public.
abstract class MapViewMixin<K, V> {
  Map<K, V> get _map;

  V operator[](Object key) => _map[key];
  void operator[]=(K key, V value) { _map[key] = value; }
  void addAll(Map<K, V> other) { _map.addAll(other); }
  void clear() { _map.clear(); }
  V putIfAbsent(K key, V ifAbsent()) => _map.putIfAbsent(key, ifAbsent);
  bool containsKey(Object key) => _map.containsKey(key);
  bool containsValue(Object value) => _map.containsValue(value);
  void forEach(void action(K key, V value)) { _map.forEach(action); }
  bool get isEmpty => _map.isEmpty;
  bool get isNotEmpty => _map.isNotEmpty;
  int get length => _map.length;
  Iterable<K> get keys => _map.keys;
  V remove(Object key) => _map.remove(key);
  Iterable<V> get values => _map.values;
}

/// Provides a representation of a single `prop`.
class PropDescriptor {
  /// The string key associated with the `prop`.
  final String key;
  /// Whether the `prop` is required to be set.
  final bool isRequired;
  /// Whether setting the `prop` to `null` is valid.
  final bool isNullable;
  /// The message included in the thrown [PropError] if the `prop` is not set.
  final String errorMessage;

  const PropDescriptor(this.key, {this.isRequired: false, this.isNullable: false, this.errorMessage: ''});
}

/// Provides a representation of a single `state`.
class StateDescriptor {
  /// The string key associated with the `state`.
  final String key;
  /// Whether the `state` is required to be set.
  ///
  /// __Currently not used.__
  final bool isRequired;
  /// Whether setting the `state` to `null` is valid.
  ///
  /// __Currently not used.__
  final bool isNullable;
  /// The message included in the thrown error if the `state` is not set.
  ///
  /// __Currently not used.__
  final String errorMessage;

  const StateDescriptor(this.key, {this.isRequired: false, this.isNullable: false, this.errorMessage});
}

/// Provides a list of [PropDescriptor] and a top-level list of their keys, for easy access.
class ConsumedProps {
  /// Rich views of props.
  ///
  /// This includes string keys, and required prop validation related fields.
  final List<PropDescriptor> props;
  /// Top-level acessor of string keys of props stored in [props].
  final List<String> keys;

  const ConsumedProps(this.props, this.keys);
}
