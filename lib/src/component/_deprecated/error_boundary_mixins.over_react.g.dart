// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'error_boundary_mixins.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated(
    'Building custom error boundaries with this mixin will no longer be supported in version 4.0.0.'
    'Use ErrorBoundary and its prop API to customize error handling instead.')
abstract class ErrorBoundaryPropsMixin implements _$ErrorBoundaryPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForErrorBoundaryPropsMixin;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  Function(dynamic error, ReactErrorInfo info)? get onComponentDidCatch =>
      (props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] ?? null)
          as Function(dynamic error, ReactErrorInfo info)?;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  set onComponentDidCatch(
          Function(dynamic error, ReactErrorInfo info)? value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] = value;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] -->
  @override
  Function(dynamic error, ReactErrorInfo? info)?
      get onComponentIsUnrecoverable => (props[
              _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin] ??
          null) as Function(dynamic error, ReactErrorInfo? info)?;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] -->
  @override
  set onComponentIsUnrecoverable(
          Function(dynamic error, ReactErrorInfo? info)? value) =>
      props[_$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin] =
          value;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  ReactElement Function(dynamic error, ReactErrorInfo? info)?
      get fallbackUIRenderer =>
          (props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] ?? null)
              as ReactElement Function(dynamic error, ReactErrorInfo? info)?;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  set fallbackUIRenderer(
          ReactElement Function(dynamic error, ReactErrorInfo? info)? value) =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] = value;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance] -->
  @override
  Duration? get identicalErrorFrequencyTolerance => (props[
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin] ??
      null) as Duration?;

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
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance] -->
  @override
  set identicalErrorFrequencyTolerance(Duration? value) => props[
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin] =
      value;

  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.loggerName] -->
  @override
  String? get loggerName =>
      (props[_$key__loggerName___$ErrorBoundaryPropsMixin] ?? null) as String?;

  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.loggerName] -->
  @override
  set loggerName(String? value) =>
      props[_$key__loggerName___$ErrorBoundaryPropsMixin] = value;

  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.shouldLogErrors] -->
  @override
  bool? get shouldLogErrors =>
      (props[_$key__shouldLogErrors___$ErrorBoundaryPropsMixin] ?? null)
          as bool?;

  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.shouldLogErrors] -->
  @override
  set shouldLogErrors(bool? value) =>
      props[_$key__shouldLogErrors___$ErrorBoundaryPropsMixin] = value;

  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.logger] -->
  @override
  Logger? get logger =>
      (props[_$key__logger___$ErrorBoundaryPropsMixin] ?? null) as Logger?;

  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.logger] -->
  @override
  set logger(Logger? value) =>
      props[_$key__logger___$ErrorBoundaryPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      PropDescriptor(_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin =
      PropDescriptor(
          _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      PropDescriptor(_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin =
      PropDescriptor(
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin);
  static const PropDescriptor _$prop__loggerName___$ErrorBoundaryPropsMixin =
      PropDescriptor(_$key__loggerName___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__shouldLogErrors___$ErrorBoundaryPropsMixin =
      PropDescriptor(_$key__shouldLogErrors___$ErrorBoundaryPropsMixin);
  static const PropDescriptor _$prop__logger___$ErrorBoundaryPropsMixin =
      PropDescriptor(_$key__logger___$ErrorBoundaryPropsMixin);
  static const String _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.onComponentDidCatch';
  static const String
      _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.onComponentIsUnrecoverable';
  static const String _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.fallbackUIRenderer';
  static const String
      _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance';
  static const String _$key__loggerName___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.loggerName';
  static const String _$key__shouldLogErrors___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.shouldLogErrors';
  static const String _$key__logger___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.logger';

  static const List<PropDescriptor> $props = [
    _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$prop__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin,
    _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin,
    _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin,
    _$prop__loggerName___$ErrorBoundaryPropsMixin,
    _$prop__shouldLogErrors___$ErrorBoundaryPropsMixin,
    _$prop__logger___$ErrorBoundaryPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin,
    _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin,
    _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin,
    _$key__loggerName___$ErrorBoundaryPropsMixin,
    _$key__shouldLogErrors___$ErrorBoundaryPropsMixin,
    _$key__logger___$ErrorBoundaryPropsMixin
  ];
}

const PropsMeta _$metaForErrorBoundaryPropsMixin = PropsMeta(
  fields: ErrorBoundaryPropsMixin.$props,
  keys: ErrorBoundaryPropsMixin.$propKeys,
);

@Deprecated(
    'Building custom error boundaries with this mixin will no longer be supported in version 4.0.0.'
    'Use ErrorBoundary and its prop API to customize error handling instead.')
abstract class ErrorBoundaryStateMixin implements _$ErrorBoundaryStateMixin {
  @override
  Map get state;

  static const StateMeta meta = _$metaForErrorBoundaryStateMixin;

  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryPropsMixin.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryPropsMixin.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  bool? get hasError =>
      (state[_$key__hasError___$ErrorBoundaryStateMixin] ?? null) as bool?;

  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryPropsMixin.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryPropsMixin.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  set hasError(bool? value) =>
      state[_$key__hasError___$ErrorBoundaryStateMixin] = value;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryPropsMixin.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.showFallbackUIOnError] -->
  @override
  bool? get showFallbackUIOnError =>
      (state[_$key__showFallbackUIOnError___$ErrorBoundaryStateMixin] ?? null)
          as bool?;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryPropsMixin.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.showFallbackUIOnError] -->
  @override
  set showFallbackUIOnError(bool? value) =>
      state[_$key__showFallbackUIOnError___$ErrorBoundaryStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$ErrorBoundaryStateMixin =
      StateDescriptor(_$key__hasError___$ErrorBoundaryStateMixin);
  static const StateDescriptor
      _$prop__showFallbackUIOnError___$ErrorBoundaryStateMixin =
      StateDescriptor(_$key__showFallbackUIOnError___$ErrorBoundaryStateMixin);
  static const String _$key__hasError___$ErrorBoundaryStateMixin =
      'ErrorBoundaryStateMixin.hasError';
  static const String _$key__showFallbackUIOnError___$ErrorBoundaryStateMixin =
      'ErrorBoundaryStateMixin.showFallbackUIOnError';

  static const List<StateDescriptor> $state = [
    _$prop__hasError___$ErrorBoundaryStateMixin,
    _$prop__showFallbackUIOnError___$ErrorBoundaryStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__hasError___$ErrorBoundaryStateMixin,
    _$key__showFallbackUIOnError___$ErrorBoundaryStateMixin
  ];
}

const StateMeta _$metaForErrorBoundaryStateMixin = StateMeta(
  fields: ErrorBoundaryStateMixin.$state,
  keys: ErrorBoundaryStateMixin.$stateKeys,
);
