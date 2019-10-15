// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ErrorBoundaryComponentFactory = registerComponent(
    () => new _$ErrorBoundaryComponent(),
    builderFactory: ErrorBoundary,
    componentClass: ErrorBoundaryComponent,
    isWrapper: true,
    parentType: null,
    displayName: 'ErrorBoundary');

abstract class _$ErrorBoundaryPropsAccessorsMixin
    implements _$ErrorBoundaryProps {
  @override
  Map get props;

  /// An optional callback that will be called with an [Error] _(or [Exception])_
  /// and `errorInfo` containing information about which component in the tree
  /// threw when the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, errorInfo) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, errorInfo);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// > Related: [onComponentIsUnrecoverable]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentDidCatch] -->
  @override
  _ComponentDidCatchCallback get onComponentDidCatch =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional callback that will be called with an [Error] _(or [Exception])_
  /// and `errorInfo` containing information about which component in the tree
  /// threw when the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, errorInfo) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, errorInfo);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// > Related: [onComponentIsUnrecoverable]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentDidCatch] -->
  @override
  set onComponentDidCatch(_ComponentDidCatchCallback value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps] = value;

  /// An optional callback that will be called _(when [fallbackUIRenderer] is not set)_
  /// with an [Error] _(or [Exception])_ and `errorInfo` containing information about which component in
  /// the tree threw multiple consecutive errors/exceptions frequently enough that it has the potential
  /// to lock the main thread.
  ///
  /// The locking of the main thread is possible in this scenario because when [fallbackUIRenderer]
  /// is not set, the [ErrorBoundary] simply re-mounts the child when an error occurs to try to "recover" automatically.
  /// However, if multiple identical errors are thrown from the exact same component in the tree - every time
  /// the [ErrorBoundary] re-mounts the tree, a sort of "infinite loop" will occur.
  ///
  /// When this callback is called, the tree wrapped by this [ErrorBoundary] has "crashed" - and is completely
  /// non-functional. Instead of re-mounting the component tree, the [ErrorBoundary] will simply render a
  /// static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// Once this happens, regaining interactivity within the tree wrapped by this [ErrorBoundary] is possible by:
  ///
  /// 1. Passing in a new child
  ///   _(preferably one that will not repeatedly throw errors when the [ErrorBoundary] mounts it)_.
  /// 2. Calling [ErrorBoundaryComponent.reset].
  ///
  /// > Will never be called when [fallbackUIRenderer] is set.
  ///
  /// > Related: [identicalErrorFrequencyTolerance]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentIsUnrecoverable] -->
  @override
  _ComponentDidCatchCallback get onComponentIsUnrecoverable =>
      props[_$key__onComponentIsUnrecoverable___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional callback that will be called _(when [fallbackUIRenderer] is not set)_
  /// with an [Error] _(or [Exception])_ and `errorInfo` containing information about which component in
  /// the tree threw multiple consecutive errors/exceptions frequently enough that it has the potential
  /// to lock the main thread.
  ///
  /// The locking of the main thread is possible in this scenario because when [fallbackUIRenderer]
  /// is not set, the [ErrorBoundary] simply re-mounts the child when an error occurs to try to "recover" automatically.
  /// However, if multiple identical errors are thrown from the exact same component in the tree - every time
  /// the [ErrorBoundary] re-mounts the tree, a sort of "infinite loop" will occur.
  ///
  /// When this callback is called, the tree wrapped by this [ErrorBoundary] has "crashed" - and is completely
  /// non-functional. Instead of re-mounting the component tree, the [ErrorBoundary] will simply render a
  /// static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// Once this happens, regaining interactivity within the tree wrapped by this [ErrorBoundary] is possible by:
  ///
  /// 1. Passing in a new child
  ///   _(preferably one that will not repeatedly throw errors when the [ErrorBoundary] mounts it)_.
  /// 2. Calling [ErrorBoundaryComponent.reset].
  ///
  /// > Will never be called when [fallbackUIRenderer] is set.
  ///
  /// > Related: [identicalErrorFrequencyTolerance]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentIsUnrecoverable] -->
  @override
  set onComponentIsUnrecoverable(_ComponentDidCatchCallback value) =>
      props[_$key__onComponentIsUnrecoverable___$ErrorBoundaryProps] = value;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.fallbackUIRenderer] -->
  @override
  _FallbackUiRenderer get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.fallbackUIRenderer] -->
  @override
  set fallbackUIRenderer(_FallbackUiRenderer value) =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryProps] = value;

  /// The amount of time that is "acceptable" between consecutive identical errors thrown from a component
  /// within the tree wrapped by this [ErrorBoundary].
  ///
  /// If [fallbackUIRenderer] is not set, and more than one identical error is thrown consecutively by
  /// the exact same component anywhere within the tree wrapped by this [ErrorBoundary] -- more often than
  /// the specified duration -- the [ErrorBoundary] will:
  ///
  ///   1. Call [onComponentIsUnrecoverable].
  ///   2. Stop attempting to re-mount the tree (to protect the main thread from being locked up).
  ///   3. Render a static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// When this happens, recovery can only occur by passing in a new child to
  /// the [ErrorBoundary], or by calling [ErrorBoundaryComponent.reset].
  ///
  /// __DO NOT MODIFY THIS VALUE UNLESS YOU KNOW WHAT YOU ARE DOING.__
  ///
  /// > Default: `const Duration(seconds: 5)`
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.identicalErrorFrequencyTolerance] -->
  @override
  Duration get identicalErrorFrequencyTolerance =>
      props[_$key__identicalErrorFrequencyTolerance___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The amount of time that is "acceptable" between consecutive identical errors thrown from a component
  /// within the tree wrapped by this [ErrorBoundary].
  ///
  /// If [fallbackUIRenderer] is not set, and more than one identical error is thrown consecutively by
  /// the exact same component anywhere within the tree wrapped by this [ErrorBoundary] -- more often than
  /// the specified duration -- the [ErrorBoundary] will:
  ///
  ///   1. Call [onComponentIsUnrecoverable].
  ///   2. Stop attempting to re-mount the tree (to protect the main thread from being locked up).
  ///   3. Render a static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// When this happens, recovery can only occur by passing in a new child to
  /// the [ErrorBoundary], or by calling [ErrorBoundaryComponent.reset].
  ///
  /// __DO NOT MODIFY THIS VALUE UNLESS YOU KNOW WHAT YOU ARE DOING.__
  ///
  /// > Default: `const Duration(seconds: 5)`
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.identicalErrorFrequencyTolerance] -->
  @override
  set identicalErrorFrequencyTolerance(Duration value) =>
      props[_$key__identicalErrorFrequencyTolerance___$ErrorBoundaryProps] =
          value;

  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.loggerName] -->
  @override
  String get loggerName =>
      props[_$key__loggerName___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.loggerName] -->
  @override
  set loggerName(String value) =>
      props[_$key__loggerName___$ErrorBoundaryProps] = value;

  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.shouldLogErrors] -->
  @override
  bool get shouldLogErrors =>
      props[_$key__shouldLogErrors___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.shouldLogErrors] -->
  @override
  set shouldLogErrors(bool value) =>
      props[_$key__shouldLogErrors___$ErrorBoundaryProps] = value;

  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.logger] -->
  @override
  Logger get logger =>
      props[_$key__logger___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.logger] -->
  @override
  set logger(Logger value) =>
      props[_$key__logger___$ErrorBoundaryProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidCatch___$ErrorBoundaryProps =
      const PropDescriptor(_$key__onComponentDidCatch___$ErrorBoundaryProps);
  static const PropDescriptor
      _$prop__onComponentIsUnrecoverable___$ErrorBoundaryProps =
      const PropDescriptor(
          _$key__onComponentIsUnrecoverable___$ErrorBoundaryProps);
  static const PropDescriptor _$prop__fallbackUIRenderer___$ErrorBoundaryProps =
      const PropDescriptor(_$key__fallbackUIRenderer___$ErrorBoundaryProps);
  static const PropDescriptor
      _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryProps =
      const PropDescriptor(
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryProps);
  static const PropDescriptor _$prop__loggerName___$ErrorBoundaryProps =
      const PropDescriptor(_$key__loggerName___$ErrorBoundaryProps);
  static const PropDescriptor _$prop__shouldLogErrors___$ErrorBoundaryProps =
      const PropDescriptor(_$key__shouldLogErrors___$ErrorBoundaryProps);
  static const PropDescriptor _$prop__logger___$ErrorBoundaryProps =
      const PropDescriptor(_$key__logger___$ErrorBoundaryProps);
  static const String _$key__onComponentDidCatch___$ErrorBoundaryProps =
      'ErrorBoundaryProps.onComponentDidCatch';
  static const String _$key__onComponentIsUnrecoverable___$ErrorBoundaryProps =
      'ErrorBoundaryProps.onComponentIsUnrecoverable';
  static const String _$key__fallbackUIRenderer___$ErrorBoundaryProps =
      'ErrorBoundaryProps.fallbackUIRenderer';
  static const String
      _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryProps =
      'ErrorBoundaryProps.identicalErrorFrequencyTolerance';
  static const String _$key__loggerName___$ErrorBoundaryProps =
      'ErrorBoundaryProps.loggerName';
  static const String _$key__shouldLogErrors___$ErrorBoundaryProps =
      'ErrorBoundaryProps.shouldLogErrors';
  static const String _$key__logger___$ErrorBoundaryProps =
      'ErrorBoundaryProps.logger';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidCatch___$ErrorBoundaryProps,
    _$prop__onComponentIsUnrecoverable___$ErrorBoundaryProps,
    _$prop__fallbackUIRenderer___$ErrorBoundaryProps,
    _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryProps,
    _$prop__loggerName___$ErrorBoundaryProps,
    _$prop__shouldLogErrors___$ErrorBoundaryProps,
    _$prop__logger___$ErrorBoundaryProps
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidCatch___$ErrorBoundaryProps,
    _$key__onComponentIsUnrecoverable___$ErrorBoundaryProps,
    _$key__fallbackUIRenderer___$ErrorBoundaryProps,
    _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryProps,
    _$key__loggerName___$ErrorBoundaryProps,
    _$key__shouldLogErrors___$ErrorBoundaryProps,
    _$key__logger___$ErrorBoundaryProps
  ];
}

const PropsMeta _$metaForErrorBoundaryProps = const PropsMeta(
  fields: _$ErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$ErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForErrorBoundaryProps;
}

_$$ErrorBoundaryProps _$ErrorBoundary([Map backingProps]) =>
    new _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin
    implements ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ErrorBoundaryProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ErrorBoundaryProps.';
}

abstract class _$ErrorBoundaryStateAccessorsMixin
    implements _$ErrorBoundaryState {
  @override
  Map get state;

  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryProps.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryProps.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.hasError] -->
  @override
  bool get hasError =>
      state[_$key__hasError___$ErrorBoundaryState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryProps.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryProps.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.hasError] -->
  @override
  set hasError(bool value) =>
      state[_$key__hasError___$ErrorBoundaryState] = value;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.showFallbackUIOnError] -->
  @override
  bool get showFallbackUIOnError =>
      state[_$key__showFallbackUIOnError___$ErrorBoundaryState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.showFallbackUIOnError] -->
  @override
  set showFallbackUIOnError(bool value) =>
      state[_$key__showFallbackUIOnError___$ErrorBoundaryState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$ErrorBoundaryState =
      const StateDescriptor(_$key__hasError___$ErrorBoundaryState);
  static const StateDescriptor
      _$prop__showFallbackUIOnError___$ErrorBoundaryState =
      const StateDescriptor(_$key__showFallbackUIOnError___$ErrorBoundaryState);
  static const String _$key__hasError___$ErrorBoundaryState =
      'ErrorBoundaryState.hasError';
  static const String _$key__showFallbackUIOnError___$ErrorBoundaryState =
      'ErrorBoundaryState.showFallbackUIOnError';

  static const List<StateDescriptor> $state = const [
    _$prop__hasError___$ErrorBoundaryState,
    _$prop__showFallbackUIOnError___$ErrorBoundaryState
  ];
  static const List<String> $stateKeys = const [
    _$key__hasError___$ErrorBoundaryState,
    _$key__showFallbackUIOnError___$ErrorBoundaryState
  ];
}

const StateMeta _$metaForErrorBoundaryState = const StateMeta(
  fields: _$ErrorBoundaryStateAccessorsMixin.$state,
  keys: _$ErrorBoundaryStateAccessorsMixin.$stateKeys,
);

class ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin
    implements ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ErrorBoundaryState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$ErrorBoundaryProps(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map backingMap) =>
      new _$$ErrorBoundaryState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForErrorBoundaryProps
  ];
}
