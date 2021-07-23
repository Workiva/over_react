// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ErrorBoundaryComponentFactory = registerComponent2(
  () => _$ErrorBoundaryComponent(),
  builderFactory: _$ErrorBoundary,
  componentClass: ErrorBoundaryComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'ErrorBoundary',
  skipMethods: const [],
);

@Deprecated(
    'Use the `ErrorBoundaryProps` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
abstract class _$ErrorBoundaryPropsAccessorsMixin
    implements _$ErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForErrorBoundaryProps = PropsMeta(
  fields: _$ErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$ErrorBoundaryPropsAccessorsMixin.$propKeys,
);

@Deprecated(
    'Use the `ErrorBoundaryProps` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
class ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForErrorBoundaryProps;
}

_$$ErrorBoundaryProps _$ErrorBoundary([Map? backingProps]) =>
    backingProps == null
        ? _$$ErrorBoundaryProps$JsMap(JsBackedMap())
        : _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin
    implements ErrorBoundaryProps {
  _$$ErrorBoundaryProps._();

  factory _$$ErrorBoundaryProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ErrorBoundaryProps$JsMap(backingMap as JsBackedMap?);
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
  String get propKeyNamespace => 'ErrorBoundaryProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ErrorBoundaryProps$PlainMap extends _$$ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryProps$PlainMap(Map? backingMap)
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
class _$$ErrorBoundaryProps$JsMap extends _$$ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

@Deprecated(
    'Use the `ErrorBoundaryState` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
abstract class _$ErrorBoundaryStateAccessorsMixin
    implements _$ErrorBoundaryState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForErrorBoundaryState = StateMeta(
  fields: _$ErrorBoundaryStateAccessorsMixin.$state,
  keys: _$ErrorBoundaryStateAccessorsMixin.$stateKeys,
);

@Deprecated(
    'Use the `ErrorBoundaryState` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
class ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin
    implements ErrorBoundaryState {
  _$$ErrorBoundaryState._();

  factory _$$ErrorBoundaryState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ErrorBoundaryState$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ErrorBoundaryState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ErrorBoundaryState$PlainMap extends _$$ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryState$PlainMap(Map? backingMap)
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
class _$$ErrorBoundaryState$JsMap extends _$$ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ErrorBoundaryState$JsMap(JsBackedMap? backingMap)
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
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  late _$$ErrorBoundaryProps$JsMap _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ErrorBoundaryProps$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ErrorBoundaryProps$JsMap(backingMap);

  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map? backingMap) =>
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
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$ErrorBoundaryState$JsMap typedStateFactoryJs(JsBackedMap? backingMap) =>
      _$$ErrorBoundaryState$JsMap(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map? backingMap) =>
      _$$ErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForErrorBoundaryProps
  ];
}
