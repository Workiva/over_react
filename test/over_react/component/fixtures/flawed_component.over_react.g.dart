// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'flawed_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedComponentFactory = registerComponent2(
  () => _$FlawedComponent(),
  builderFactory: _$Flawed,
  componentClass: FlawedComponent,
  isWrapper: false,
  parentType: null,
);

mixin _$FlawedPropsAccessorsMixin implements _$FlawedProps {
  @override
  Map get props;

  /// <!-- Generated from [_$FlawedProps.buttonTestIdPrefix] -->
  @override
  String? get buttonTestIdPrefix =>
      (props[_$key__buttonTestIdPrefix___$FlawedProps] ?? null) as String?;

  /// <!-- Generated from [_$FlawedProps.buttonTestIdPrefix] -->
  @override
  set buttonTestIdPrefix(String? value) =>
      props[_$key__buttonTestIdPrefix___$FlawedProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__buttonTestIdPrefix___$FlawedProps =
      PropDescriptor(_$key__buttonTestIdPrefix___$FlawedProps);
  static const String _$key__buttonTestIdPrefix___$FlawedProps =
      'FlawedProps.buttonTestIdPrefix';

  static const List<PropDescriptor> $props = [
    _$prop__buttonTestIdPrefix___$FlawedProps
  ];
  static const List<String> $propKeys = [
    _$key__buttonTestIdPrefix___$FlawedProps
  ];
}

const PropsMeta _$metaForFlawedProps = PropsMeta(
  fields: _$FlawedPropsAccessorsMixin.$props,
  keys: _$FlawedPropsAccessorsMixin.$propKeys,
);

_$$FlawedProps _$Flawed([Map? backingProps]) => _$$FlawedProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedProps extends _$FlawedProps
    with _$FlawedPropsAccessorsMixin
    implements FlawedProps {
  _$$FlawedProps([Map? backingMap]) : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FlawedComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$FlawedProps(accessMap, (map) => _$$FlawedProps(map));

  @override
  Set<String> get requiredPropNamesToSkipValidation =>
      const {'buttonTestIdPrefix'};
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$FlawedProps = getPropKey;
mixin _$FlawedStateAccessorsMixin implements _$FlawedState {
  @override
  Map get state;

  /// <!-- Generated from [_$FlawedState.errorCount] -->
  @override
  int? get errorCount =>
      (state[_$key__errorCount___$FlawedState] ?? null) as int?;

  /// <!-- Generated from [_$FlawedState.errorCount] -->
  @override
  set errorCount(int? value) => state[_$key__errorCount___$FlawedState] = value;

  /// <!-- Generated from [_$FlawedState.differentTypeOfErrorCount] -->
  @override
  int? get differentTypeOfErrorCount =>
      (state[_$key__differentTypeOfErrorCount___$FlawedState] ?? null) as int?;

  /// <!-- Generated from [_$FlawedState.differentTypeOfErrorCount] -->
  @override
  set differentTypeOfErrorCount(int? value) =>
      state[_$key__differentTypeOfErrorCount___$FlawedState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__errorCount___$FlawedState =
      StateDescriptor(_$key__errorCount___$FlawedState);
  static const StateDescriptor
      _$prop__differentTypeOfErrorCount___$FlawedState =
      StateDescriptor(_$key__differentTypeOfErrorCount___$FlawedState);
  static const String _$key__errorCount___$FlawedState =
      'FlawedState.errorCount';
  static const String _$key__differentTypeOfErrorCount___$FlawedState =
      'FlawedState.differentTypeOfErrorCount';

  static const List<StateDescriptor> $state = [
    _$prop__errorCount___$FlawedState,
    _$prop__differentTypeOfErrorCount___$FlawedState
  ];
  static const List<String> $stateKeys = [
    _$key__errorCount___$FlawedState,
    _$key__differentTypeOfErrorCount___$FlawedState
  ];
}

const StateMeta _$metaForFlawedState = StateMeta(
  fields: _$FlawedStateAccessorsMixin.$state,
  keys: _$FlawedStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$FlawedState extends _$FlawedState
    with _$FlawedStateAccessorsMixin
    implements FlawedState {
  _$$FlawedState([Map? backingMap]) : this.state = backingMap ?? JsBackedMap();

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
class _$FlawedComponent extends FlawedComponent {
  late _$$FlawedProps _cachedTypedProps;

  @override
  _$$FlawedProps get props => _cachedTypedProps;

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
  _$$FlawedProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$FlawedProps(backingMap);

  @override
  _$$FlawedProps typedPropsFactory(Map? backingMap) =>
      _$$FlawedProps(backingMap);

  late _$$FlawedState _cachedTypedState;
  @override
  _$$FlawedState get state => _cachedTypedState;

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
  _$$FlawedState typedStateFactoryJs(JsBackedMap? backingMap) =>
      _$$FlawedState(backingMap);

  @override
  _$$FlawedState typedStateFactory(Map? backingMap) =>
      _$$FlawedState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'Flawed';

  /// The default consumed props, taken from _$FlawedProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedProps
  ];
}
