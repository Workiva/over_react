import 'dart:async';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux.dart' as flux;

import 'value_mutation_checker.dart';

part 'over_react_flux.over_react.g.dart';

@PropsMixin(keyNamespace: '')
abstract class _$ConnectFluxPropsMixin<TActions> implements UiProps {
  @override
  Map get props;

  TActions actions;
}

/// The actions that are associated with a given [InfluxStoreMixin] store
/// during the construction of a [FluxToReduxAdapterStore].
@visibleForTesting
final Expando<dynamic> actionsForStore = Expando();

/// The [ConnectFluxAdapterStore]'s that are associated with a given [flux.Store]
/// when `FluxStoreExtension.asConnectFluxStore` is called.
final Expando<ConnectFluxAdapterStore> _connectFluxAdapterFor = Expando();

/// The [FluxToReduxAdapterStore]'s that are associated with a given [flux.Store]
/// when `InfluxStoreExtension.asReduxStore` is called.
final Expando<FluxToReduxAdapterStore> _storeAdapterFor = Expando();

/// The action used to keep Redux in sync with Flux when using a [FluxToReduxAdapterStore].
class _FluxStoreUpdatedAction {
  const _FluxStoreUpdatedAction();
}

/// A class that can be used to make a [flux.Store] compatible with [connectFlux]
/// without adding the Redux implementation.
///
/// The usage is the same as [connectFlux] with the [FluxToReduxAdapterStore],
/// but does not have the infrastructure for Redux `dispatch`ing.
///
/// __Note:__ Because this adapter store does not have a real Redux reducer,
/// a `connected` component cannot trigger actions. If the library in the position to
/// have Redux components, this class should not be used (implementing
/// [FluxToReduxAdapterStore] instead) and the Redux boilerplate should be added.
/// If needed, however, a `connect`ed component can receive updates from
/// this implementation (just not trigger them).
///
/// __Example:__
/// ```dart
/// import 'package:w_flux/w_flux.dart' as flux;
///
/// class ExampleFluxStore extends flux.Store {
///   FluxActions _actions
///
///   String _valueFromState = 'Default Value';
///   String get valueFromState => _valueFromState;
///
///   ExampleFluxStore(this._actions) {
///     triggerOnActionV2(_actions.fluxAction, _mutateValueFromState);
///   }
///
///   void _mutateValueFromState(String newValue) {
///     _valueFromState = newValue;
///   }
/// }
///
/// class FluxActions {
///   final flux.Action<String> changeBackgroundColor = flux.Action();
/// }
///
/// FluxActions actions = FluxActions();
/// ExampleFluxStore store = ExampleFluxStore(actions);
///
/// ConnectFluxAdapterStore adapterStore = ConnectFluxAdapterStore<ExampleFluxStore, Null>(store, actions);
/// ```
///
/// Related: [connectFlux], [FluxToReduxAdapterStore]
class ConnectFluxAdapterStore<S extends flux.Store> extends redux.Store<S> {
  /// A reference to an instantiated Flux store object that backs the adapter store.
  ///
  /// This store instance is the actual container of all store data, with the
  /// [ConnectFluxAdapterStore] acting as an interface to connect to the store.
  /// Unlike a [FluxToReduxAdapterStore], updates to the store should come from Flux.
  final S store;

  StreamSubscription _storeListener;

  ConnectFluxAdapterStore(this.store, dynamic actions,
      {List<redux.Middleware<S>> middleware})
      : super((_, __) => store,
      middleware: middleware ?? const [],
      initialState: store,
      distinct: false) {
    assert(store is! InfluxStoreMixin,
    'Use FluxToReduxAdapterStore when your store implements InfluxStoreMixin');

    _storeListener = store.listen((_) {
      dispatch(_FluxStoreUpdatedAction());
    });

    actionsForStore[store] = actions;
  }

  @override
  Future teardown() async {
    await _storeListener.cancel();
    await super.teardown();
  }
}

/// Adapts a Flux store to the interface of a Redux store.
///
/// When using an Influx architecture, this store allows Redux, Flux, and [connectFlux]
/// components to stay in sync with each other.
///
/// __Example:__
/// ```dart
/// // Declare a Flux store as normal, and mix in InfluxStoreMixin..
/// class ExampleStore extends Store with InfluxStoreMixin { ... }
///
/// // Instantiate your Flux actions and store as normal.
/// var actions = ExampleActions();
/// var store = ExampleStore(actions);
///
/// // Wrap them in the adapter store.
/// //
/// // Redux and `connectFlux` components should reference this store directly,
/// // whereas Flux components can reference the `store` instance.
/// var adapterStore = FluxToReduxAdapterStore(store, actions);
/// ```
///
/// > Related: [InfluxStoreMixin]
class FluxToReduxAdapterStore<S extends InfluxStoreMixin>
    extends redux.Store<S> {
  /// A reference to an instantiated Flux store object that backs the adapter store.
  ///
  /// This store instance is the actual container of all store data, with the
  /// [FluxToReduxAdapterStore] acting as an interface to connect to and update
  /// that store (though it can be updated directly using Flux outside the scope
  /// of the adapter).
  final S store;

  StreamSubscription _storeListener;

  FluxToReduxAdapterStore(this.store, dynamic actions,
      {List<redux.Middleware<S>> middleware})
      : super((_, action) {
          store.influxReducer(action);
          return store;
        },
            middleware: middleware ?? const [],
            initialState: store,
            distinct: false) {
    _storeListener = store.listen((_) {
      store._triggerReduxUpdateFromFlux(dispatch);
    });

    actionsForStore[store] = actions;
  }

  @override
  Future teardown() async {
    await _storeListener.cancel();
    await super.teardown();
  }
}

/// A mixin that adds the fields necessary to make a Flux store compatible with the
/// Influx architecture.
///
/// The mixin enforces the pattern necessary for an Influx architecture by adding
/// the `influxReducer` and `triggerReduxUpdateFromFlux`, while also exposing the
/// `state` field that is backed by a Redux state class. To make the store compatible
/// with Redux, the Flux store using the [InfluxStoreMixin] should be wrapped
/// with a [FluxToReduxAdapterStore].
///
/// __Example:__
/// ```dart
/// import 'package:w_flux/w_flux_server.dart' as flux;
///
/// class ExampleFluxStore extends flux.Store with InfluxStoreMixin<ReduxState> {
///   FluxActions _actions
///
///   @override
///   get reduxReducer => exampleReducer;
///
///   String get valueFromState => state.valueFromState;
///
///   ExampleFluxStore(this._actions) {
///     state = ReduxState('default state');
///
///     triggerOnActionV2(_actions.fluxAction,
///         () => this.influxReducer(ReduxAction('New Value')));
///   }
///
/// }
///
/// class ReduxAction {
///   String value;
///
///   ReduxAction(this.value);
/// }
///
/// class ReduxState {
///   String valueFromState;
///
///   ReduxState(this.valueFromState);
/// }
///
/// ReduxState exampleReducer(ReduxState oldState, Object action) {
///   if (action is ReduxAction) return ReduxState(action.value);
///
///   return oldState;
/// }
/// ```
mixin InfluxStoreMixin<S> on flux.Store {
  /// A traditional Redux reducer function that should return a new instance of
  /// the corresponding state class.
  ///
  /// This is used in [influxReducer] to update the [state] field before triggering
  /// an update.
  redux.Reducer<S> get reduxReducer;

  /// An instance of the Redux state model that the Flux store is migrating to.
  S state;

  /// A field to track if Flux has already tried to update Redux.
  bool _isReduxInSync = false;

  /// Checks to see if the Redux store needs to be updated and triggers an action
  /// if so.
  ///
  /// This is only to be used from within the [FluxToReduxAdapterStore] to control
  /// when Redux needs to receive an update to keep it in sync with Flux.
  void _triggerReduxUpdateFromFlux(Dispatcher dispatcher) {
    if (_isReduxInSync) {
      _isReduxInSync = false;
      return;
    }

    dispatcher(_FluxStoreUpdatedAction());
  }

  /// A wrapper around a pure Redux reducer that keeps the Flux UI up to date with
  /// store changes.
  void influxReducer(dynamic action) {
    if (action is _FluxStoreUpdatedAction) {
      _isReduxInSync = true;
      return;
    }

    this.state = reduxReducer(this.state, action);
    this.trigger();
  }
}

bool _shallowMapEquality(Map a, Map b) => const MapEquality().equals(a, b);

/// A wrapper around the `connect` function that provides a similar API into a Flux store.
///
/// This is primarily for use while transitioning _to_ `connect` and OverReact Redux.
///
/// __NOTE:__ Unlike `connect`, there is no `areStatesEqual` parameter due to the state
/// update process being impure. It is impure because it involves modification of
/// the store itself, as opposed to creating a new state object with each change.
///
/// __Example:__
/// ```dart
/// UiFactory<CounterProps> ConnectedCounter = connectFlux<FluxStore, FluxActions, CounterProps>(
///     mapStateToProps: (state) => (
///       Counter()..count = state.count
///     ),
///     mapActionsToProps: (actions) => (
///       Counter()..increment = actions.incrementAction
///     ),
/// )(Counter);
///
/// // A standard `Counter` component implementation would also be in this file.
/// ```
///
/// - [mapStateToProps] is used for selecting the part of the data from the store that the connected
///  component needs.
///  - It is called every time the store state changes.
///  - It receives the entire store state, and should return an object of data this component needs.
/// If you need access to the props provided to the connected component you can use [mapStateToPropsWithOwnProps],
/// the second argument will be `ownProps`.
/// See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
///
/// - [mapActionsToProps] is a way to connect local component props to actions that are part of the
///  provided actions class.
///
/// Unlike `mapDispatchToProps` with `connect`, [mapActionsToProps] will be called whenever the store state
/// changes.
///
/// In practice, the most common usage is to set the relevant component action props directly by setting
/// them equal to the corresponding action within the action class. If you need access to the props provided
/// to the connected component you can use [mapActionsToPropsWithOwnProps], the second argument will be `ownProps`.
///
/// - [mergeProps] if specified, defines how the final props for the wrapped component are determined.
/// If you do not provide [mergeProps], the wrapped component receives {...ownProps, ...stateProps, ...dispatchProps}
/// by default.
///
/// - [areOwnPropsEqual] does a shallow Map equality check by default.
/// - [areStatePropsEqual] does a shallow Map equality check by default.
/// - [areMergedPropsEqual] does a shallow Map equality check by default.
///
/// - [context] can be utilized to provide a custom context object created with `createContext`.
/// [context] is how you can utilize multiple stores. While supported, this is not recommended.
/// See: <https://redux.js.org/api/store#a-note-for-flux-users>
/// See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>
///
/// __Example:__
/// ```dart
/// import 'package:over_react/react_dom.dart' as react_dom;
///
/// Store store1 = Store<CounterState>(counterStateReducer, initialState: CounterState(count: 0));
/// Store store2 = Store<BigCounterState>(bigCounterStateReducer, initialState: BigCounterState(bigCount: 100));
///
/// UiFactory<CounterProps> ConnectedCounter = connectFlux<SmallCounterFluxStore, FluxActions, CounterProps>(
///   mapStateToProps: (state) => (Counter()..count = state.count)
/// )(Counter);
///
/// UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterFluxStore, FluxActions, CounterProps>(
///   mapStateToProps: (state) => (Counter()..count = state.bigCount),
///   context: bigCounterContext,
/// )(Counter);
///
/// react_dom.render(
///   Dom.div()(
///     (ReduxProvider()..store = store1)(
///       (ReduxProvider()
///         ..store = store2
///         ..context = bigCounterContext
///       )(
///         Dom.div()(
///           Dom.h3()('ConnectedBigCounter Store2'),
///           ConnectedBigCounter()(
///             Dom.h4()('ConnectedCounter Store1'),
///             ConnectedCounter()(),
///           ),
///         ),
///       ),
///     ),
///   ), querySelector('#content')
/// );
/// ```
///
/// - [pure] if `true` (default), connect performs several equality checks that are used to avoid unnecessary
/// calls to [mapStateToProps], [mapActionsToProps], [mergeProps], and ultimately to `render`. These include
/// [areOwnPropsEqual], [areStatePropsEqual], and [areMergedPropsEqual].
/// While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
/// implementations for performance or other reasons.
///
/// - [forwardRef] if `true`, the `ref` prop provided to the connected component will be return the wrapped component.
///
/// For more info see the <https://github.com/Workiva/over_react/blob/master/doc/flux_to_redux.md>.
UiFactory<TProps> Function(UiFactory<TProps>)
    connectFlux<TStore extends flux.Store, TActions, TProps extends UiProps>({
  Map Function(TStore state) mapStateToProps,
  Map Function(TStore state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(TActions actions) mapActionsToProps,
  Map Function(TActions actions, TProps ownProps) mapActionsToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps)
      mergeProps,
  bool Function(TProps nextProps, TProps prevProps) areOwnPropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areStatePropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areMergedPropsEqual,
  Context context,
  bool pure = true,
  bool forwardRef = false,
}) {
  // Because of the complex relationship between actions and state, it should be
  // enforced that a consumer cannot set both `...toProps` and the `withOwnProps`
  // variants.
  //
  // Down stream, `...toProps` is defaulted to in this situation anyway, but at this level,
  // allowing both can cause unnecessary complexity in decision logic.
  if (mapStateToProps != null && mapStateToPropsWithOwnProps != null) {
    throw ArgumentError(
        'Both mapStateToProps and mapStateToPropsWithOwnProps cannot be set at the same time.');
  }

  if (mapActionsToProps != null && mapActionsToPropsWithOwnProps != null) {
    throw ArgumentError(
        'Both mapActionsToProps and mapActionsToPropsWithOwnProps cannot be set at the same time.');
  }

  /*--Boolean variables used for creating more complex logic statements--*/
  final mapActionsToPropsNeedsToBeWrapped = mapActionsToProps != null;
  final mapStateToPropsNeedsToBeWrapped = mapStateToProps != null;
  final mapActionsWithOwnPropsNeedsToBeWrapped =
      mapActionsToPropsWithOwnProps != null;
  final mapStateWithOwnPropsNeedsToBeWrapped =
      mapStateToPropsWithOwnProps != null;

  final noActionsNeedToBeWrapped = !mapActionsToPropsNeedsToBeWrapped &&
      !mapActionsWithOwnPropsNeedsToBeWrapped;
  final noStateNeedsToBeWrapped =
      !mapStateToPropsNeedsToBeWrapped && !mapStateWithOwnPropsNeedsToBeWrapped;

  /*--Boolean variables that represent the possible cases for wrapping parameter functions--*/
  /// Wrap mapStateToProps only
  final case1 = mapStateToPropsNeedsToBeWrapped && noActionsNeedToBeWrapped;

  /// Wrap mapStateToPropsWithOwnProps only
  final case2 =
      mapStateWithOwnPropsNeedsToBeWrapped && noActionsNeedToBeWrapped;

  /// Wrap mapActionsToProps with mapStateToProps
  final case3 =
      mapStateToPropsNeedsToBeWrapped && mapActionsToPropsNeedsToBeWrapped;

  /// Wrap mapActionsToProps only
  final case4 = mapActionsToPropsNeedsToBeWrapped && noStateNeedsToBeWrapped;

  /// Wrap mapStateToPropsWithOwnProps and mapActionsToPropsWithOwnProps
  final case5 = mapActionsWithOwnPropsNeedsToBeWrapped &&
      mapStateWithOwnPropsNeedsToBeWrapped;

  /// Wrap just mapActionsToPropsWithOwnProps
  final case6 =
      mapActionsWithOwnPropsNeedsToBeWrapped && noStateNeedsToBeWrapped;

  /// Wrap mapStateToProps in mapStateToPropsWithOwnProps
  final case7 =
      mapStateToPropsNeedsToBeWrapped && mapActionsWithOwnPropsNeedsToBeWrapped;

  /// Wrap mapActionToProps with mapStateToPropsWithOwnProps
  final case8 =
      mapStateWithOwnPropsNeedsToBeWrapped && mapActionsToPropsNeedsToBeWrapped;

  /*--Logic block to wrap passed in parameters using the cases from above--*/
  // If only mapStateToProps or mapStateToPropsWithOwn props is set, nothing needs
  // to be done.
  if (!case1 && !case2) {
    // Basic case: set mapStateToProps and mapActionsToProps
    if (case3) {
      final originalMapStateToProps = mapStateToProps;
      Map wrappedMapStateToProps(TStore state) {
        return {
          ...originalMapStateToProps(state),
          ...mapActionsToProps(actionsForStore[state] as TActions),
        };
      }

      mapStateToProps = wrappedMapStateToProps;
    }

    // Only set mapActionsToProps
    if (case4) {
      mapStateToProps = (state) {
        return {
          ...mapActionsToProps(actionsForStore[state] as TActions),
        };
      };
    }

    // Set both ...WithOwnProps functions
    if (case5) {
      final originalMapStateWithOwnProps = mapStateToPropsWithOwnProps;
      Map wrappedMapStateWithOwnProps(TStore state, TProps ownProps) {
        return {
          ...originalMapStateWithOwnProps(state, ownProps),
          ...mapActionsToPropsWithOwnProps(
              actionsForStore[state] as TActions, ownProps),
        };
      }

      mapStateToPropsWithOwnProps = wrappedMapStateWithOwnProps;
    }

    // Set only mapActionsToPropsWithOwnProps
    if (case6) {
      mapStateToPropsWithOwnProps = (state, ownProps) {
        return {
          ...mapActionsToPropsWithOwnProps(
              actionsForStore[state] as TActions, ownProps),
        };
      };
    }

    // Special case: set both mapStateToProps and mapActionsToPropsWithOwnProps,
    // but wrap mapStateToProps in mapStateToPropsWithOwnProps to make the props
    // accessible to mapActionsToPropsWithOwnProps
    if (case7) {
      final newMapStateToProps = mapStateToProps;
      mapStateToPropsWithOwnProps = (state, ownProps) {
        return {
          ...newMapStateToProps(state),
          ...mapActionsToPropsWithOwnProps(
              actionsForStore[state] as TActions, ownProps),
        };
      };

      mapStateToProps = null;
    }

    // Special case: the converse of case7, set mapStateToPropsWithOwnProps and
    // include mapActionsToProps because the actions still need to be set and
    // cannot be set on mapStateToProps.
    if (case8) {
      final originalMapStateWithOwnProps = mapStateToPropsWithOwnProps;
      Map wrappedMapStateToPropsWithOwnProps(TStore state, TProps ownProps) {
        return {
          ...originalMapStateWithOwnProps(state, ownProps),
          ...mapActionsToProps(actionsForStore[state] as TActions),
        };
      }

      mapStateToPropsWithOwnProps = wrappedMapStateToPropsWithOwnProps;
    }
  }
  /*--end usage of cases--*/

  if (areStatePropsEqual == null) {
    const defaultAreStatePropsEqual = _shallowMapEquality;
    const propHasher = CollectionLengthHasher();
    bool areStatePropsEqualWrapper(TProps nextProps, TProps prevProps) {
      final result = defaultAreStatePropsEqual(nextProps, prevProps);

      assert(() {
        prevProps.forEach((key, value) {
          // If the value is the same instance, check if the instance has been mutated,
          // causing its hash to be updated
          if (identical(value, nextProps[key]) &&
              propHasher.hasHashChanged(value)) {
            window.console.warn(
                'connect: The instance of the value mapped from store "$TStore" to prop "$key" was mutated directly, which will prevent updates from being detected.'
                ' Instead of mutating datastructure instances within the store, overwrite them with modified copies.\n'
                '\n  Good: `_items = [..._items, newItem]`'
                '\n  Bad:  `_items.add(newItem)`'
                '\n\nIf this is not possible, then either:'
                '\n - update `areStatePropsEqual` to reflect this behavior: `areStatePropsEqual: (_, __) => false`'
                '\n - set `pure: false`');
          }
        });

        return true;
      }());

      return result;
    }

    areStatePropsEqual = areStatePropsEqualWrapper;
  }

  return connect(
    mapStateToProps: mapStateToProps,
    mapStateToPropsWithOwnProps: mapStateToPropsWithOwnProps,
    mergeProps: mergeProps,
    areOwnPropsEqual: areOwnPropsEqual,
    areStatePropsEqual: areStatePropsEqual,
    areMergedPropsEqual: areMergedPropsEqual,
    context: context,
    pure: pure,
    forwardRef: forwardRef,
    // Don't pass along the dispatcher as props by default
    mapDispatchToProps: (_) => const {},
    // This will always be false, since both arguments will also be the same store
    areStatesEqual: (_, __) => false,
  );
}

extension InfluxStoreExtension<S extends InfluxStoreMixin> on S {
  /// Returns a [FluxToReduxAdapterStore] instance from the Flux store instance.
  ///
  /// This is meant to be a more succinct way to instantiate the adapter store.
  FluxToReduxAdapterStore asReduxStore(dynamic actions,
      {List<redux.Middleware> middleware}) {
    if (_storeAdapterFor[this] != null) return _storeAdapterFor[this];

    _storeAdapterFor[this] = FluxToReduxAdapterStore(this, actions, middleware: middleware);
    return _storeAdapterFor[this];
  }
}

extension FluxStoreExtension<S extends flux.Store> on S {
  /// Returns a [ConnectFluxAdapterStore] instance from the Flux store instance.
  ///
  /// This is meant to be a more succinct way to instantiate the adapter store.
  ConnectFluxAdapterStore asConnectFluxStore(dynamic actions,
      {List<redux.Middleware<S>> middleware}) {
    if (this is InfluxStoreMixin) {
      throw ArgumentError(
          'asConnectFluxStore should not be used when the store is implementing InfluxStoreMixin. Use `asReduxStore` instead.');
    }

    if (_connectFluxAdapterFor[this] != null) return _connectFluxAdapterFor[this];

    _connectFluxAdapterFor[this] = ConnectFluxAdapterStore(this, actions, middleware: middleware);
    return _connectFluxAdapterFor[this];
  }
}
