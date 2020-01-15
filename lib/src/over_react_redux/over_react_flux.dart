import 'dart:async';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux_server.dart' as flux;

import 'value_mutation_checker.dart';

part 'over_react_flux.over_react.g.dart';

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
      dispatch(_FluxStoreUpdatedAction());
    });

    _actionsForStore[store] = actions;
  }

  @override
  Future teardown() async {
    _storeListener.cancel();
    await super.teardown();
  }
}

T _noopReducer<T>(T state, action) => state;

final Expando<dynamic> _actionsForStore = new Expando();

UiFactory<TProps> Function(UiFactory<TProps>) connectFlux<TStore extends flux.Store, TActions, TProps extends UiProps>({
  Map Function(TStore state) mapStateToProps,
  Map Function(TStore state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(TActions actions) mapActionsToProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps) mergeProps,
  bool Function(TProps nextProps, TProps prevProps) areOwnPropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areStatePropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areMergedPropsEqual,
  Context context,
  bool pure = true,
  bool forwardRef = false,
}) {
  mapActionsToProps ??= (actions) => {'actions': actions};

  // Wrap mapStateToProps in order to implement mapActionsToProps.
  // Use this instead of mapDispatchToProps since we can't get a reference back
  // to the actions from the dispatcher.
  if (mapStateToProps != null) {
    final originalMapStateToProps = mapStateToProps;
    Map wrappedMapStateToProps(TStore state) {
      return {
        ...originalMapStateToProps(state),
        ...mapActionsToProps(_actionsForStore[state] as TActions),
      };
    }
    mapStateToProps = wrappedMapStateToProps;
  }
  // todo mapStateToPropsWithOwnProps

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
  /// and update.
  redux.Reducer<S> get reduxReducer;

  /// An instance of the Redux state model that the Flux component is migrating to.
  S state;

  /// A wrapper around a pure Redux reducer that keeps the Flux UI up to date with
  /// store changes.
  void influxReducer(dynamic action) {
    final oldState = this.state;
    this.state = reduxReducer(this.state, action);
    if (oldState != this.state) {
      this.trigger();
    }
  }
}
