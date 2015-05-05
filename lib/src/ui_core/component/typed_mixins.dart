/// Mixins for adding generic typed prop/state getters to components.
part of w_ui_platform.ui_core;

/// Mixin for easy use of generic typed props within a component.
/// Designed for MapView-like typed props that are backed by Maps.
abstract class TypedPropsGetter<P> extends Object {
  Expando<P> _typedPropsCache = new Expando<P>();

  /// Create, or get from cache, a typed props object corresponding to the current props Map.
  P get tProps {
    P typedProps = _typedPropsCache[props];
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
  P typedPropsFactory(Map propsMap);
}


/// Mixin for easy use of generic typed state within a component.
/// Designed for MapView-like typed state that are backed by Maps.
abstract class TypedStateGetter<P> extends Object {
  Expando<P> _typedStateCache = new Expando<P>();

  /// Create, or get from cache, a typed props object corresponding to the current state Map.
  P get tState {
    P typedState = _typedStateCache[state];
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
  P typedStateFactory(Map propsMap);
}
