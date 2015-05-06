/// Mixins for adding generic typed prop/state getters to components.
part of w_ui_platform.ui_core;

/// Mixin for easy use of generic typed props within a component.
/// Designed for MapView-like typed props that are backed by Maps.
abstract class TypedPropsGetter<TPropsMap> extends Object {
  // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedPropsCache = new Expando();

  /// Create, or get from cache, a typed props object corresponding to the current props Map.
  TPropsMap get tProps {
    TPropsMap typedProps = _typedPropsCache[props];
    if (typedProps == null) {
      typedProps = typedPropsFactory(props);
      _typedPropsCache[props] = typedProps;
    }
    return typedProps;
  }

  /// The props that will be used to create the typed props object.
  /// React.Component subclasses will automatically implement this (via duck-typing).
  Map get props;

  /// Returns a typed props object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TPropsMap typedPropsFactory(Map propsMap);

  TPropsMap newProps() => typedPropsFactory({});
}


/// Mixin for easy use of generic typed state within a component.
/// Designed for MapView-like typed state that are backed by Maps.
abstract class TypedStateGetter<TStateMap> extends Object {
  // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedStateCache = new Expando();

  /// Create, or get from cache, a typed props object corresponding to the current state Map.
  TStateMap get tState {
    TStateMap typedState = _typedStateCache[state];
    if (typedState == null) {
      typedState = typedStateFactory(state);
      _typedStateCache[state] = typedState;
    }
    return typedState;
  }

  /// The state that will be used to create the typed state object.
  /// React.Component subclasses will automatically implement this (via duck-typing).
  Map get state;

  /// Returns a typed props object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TStateMap typedStateFactory(Map stateMap);

  TStateMap newState() => typedStateFactory({});
}