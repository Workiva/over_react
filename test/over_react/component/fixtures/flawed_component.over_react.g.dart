// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flawed_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedComponentFactory = registerComponent(() => new _$FlawedComponent(),
    builderFactory: Flawed,
    componentClass: FlawedComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Flawed');

abstract class _$FlawedPropsAccessorsMixin implements _$FlawedProps {
  @override
  Map get props;

  /// <!-- Generated from [_$FlawedProps.buttonTestIdPrefix] -->
  @override
  String get buttonTestIdPrefix =>
      props[_$key__buttonTestIdPrefix___$FlawedProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FlawedProps.buttonTestIdPrefix] -->
  @override
  set buttonTestIdPrefix(String value) =>
      props[_$key__buttonTestIdPrefix___$FlawedProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__buttonTestIdPrefix___$FlawedProps =
      const PropDescriptor(_$key__buttonTestIdPrefix___$FlawedProps);
  static const String _$key__buttonTestIdPrefix___$FlawedProps =
      'FlawedProps.buttonTestIdPrefix';

  static const List<PropDescriptor> $props = const [
    _$prop__buttonTestIdPrefix___$FlawedProps
  ];
  static const List<String> $propKeys = const [
    _$key__buttonTestIdPrefix___$FlawedProps
  ];
}

const PropsMeta _$metaForFlawedProps = const PropsMeta(
  fields: _$FlawedPropsAccessorsMixin.$props,
  keys: _$FlawedPropsAccessorsMixin.$propKeys,
);

_$$FlawedProps _$Flawed([Map backingProps]) => new _$$FlawedProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedProps extends _$FlawedProps
    with _$FlawedPropsAccessorsMixin
    implements FlawedProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$FlawedProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $FlawedComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedProps.';
}

abstract class _$FlawedStateAccessorsMixin implements _$FlawedState {
  @override
  Map get state;

  /// <!-- Generated from [_$FlawedState.errorCount] -->
  @override
  int get errorCount =>
      state[_$key__errorCount___$FlawedState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FlawedState.errorCount] -->
  @override
  set errorCount(int value) => state[_$key__errorCount___$FlawedState] = value;

  /// <!-- Generated from [_$FlawedState.differentTypeOfErrorCount] -->
  @override
  int get differentTypeOfErrorCount =>
      state[_$key__differentTypeOfErrorCount___$FlawedState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FlawedState.differentTypeOfErrorCount] -->
  @override
  set differentTypeOfErrorCount(int value) =>
      state[_$key__differentTypeOfErrorCount___$FlawedState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__errorCount___$FlawedState =
      const StateDescriptor(_$key__errorCount___$FlawedState);
  static const StateDescriptor
      _$prop__differentTypeOfErrorCount___$FlawedState =
      const StateDescriptor(_$key__differentTypeOfErrorCount___$FlawedState);
  static const String _$key__errorCount___$FlawedState =
      'FlawedState.errorCount';
  static const String _$key__differentTypeOfErrorCount___$FlawedState =
      'FlawedState.differentTypeOfErrorCount';

  static const List<StateDescriptor> $state = const [
    _$prop__errorCount___$FlawedState,
    _$prop__differentTypeOfErrorCount___$FlawedState
  ];
  static const List<String> $stateKeys = const [
    _$key__errorCount___$FlawedState,
    _$key__differentTypeOfErrorCount___$FlawedState
  ];
}

const StateMeta _$metaForFlawedState = const StateMeta(
  fields: _$FlawedStateAccessorsMixin.$state,
  keys: _$FlawedStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$FlawedState extends _$FlawedState
    with _$FlawedStateAccessorsMixin
    implements FlawedState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$FlawedState(Map backingMap) : this._state = {} {
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
class _$FlawedComponent extends FlawedComponent {
  @override
  _$$FlawedProps typedPropsFactory(Map backingMap) =>
      new _$$FlawedProps(backingMap);

  @override
  _$$FlawedState typedStateFactory(Map backingMap) =>
      new _$$FlawedState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FlawedProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedProps
  ];
}
