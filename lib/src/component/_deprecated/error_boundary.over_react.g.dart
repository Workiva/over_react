// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
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
    _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin
    implements ErrorBoundaryProps {
  _$$ErrorBoundaryProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

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

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ErrorBoundaryProps(
          accessMap, (map) => _$$ErrorBoundaryProps(map));

  @override
  Set<String> get requiredPropNamesToSkipValidation => const {
        'identicalErrorFrequencyTolerance',
        'loggerName',
        'shouldLogErrors'
      };
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ErrorBoundaryProps = getPropKey;

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
class _$$ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin
    implements ErrorBoundaryState {
  _$$ErrorBoundaryState([Map? backingMap])
      : this.state = backingMap ?? JsBackedMap();

  /// The backing state map proxied by this class.
  @override
  final Map state;

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  late _$$ErrorBoundaryProps _cachedTypedProps;

  @override
  _$$ErrorBoundaryProps get props => _cachedTypedProps;

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
  _$$ErrorBoundaryProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ErrorBoundaryProps(backingMap);

  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map? backingMap) =>
      _$$ErrorBoundaryProps(backingMap);

  late _$$ErrorBoundaryState _cachedTypedState;
  @override
  _$$ErrorBoundaryState get state => _cachedTypedState;

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
  _$$ErrorBoundaryState typedStateFactoryJs(JsBackedMap? backingMap) =>
      _$$ErrorBoundaryState(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map? backingMap) =>
      _$$ErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ErrorBoundary';

  /// The default consumed props, taken from _$ErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForErrorBoundaryProps
  ];
}
