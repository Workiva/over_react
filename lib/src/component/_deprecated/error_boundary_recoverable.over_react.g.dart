// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'error_boundary_recoverable.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $RecoverableErrorBoundaryComponentFactory = registerComponent2(
  () => _$RecoverableErrorBoundaryComponent(),
  builderFactory: _$RecoverableErrorBoundary,
  componentClass: RecoverableErrorBoundaryComponent,
  isWrapper: true,
  parentType: null,
  skipMethods: const [],
);

@Deprecated(
    'For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
abstract class _$RecoverableErrorBoundaryPropsAccessorsMixin
    implements _$RecoverableErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForRecoverableErrorBoundaryProps = PropsMeta(
  fields: _$RecoverableErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$RecoverableErrorBoundaryPropsAccessorsMixin.$propKeys,
);

@Deprecated(
    'For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
class RecoverableErrorBoundaryProps extends _$RecoverableErrorBoundaryProps
    with _$RecoverableErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForRecoverableErrorBoundaryProps;
}

_$$RecoverableErrorBoundaryProps _$RecoverableErrorBoundary(
        [Map? backingProps]) =>
    _$$RecoverableErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$RecoverableErrorBoundaryProps extends _$RecoverableErrorBoundaryProps
    with _$RecoverableErrorBoundaryPropsAccessorsMixin
    implements RecoverableErrorBoundaryProps {
  _$$RecoverableErrorBoundaryProps([Map? backingMap])
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
      super.componentFactory ?? $RecoverableErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'RecoverableErrorBoundaryProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$RecoverableErrorBoundaryProps(
          accessMap, (map) => _$$RecoverableErrorBoundaryProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$RecoverableErrorBoundaryProps = getPropKey;

@Deprecated(
    'For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
abstract class _$RecoverableErrorBoundaryStateAccessorsMixin
    implements _$RecoverableErrorBoundaryState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForRecoverableErrorBoundaryState = StateMeta(
  fields: _$RecoverableErrorBoundaryStateAccessorsMixin.$state,
  keys: _$RecoverableErrorBoundaryStateAccessorsMixin.$stateKeys,
);

@Deprecated(
    'For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
class RecoverableErrorBoundaryState extends _$RecoverableErrorBoundaryState
    with _$RecoverableErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForRecoverableErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$RecoverableErrorBoundaryState extends _$RecoverableErrorBoundaryState
    with _$RecoverableErrorBoundaryStateAccessorsMixin
    implements RecoverableErrorBoundaryState {
  _$$RecoverableErrorBoundaryState([Map? backingMap])
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
class _$RecoverableErrorBoundaryComponent
    extends RecoverableErrorBoundaryComponent {
  late _$$RecoverableErrorBoundaryProps _cachedTypedProps;

  @override
  _$$RecoverableErrorBoundaryProps get props => _cachedTypedProps;

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
  _$$RecoverableErrorBoundaryProps typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$RecoverableErrorBoundaryProps(backingMap);

  @override
  _$$RecoverableErrorBoundaryProps typedPropsFactory(Map? backingMap) =>
      _$$RecoverableErrorBoundaryProps(backingMap);

  late _$$RecoverableErrorBoundaryState _cachedTypedState;
  @override
  _$$RecoverableErrorBoundaryState get state => _cachedTypedState;

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
  _$$RecoverableErrorBoundaryState typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$RecoverableErrorBoundaryState(backingMap);

  @override
  _$$RecoverableErrorBoundaryState typedStateFactory(Map? backingMap) =>
      _$$RecoverableErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'RecoverableErrorBoundary';

  /// The default consumed props, taken from _$RecoverableErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForRecoverableErrorBoundaryProps
  ];
}
