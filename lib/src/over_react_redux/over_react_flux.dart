import 'dart:async';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux_server.dart' as flux;

import 'value_mutation_checker.dart';

part 'over_react_flux.over_react.g.dart';

typedef mapStateToPropsTypedef<T> = Map Function(T state);

@PropsMixin(keyNamespace: '')
abstract class _$ConnectFluxPropsMixin<TActions> implements UiProps {
  @override
  Map get props;

  TActions actions;
}

class _FluxStoreUpdatedAction {}

/// Adapts a Flux store to the interface of a Redux store.
class FluxToReduxAdapterStore<S extends InfluxStoreMixin, V> extends redux.Store<S> {
  final S store;

  StreamSubscription _storeListener;

  FluxToReduxAdapterStore(this.store, dynamic actions, {List<redux.Middleware<S>> middleware}) : super(
      (_, action) {
        store.influxReducer(action);
        return store;
      },
      middleware: middleware ?? const [],
      initialState: store,
      distinct: false
  ) {
    _storeListener = store.listen((_) {
      store.triggerReduxUpdateFromFlux(dispatch);
    });

    actionsForStore[store] = actions;
  }

  @override
  Future teardown() async {
    await _storeListener.cancel();
    await super.teardown();
  }
}

@visibleForTesting
final Expando<dynamic> actionsForStore = Expando();

UiFactory<TProps> Function(UiFactory<TProps>) connectFlux<TStore extends flux.Store, TActions, TProps extends UiProps>({
  Map Function(TStore state) mapStateToProps,
  Map Function(TStore state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(TActions actions) mapActionsToProps,
  Map Function(TActions actions, TProps ownProps) mapActionsToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps) mergeProps,
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
  // Down stream, `...toProps` is defaulted in this situation anyway, but at this level,
  // allowing both can cause unnecessary complexity in decision logic.
  assert((mapStateToProps == null || mapStateToPropsWithOwnProps == null) &&
      (mapActionsToProps == null || mapActionsToPropsWithOwnProps == null));

  /*--Boolean variables used for creating more complex logic statements--*/
  final mapActionsToPropsNeedsToBeWrapped = mapActionsToProps != null;
  final mapStateToPropsNeedsToBeWrapped = mapStateToProps != null;
  final mapActionsWithOwnPropsNeedsToBeWrapped = mapActionsToPropsWithOwnProps != null;
  final mapStateWithOwnPropsNeedsToBeWrapped = mapStateToPropsWithOwnProps != null;

  final noActionsNeedToBeWrapped = !mapActionsToPropsNeedsToBeWrapped && !mapActionsWithOwnPropsNeedsToBeWrapped;
  final noStateNeedsToBeWrapped = !mapStateToPropsNeedsToBeWrapped && !mapStateWithOwnPropsNeedsToBeWrapped;

  /*--Boolean variables that represent the possible cases for wrapping parameter functions--*/

  /// Wrap mapStateToProps only
  final case1 = mapStateToPropsNeedsToBeWrapped && noActionsNeedToBeWrapped;

  /// Wrap mapStateToPropsWithOwnProps only
  final case2 = mapStateWithOwnPropsNeedsToBeWrapped && noActionsNeedToBeWrapped;

  /// Wrap mapActionsToProps with mapStateToProps
  final case3 = mapStateToPropsNeedsToBeWrapped && mapActionsToPropsNeedsToBeWrapped;

  /// Wrap mapActionsToProps only
  final case4 = mapActionsToPropsNeedsToBeWrapped && noStateNeedsToBeWrapped;

  /// Wrap mapStateToPropsWithOwnProps and mapActionsToPropsWithOwnProps
  final case5 = mapActionsWithOwnPropsNeedsToBeWrapped && mapStateWithOwnPropsNeedsToBeWrapped;

  /// Wrap just mapActionsToPropsWithOwnProps
  final case6 = mapActionsWithOwnPropsNeedsToBeWrapped && noStateNeedsToBeWrapped;

  /// Wrap mapStateToProps in mapStateToPropsWithOwnProps
  final case7 = mapStateToPropsNeedsToBeWrapped && mapActionsWithOwnPropsNeedsToBeWrapped;

  /// Wrap mapActionToProps with mapStateToPropsWithOwnProps
  final case8 = mapStateWithOwnPropsNeedsToBeWrapped && mapActionsToPropsNeedsToBeWrapped;

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
          ...mapActionsToPropsWithOwnProps(actionsForStore[state] as TActions, ownProps),
        };
      }
      mapStateToPropsWithOwnProps = wrappedMapStateWithOwnProps;
    }

    // Set only mapActionsToPropsWithOwnProps
    if (case6) {
      mapStateToPropsWithOwnProps = (state, ownProps) {
        return {
          ...mapActionsToPropsWithOwnProps(actionsForStore[state] as TActions, ownProps),
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
          ...mapActionsToPropsWithOwnProps(actionsForStore[state] as TActions, ownProps),
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
          if (identical(value, nextProps[key]) && propHasher.hasHashChanged(value)) {
            window.console.warn(
                'connect: The instance of the value mapped from store "$TStore" to prop "$key" was mutated directly, which will prevent updates from being detected.'
                    ' Instead of mutating datastructure instances within the store, overwrite them with modified copies.\n'
                    '\n  Good: `_items = [..._items, newItem]`'
                    '\n  Bad:  `_items.add(newItem)`'
                    '\n\nIf this is not possible, then either:'
                    '\n - update `areStatePropsEqual` to reflect this behavior: `areStatePropsEqual: (_, __) => false`'
                    '\n - set `pure: false`'
            );
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

bool _shallowMapEquality(Map a, Map b) => const MapEquality().equals(a, b);

/// A mixin that adds the fields necessary to make a Flux store compatible with Influx.
mixin InfluxStoreMixin<S> on flux.Store {
  /// A traditional Redux reducer function that should return a new instance of
  /// the corresponding state class.
  ///
  /// This is used in [influxReducer] to update the [state] field before triggering
  /// an update.
  redux.Reducer<S> get reduxReducer;

  /// An instance of the Redux state model that the Flux store is migrating to.
  S state;

  bool _blockNextReduxDispatch = false;

  void triggerReduxUpdateFromFlux(Dispatcher dispatcher) {
    if (_blockNextReduxDispatch) {
      _blockNextReduxDispatch = false;
      return;
    }

    dispatcher(_FluxStoreUpdatedAction());
  }

  /// A wrapper around a pure Redux reducer that keeps the Flux UI up to date with
  /// store changes.
  void influxReducer(dynamic action) {
    if (action is _FluxStoreUpdatedAction) {
      _blockNextReduxDispatch = true;
      return;
    }

    final oldState = this.state;
    this.state = reduxReducer(this.state, action);

    if (oldState != this.state) this.trigger();
  }
}
