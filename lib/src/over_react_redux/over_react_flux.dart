import 'dart:async';
import 'dart:html';

import 'package:collection/collection.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart' as redux;
import 'package:w_flux/w_flux_server.dart' as flux;

class _FluxStoreUpdatedAction {}

/// Adapts a Flux store to the interface of a Redux store.
class FluxToReduxAdapterStore<S extends flux.Store> extends redux.Store<S> {
  final S store;

  StreamSubscription _storeListener;

  FluxToReduxAdapterStore(this.store) : super(_noopReducer, initialState: store, distinct: false) {
    _storeListener = store.listen((_) {
      dispatch(new _FluxStoreUpdatedAction());
    });
  }

  @override
  Future teardown() async {
    _storeListener.cancel();
    await super.teardown();
  }
}

T _noopReducer<T>(T state, action) => state;


UiFactory<TProps> Function(UiFactory<TProps>) connectFlux<TStore extends flux.Store, TProps extends UiProps>({
  Map Function(TStore state) mapStateToProps,
  Map Function(TStore state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps) mergeProps,
  bool Function(TProps nextProps, TProps prevProps) areOwnPropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areStatePropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areMergedPropsEqual,
  Context context,
  bool pure = true,
  bool forwardRef = false,
}) {
  if (areStatePropsEqual == null) {
    const defaultAreStatePropsEqual = _shallowMapEquality;
    final Expando<int> _listLength = new Expando();
    bool areStatePropsEqualWrapper(TProps nextProps, TProps prevProps) {
      final result = defaultAreStatePropsEqual(nextProps, prevProps);

      assert(() {
        prevProps.forEach((key, value) {
          if (value is List && identical(value, nextProps[key])) {
            final lastLength = _listLength[value];
            final currentLength = _listLength[value] = value.length;
            if (lastLength != null && lastLength != currentLength) {
              window.console.warn(
                  'connect: Value mapped from store "$TStore" to prop "$key" was mutated directly, which will prevent updates from being detected.'
                      ' Instead of mutating datastructures within the store, overwrite them with modified copies.\n'
                      '\n  Good: `_items = [..._items, newItem]`'
                      '\n  Bad:  `_items.add(newItem)`'
                      '\n\nIf this is not possible, then either:'
                      '\n - update `areStatePropsEqual` to reflect this behavior: `areStatePropsEqual: (_, __) => false`'
                      '\n - set `pure: false`'
              );
            }
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
