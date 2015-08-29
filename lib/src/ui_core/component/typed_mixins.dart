/// Mixins for adding generic typed prop/state getters to components.
part of web_skin_dart.ui_core;

/// Mixin for easy use of generic typed props within a component.
/// Designed for MapView-like typed props that are backed by Maps.
abstract class TypedPropsGetter<TProps> extends Object {
  // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedPropsCache = new Expando();

  /// Create, or get from cache, a typed props object corresponding to the current props Map.
  TProps get tProps {
    TProps typedProps = _typedPropsCache[props];
    if (typedProps == null) {
      typedProps = typedPropsFactory(props);
      _typedPropsCache[props] = typedProps;
    }
    return typedProps;
  }

  /// The props that will be used to create the typed props object.
  /// react.Component subclasses will automatically implement this (via duck-typing).
  Map get props;

  /// Returns a typed props object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TProps typedPropsFactory(Map propsMap);

  /// Returns a typed props object backed by a new Map.
  /// Convenient for use with getDefaultProps.
  TProps newProps() => typedPropsFactory({});
}


/// Mixin for easy use of generic typed state within a component.
/// Designed for MapView-like typed state that are backed by Maps.
abstract class TypedStateGetter<TState> extends Object {
  // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedStateCache = new Expando();

  /// Create, or get from cache, a typed state object corresponding to the current state Map.
  TState get tState {
    TState typedState = _typedStateCache[state];
    if (typedState == null) {
      typedState = typedStateFactory(state);
      _typedStateCache[state] = typedState;
    }
    return typedState;
  }

  /// The state that will be used to create the typed state object.
  /// react.Component subclasses will automatically implement this (via duck-typing).
  Map get state;

  /// Returns a typed state object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TState typedStateFactory(Map stateMap);

  /// Returns a typed state object backed by a new Map.
  /// Convenient for use with getInitialState and setState.
  TState newState() => typedStateFactory({});
}
