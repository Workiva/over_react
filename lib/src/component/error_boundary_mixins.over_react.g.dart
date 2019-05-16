// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary_mixins.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class ErrorBoundaryPropsMixin implements _$ErrorBoundaryPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForErrorBoundaryPropsMixin;

  /// An optional callback that will be called with an [Error] and a [ReactErrorInfo]
  /// containing information about which component in the tree threw the error when
  /// the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, info) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, info);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  Function(dynamic error, ReactErrorInfo info) get onComponentDidCatch =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional callback that will be called with an [Error] and a [ReactErrorInfo]
  /// containing information about which component in the tree threw the error when
  /// the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, info) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, info);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  set onComponentDidCatch(Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] = value;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  ReactElement Function() get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  set fallbackUIRenderer(ReactElement Function() value) =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin);
  static const String _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.onComponentDidCatch';
  static const String _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.fallbackUIRenderer';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin
  ];
}

const PropsMeta _$metaForErrorBoundaryPropsMixin = const PropsMeta(
  fields: ErrorBoundaryPropsMixin.$props,
  keys: ErrorBoundaryPropsMixin.$propKeys,
);

abstract class ErrorBoundaryStateMixin implements _$ErrorBoundaryStateMixin {
  @override
  Map get state;

  static const StateMeta meta = _$metaForErrorBoundaryStateMixin;

  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  bool get hasError =>
      state[_$key__hasError___$ErrorBoundaryStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  set hasError(bool value) =>
      state[_$key__hasError___$ErrorBoundaryStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$ErrorBoundaryStateMixin =
      const StateDescriptor(_$key__hasError___$ErrorBoundaryStateMixin);
  static const String _$key__hasError___$ErrorBoundaryStateMixin =
      'ErrorBoundaryStateMixin.hasError';

  static const List<StateDescriptor> $state = const [
    _$prop__hasError___$ErrorBoundaryStateMixin
  ];
  static const List<String> $stateKeys = const [
    _$key__hasError___$ErrorBoundaryStateMixin
  ];
}

const StateMeta _$metaForErrorBoundaryStateMixin = const StateMeta(
  fields: ErrorBoundaryStateMixin.$state,
  keys: ErrorBoundaryStateMixin.$stateKeys,
);
