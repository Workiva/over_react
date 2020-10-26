// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ErrorBoundaryComponentFactory = registerComponent2(
  () => _$ErrorBoundaryComponent(),
  builderFactory: _$ErrorBoundary,
  componentClass: ErrorBoundaryComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'ErrorBoundary',
  skipMethods: const [],
);

_$$ErrorBoundaryProps _$ErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? _$$ErrorBoundaryProps$JsMap(JsBackedMap())
        : _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ErrorBoundaryProps extends UiProps
    with
        ErrorBoundaryProps,
        $ErrorBoundaryProps // If this generated mixin is undefined, it's likely because ErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ErrorBoundaryProps, and check that $ErrorBoundaryProps is exported/imported properly.
{
  _$$ErrorBoundaryProps._();

  factory _$$ErrorBoundaryProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ErrorBoundaryProps$JsMap(backingMap);
    } else {
      return _$$ErrorBoundaryProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ErrorBoundaryProps, and check that $ErrorBoundaryProps is exported/imported properly.
        ErrorBoundaryProps: $ErrorBoundaryProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ErrorBoundaryProps$PlainMap extends _$$ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ErrorBoundaryProps$JsMap extends _$$ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ErrorBoundaryState extends UiState
    with
        ErrorBoundaryState,
        $ErrorBoundaryState // If this generated mixin is undefined, it's likely because ErrorBoundaryState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of ErrorBoundaryState, and check that $ErrorBoundaryState is exported/imported properly.
{
  _$$ErrorBoundaryState._();

  factory _$$ErrorBoundaryState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ErrorBoundaryState$JsMap(backingMap);
    } else {
      return _$$ErrorBoundaryState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ErrorBoundaryState$PlainMap extends _$$ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ErrorBoundaryState$JsMap extends _$$ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  _$$ErrorBoundaryProps$JsMap _cachedTypedProps;

  @override
  _$$ErrorBoundaryProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$ErrorBoundaryProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$ErrorBoundaryProps(backingMap);

  _$$ErrorBoundaryState$JsMap _cachedTypedState;
  @override
  _$$ErrorBoundaryState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$ErrorBoundaryState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ErrorBoundaryState$JsMap(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map backingMap) =>
      _$$ErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ErrorBoundaryProps, and check that $ErrorBoundaryProps is exported/imported properly.
        ErrorBoundaryProps: $ErrorBoundaryProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ErrorBoundaryProps on ErrorBoundaryProps {
  static const PropsMeta meta = _$metaForErrorBoundaryProps;
  @override
  Function(dynamic error, ReactErrorInfo info) get onComponentDidCatch =>
      props[_$key__onComponentDidCatch__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set onComponentDidCatch(Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__onComponentDidCatch__ErrorBoundaryProps] = value;
  @override
  Function(dynamic error, ReactErrorInfo info) get onComponentIsUnrecoverable =>
      props[_$key__onComponentIsUnrecoverable__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set onComponentIsUnrecoverable(
          Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__onComponentIsUnrecoverable__ErrorBoundaryProps] = value;
  @override
  ReactElement Function(
      dynamic error,
      ReactErrorInfo
          info) get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set fallbackUIRenderer(
          ReactElement Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__fallbackUIRenderer__ErrorBoundaryProps] = value;
  @override
  Duration get identicalErrorFrequencyTolerance =>
      props[_$key__identicalErrorFrequencyTolerance__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set identicalErrorFrequencyTolerance(Duration value) =>
      props[_$key__identicalErrorFrequencyTolerance__ErrorBoundaryProps] =
          value;
  @override
  String get loggerName =>
      props[_$key__loggerName__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set loggerName(String value) =>
      props[_$key__loggerName__ErrorBoundaryProps] = value;
  @override
  bool get shouldLogErrors =>
      props[_$key__shouldLogErrors__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set shouldLogErrors(bool value) =>
      props[_$key__shouldLogErrors__ErrorBoundaryProps] = value;
  @override
  Logger get logger =>
      props[_$key__logger__ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set logger(Logger value) => props[_$key__logger__ErrorBoundaryProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onComponentDidCatch__ErrorBoundaryProps =
      PropDescriptor(_$key__onComponentDidCatch__ErrorBoundaryProps);
  static const PropDescriptor
      _$prop__onComponentIsUnrecoverable__ErrorBoundaryProps =
      PropDescriptor(_$key__onComponentIsUnrecoverable__ErrorBoundaryProps);
  static const PropDescriptor _$prop__fallbackUIRenderer__ErrorBoundaryProps =
      PropDescriptor(_$key__fallbackUIRenderer__ErrorBoundaryProps);
  static const PropDescriptor
      _$prop__identicalErrorFrequencyTolerance__ErrorBoundaryProps =
      PropDescriptor(
          _$key__identicalErrorFrequencyTolerance__ErrorBoundaryProps);
  static const PropDescriptor _$prop__loggerName__ErrorBoundaryProps =
      PropDescriptor(_$key__loggerName__ErrorBoundaryProps);
  static const PropDescriptor _$prop__shouldLogErrors__ErrorBoundaryProps =
      PropDescriptor(_$key__shouldLogErrors__ErrorBoundaryProps);
  static const PropDescriptor _$prop__logger__ErrorBoundaryProps =
      PropDescriptor(_$key__logger__ErrorBoundaryProps);
  static const String _$key__onComponentDidCatch__ErrorBoundaryProps =
      'ErrorBoundaryProps.onComponentDidCatch';
  static const String _$key__onComponentIsUnrecoverable__ErrorBoundaryProps =
      'ErrorBoundaryProps.onComponentIsUnrecoverable';
  static const String _$key__fallbackUIRenderer__ErrorBoundaryProps =
      'ErrorBoundaryProps.fallbackUIRenderer';
  static const String
      _$key__identicalErrorFrequencyTolerance__ErrorBoundaryProps =
      'ErrorBoundaryProps.identicalErrorFrequencyTolerance';
  static const String _$key__loggerName__ErrorBoundaryProps =
      'ErrorBoundaryProps.loggerName';
  static const String _$key__shouldLogErrors__ErrorBoundaryProps =
      'ErrorBoundaryProps.shouldLogErrors';
  static const String _$key__logger__ErrorBoundaryProps =
      'ErrorBoundaryProps.logger';

  static const List<PropDescriptor> $props = [
    _$prop__onComponentDidCatch__ErrorBoundaryProps,
    _$prop__onComponentIsUnrecoverable__ErrorBoundaryProps,
    _$prop__fallbackUIRenderer__ErrorBoundaryProps,
    _$prop__identicalErrorFrequencyTolerance__ErrorBoundaryProps,
    _$prop__loggerName__ErrorBoundaryProps,
    _$prop__shouldLogErrors__ErrorBoundaryProps,
    _$prop__logger__ErrorBoundaryProps
  ];
  static const List<String> $propKeys = [
    _$key__onComponentDidCatch__ErrorBoundaryProps,
    _$key__onComponentIsUnrecoverable__ErrorBoundaryProps,
    _$key__fallbackUIRenderer__ErrorBoundaryProps,
    _$key__identicalErrorFrequencyTolerance__ErrorBoundaryProps,
    _$key__loggerName__ErrorBoundaryProps,
    _$key__shouldLogErrors__ErrorBoundaryProps,
    _$key__logger__ErrorBoundaryProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForErrorBoundaryProps = PropsMeta(
  fields: $ErrorBoundaryProps.$props,
  keys: $ErrorBoundaryProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ErrorBoundaryState on ErrorBoundaryState {
  static const StateMeta meta = _$metaForErrorBoundaryState;
  @override
  bool get hasError =>
      state[_$key__hasError__ErrorBoundaryState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set hasError(bool value) =>
      state[_$key__hasError__ErrorBoundaryState] = value;
  @override
  bool get showFallbackUIOnError =>
      state[_$key__showFallbackUIOnError__ErrorBoundaryState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set showFallbackUIOnError(bool value) =>
      state[_$key__showFallbackUIOnError__ErrorBoundaryState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError__ErrorBoundaryState =
      StateDescriptor(_$key__hasError__ErrorBoundaryState);
  static const StateDescriptor
      _$prop__showFallbackUIOnError__ErrorBoundaryState =
      StateDescriptor(_$key__showFallbackUIOnError__ErrorBoundaryState);
  static const String _$key__hasError__ErrorBoundaryState =
      'ErrorBoundaryState.hasError';
  static const String _$key__showFallbackUIOnError__ErrorBoundaryState =
      'ErrorBoundaryState.showFallbackUIOnError';

  static const List<StateDescriptor> $state = [
    _$prop__hasError__ErrorBoundaryState,
    _$prop__showFallbackUIOnError__ErrorBoundaryState
  ];
  static const List<String> $stateKeys = [
    _$key__hasError__ErrorBoundaryState,
    _$key__showFallbackUIOnError__ErrorBoundaryState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForErrorBoundaryState = StateMeta(
  fields: $ErrorBoundaryState.$state,
  keys: $ErrorBoundaryState.$stateKeys,
);
