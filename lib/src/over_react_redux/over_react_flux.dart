import 'dart:async';

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
