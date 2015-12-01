library web_skin_dart.transformer_generation.helpers_sans_generation;

import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:web_skin_dart/ui_core.dart' show BaseComponent, BaseComponentWithState, ClassNameBuilder, ComponentDefinition, CssClassProps, CssClassPropsMixin, ReactProps, ReactPropsMixin, UbiquitousDomProps, UbiquitousDomPropsMixin, getProps, getPropsToForward, isDartComponent, isValidElement;

Expando<ReactDartComponentFactoryProxy> associatedReactComponentFactory = new Expando<ReactDartComponentFactoryProxy>();

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
    UiFactory builderFactory,
    Type componentClass,
    String displayName
}) {
  ReactDartComponentFactoryProxy reactComponentFactory = react.registerComponent(dartComponentFactory);

  if (isWrapper) {
    reactComponentFactory.reactClass['isWrapper'] = true;
  }
  if (displayName != null) {
    reactComponentFactory.reactClass['displayName'] = displayName;
  }
  if (builderFactory != null) {
    associatedReactComponentFactory[builderFactory] = reactComponentFactory;
  }
  if (componentClass != null) {
    associatedReactComponentFactory[componentClass] = reactComponentFactory;
  }

  return reactComponentFactory;
}

ReactComponentFactoryProxy getComponentFactory(dynamic type) {
  if (type is ReactComponentFactoryProxy) {
    return type;
  }

  return associatedReactComponentFactory[type];
}

/// Returns whether the [instance] was created using the React component factory associated with
/// [type], which can be a component's [UiFactory] or [UiComponent] [Type].
bool isComponentOfType(JsObject instance, dynamic type, {bool traverseWrappers: true}) {
  if (instance != null && type != null) {
    var factory = getComponentFactory(type);

    if (factory is ReactComponentFactoryProxy) {
      var instanceType = instance['type'];
      bool isWrapper = instanceType is JsFunction && instanceType['isWrapper'] == true;

      if (traverseWrappers && isWrapper) {
        // Should always be a Dart component if `isWrapper` true, this is just to make sure.
        assert(isDartComponent(instance));
        var children = getProps(instance)['children'];
        if (children != null && children.isNotEmpty) {
          return isComponentOfType(children.first, factory);
        } else {
          return false;
        }
      }

      return instanceType == factory.type;
    }
  }

  return false;
}

/// Returns whether the instance is a valid ReactElement and was created using the specified Dart factory
bool isValidElementOfType(dynamic instance, factory) {
  return isValidElement(instance) ? isComponentOfType(instance, factory) : false;
}


/// Generic builder factory typedef for use by all components.
typedef TBuilder UiFactory<TBuilder extends UiProps>([Map backingProps]);


/// The basis for a component, extending react.Component. (similar to BaseComponent)
abstract class UiComponent<TProps extends UiProps> extends react.Component
    implements BaseComponent<TProps> {
  /// The keys for the non-forwarding props defined in this component.
  Iterable<Iterable<String>> get consumedPropKeys => null;

  /// Returns a copy of this component's props with [consumedPropKeys] omitted.
  Map copyUnconsumedProps() {
    return copyProps(keySetsToOmit: consumedPropKeys);
  }

  /// Returns a copy of this component's props with React props optionally omitted, and
  /// with the specified [keysToOmit] and [keySetsToOmit] omitted.
  Map copyProps({bool omitReservedReactProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
    return getPropsToForward(this.props,
        omitReactProps: omitReservedReactProps,
        keysToOmit: keysToOmit,
        keySetsToOmit: keySetsToOmit
    );
  }

  /// Returns a new ClassNameBuilder with className and blacklist values added from [CssClassProps.className] and
  /// [CssClassProps.classNameBlackList], if they are specified.
  ///
  /// This method should be used as the basis for the classNames of components receiving forwarded props.
  ClassNameBuilder forwardingClassNameBuilder() {
    return new ClassNameBuilder.fromProps(this.props);
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

  /// DEPRECATED: Use [props] instead.
  ///
  /// A typed props object corresponding to the current untyped props Map ([unwrappedProps]).
  ///
  /// Created using [typedPropsFactory] and cached for each Map instance.
  @deprecated
  TProps get tProps => props;

  /// The props Map that will be used to create the typed [props] object.
  Map get unwrappedProps => super.props;

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


abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends UiComponent<TProps>
    implements BaseComponentWithState<TProps, TState> {
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

  /// DEPRECATED: Use [state] instead.
  ///
  /// A typed state object corresponding to the current untyped state Map ([unwrappedState]).
  ///
  /// Created using [typedStateFactory] and cached for each Map instance.
  @deprecated
  TState get tState => state;

  /// The state Map that will be used to create the typed [state] object.
  Map get unwrappedState => super.state;

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


abstract class UiState extends Object with StateMapViewMixin implements Map, MapViewMixin {}


/// Builder/MapView object, similar to ComponentDefinition.
///
/// Implements Map instead of extending it so that the abstract @props declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiProps
    extends Object with PropsMapViewMixin, ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin
    implements Map, MapViewMixin, ComponentDefinition {
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

  @deprecated
  @override
  bool validate() => true;

  /// Returns a new component with this builder's props and the specified children.
  JsObject build([dynamic children]) {
    return componentFactory(props, children);
  }

  /// Creates a new component with this builder's props and the specified [children]. (alias for [build])
  ///
  /// This method actually takes any number of children as arguments via [noSuchMethod].
  JsObject call([dynamic children]) => build(children);

  /// Supports variadic children of the form `call([child1, child2, child3...])`.
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call && invocation.isMethod) {
      var parameters = []
        ..add(props)
        ..addAll(invocation.positionalArguments);

      return Function.apply(componentFactory, parameters);
    }

    return super.noSuchMethod(invocation);
  }

  // To be implemented by code generation:
  Function get componentFactory;
  String get propKeyNamespace;
}

/// Works in conjunction with [MapViewMixin] to provide [dart.collection.MapView]-like
/// functionality to [UiProps] subclasses.
abstract class PropsMapViewMixin {
  /// The props maintained by this builder and used passed into the component when built.
  /// In this case, it's the current MapView object.
  Map get props;
  Map get _map => this.props;

  String toString() => '$runtimeType: $_map';
}

/// Works in conjunction with [MapViewMixin] to provide [dart.collection.MapView]-like
/// functionality to [UiState] subclasses.
abstract class StateMapViewMixin {
  Map get state;
  Map get _map => this.state;

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
