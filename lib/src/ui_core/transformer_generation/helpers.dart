library web_skin_dart.transformer_generation.helpers;

import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:web_skin_dart/ui_core.dart' show ClassNameBuilder, ReactProps, UbiquitousDomProps, getPropsToForward, isValidElement;

export './annotations.dart';

Expando<ReactDartComponentFactoryProxy> generatedBuilderToReactComponentFactory = new Expando<ReactDartComponentFactoryProxy>();

ReactDartComponentFactoryProxy registerComponent(UiComponent componentFactory(), {
    UiFactory builderFactory
}) {
  var reactComponentFactory = react.registerComponent(componentFactory);

  if (builderFactory != null) {
    generatedBuilderToReactComponentFactory[builderFactory] = reactComponentFactory;
  }

  return reactComponentFactory;
}

bool isValidComponentOfType_experimental(dynamic component, UiFactory type) {
  if (isValidElement(component)) {
    var reactFactory = generatedBuilderToReactComponentFactory[type];
    if (reactFactory != null) {
      return reactFactory.type == (component as JsObject)['type'];
    }
  }

  return false;
}

/// Placeholder helper class that allows for accessing lists of prop keys
/// in a static yet unsafe way.
///
/// __For advanced usage only.__
@proxy
class $PropKeys implements List<String> {
  const $PropKeys(Symbol propsClass);

  dynamic noSuchMethod(Invocation invocation) {
    throw r'The $PropKeys class should not be used at runtime, '
          r'but should be replaced with a list via the transformer.';
  }
}


/// Generic builder factory typedef for use by all components.
typedef TBuilder UiFactory<TBuilder extends UiProps>([Map backingProps]);


/// The basis for a component, extending react.Component. (similar to BaseComponent)
abstract class UiComponent<TProps extends UiProps> extends react.Component with FriendlyTypeName {
  /// The keys for the non-forwarding props defined in this component.
  Iterable<Iterable<String>> get consumedPropKeys => const [];

  Map forwardUnconsumedProps() {
    return copyProps(keySetsToOmit: consumedPropKeys);
  }

  //
  // Helpers from BaseComponent that would most likely be in their own class...

  /// Utility function used for prop transfer
  Map copyProps({bool omitReservedReactProps: true, Iterable keysToOmit, Iterable<Iterable> keySetsToOmit}) {
    return getPropsToForward(this.props,
        omitReactProps: omitReservedReactProps,
        keysToOmit: keysToOmit,
        keySetsToOmit: keySetsToOmit
    );
  }
//
//  Iterable<dynamic> get iterateChildren {
//    return childrenIterable(props.children);
//  }

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

  /// Create, or get from cache, a typed props object corresponding to the current props Map.
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

  /// Use [props] instead;
  @deprecated
  TProps get tProps => props;

  /// The props Map that will be used to create the typed props object.
  Map get unwrappedProps => super.props;

  /// Returns a typed props object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TProps typedPropsFactory(Map propsMap);

  /// Returns a typed props object backed by a new Map.
  /// Convenient for use with getDefaultProps.
  TProps newProps() => typedPropsFactory({});

  //
  //   END Typed props helpers
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
}

abstract class UiStatefulComponent<TProps extends UiProps, TState extends UiState>
    extends UiComponent<TProps> {

  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  //   BEGIN Typed state helpers
  //

   // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedStateCache = new Expando();

  /// Create, or get from cache, a typed state object corresponding to the current state Map.
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

  /// Use [state] instead;
  @deprecated
  TState get tState => state;

  /// The state Map that will be used to create the typed state object.
  Map get unwrappedState => super.state;

  /// Returns a typed state object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TState typedStateFactory(Map stateMap);

  /// Returns a typed state object backed by a new Map.
  /// Convenient for use with getInitialState and setState.
  TState newState() => typedStateFactory({});

  //
  //   END Typed state helpers
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
}

abstract class UiState extends Object with FriendlyTypeName, StateMapViewMixin implements Map, MapViewMixin {}


/// Builder/MapView object, similar to ComponentDefinition.
///
/// Implements Map instead of extending it so that the abstract @props declarations
/// don't need a constructor. The generated implementations can mix that functionality in.
abstract class UiProps extends Object with FriendlyTypeName, PropsMapViewMixin, ReactProps, UbiquitousDomProps implements Map, MapViewMixin {
  /// Add an arbitrary prop key-value pair.
  void addProp(propKey, value) {
    props[propKey] = value;
  }

  /// Add a Map of arbitrary props.
  void addProps(Map propMap) {
    props.addAll(propMap);
  }

  /// Default method for component validation. (Called in checked mode only, during [build].)
  bool validate() {
    return true;
  }

  /// Create a new component with this builder's props and the specified children.
  JsObject build([dynamic children]) {
    return componentFactory(props, children);
  }

  /// Create a new component with this builder's props and the specified children. (alias for [build])
  JsObject call([dynamic children]) => build(children);

  // To be implemented by code generation:
  Function get componentFactory;
  String get propKeyNamespace;
}

abstract class PropsMapViewMixin {
  /// The props maintained by this builder and used passed into the component when built.
  /// In this case, it's the current MapView object.
  Map get props;
  Map get _map => this.props;

  String toString() => '$runtimeType: $_map';
}

abstract class StateMapViewMixin {
  Map get state;
  Map get _map => this.state;

  String toString() => '$runtimeType: $_map';
}

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
//  String toString() => _map.toString();
  Iterable<V> get values => _map.values;
}

abstract class FriendlyTypeName {
  /// The "friendly" type name of this class, to be used for debugging
  /// instead of the generated implementation class's name.
  ///
  /// The generated code will override this, but for now, stub with the current class's name.
  String get friendlyTypeName => '$runtimeType';
}
