// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $PrivateComponentFactory = registerComponent(
    () => new _$PrivateComponent(),
    builderFactory: _Private,
    componentClass: PrivateComponent,
    isWrapper: false,
    parentType: null,
    displayName: '_Private');

abstract class _$_PrivatePropsAccessorsMixin implements _$_PrivateProps {
  @override
  Map get props;

  /// <!-- Generated from [_$_PrivateProps.prop1] -->
  @override
  bool get prop1 =>
      props[_$key__prop1___$_PrivateProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$_PrivateProps.prop1] -->
  @override
  set prop1(bool value) => props[_$key__prop1___$_PrivateProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__prop1___$_PrivateProps =
      const PropDescriptor(_$key__prop1___$_PrivateProps);
  static const String _$key__prop1___$_PrivateProps = '_PrivateProps.prop1';

  static const List<PropDescriptor> $props = const [
    _$prop__prop1___$_PrivateProps
  ];
  static const List<String> $propKeys = const [_$key__prop1___$_PrivateProps];
}

const PropsMeta _$metaFor_PrivateProps = const PropsMeta(
  fields: _$_PrivatePropsAccessorsMixin.$props,
  keys: _$_PrivatePropsAccessorsMixin.$propKeys,
);

class _PrivateProps extends _$_PrivateProps with _$_PrivatePropsAccessorsMixin {
  static const PropsMeta meta = _$metaFor_PrivateProps;
}

_$$_PrivateProps _$_Private([Map backingProps]) =>
    new _$$_PrivateProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$_PrivateProps extends _$_PrivateProps
    with _$_PrivatePropsAccessorsMixin
    implements _PrivateProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_PrivateProps(Map backingMap) : this._props = {} {
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
  var _factoryOverride;
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PrivateComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '_PrivateProps.';
}

abstract class _$_PrivateStateAccessorsMixin implements _$_PrivateState {
  @override
  Map get state;

  /// <!-- Generated from [_$_PrivateState.state1] -->
  @override
  bool get state1 =>
      state[_$key__state1___$_PrivateState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$_PrivateState.state1] -->
  @override
  set state1(bool value) => state[_$key__state1___$_PrivateState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__state1___$_PrivateState =
      const StateDescriptor(_$key__state1___$_PrivateState);
  static const String _$key__state1___$_PrivateState = '_PrivateState.state1';

  static const List<StateDescriptor> $state = const [
    _$prop__state1___$_PrivateState
  ];
  static const List<String> $stateKeys = const [_$key__state1___$_PrivateState];
}

const StateMeta _$metaFor_PrivateState = const StateMeta(
  fields: _$_PrivateStateAccessorsMixin.$state,
  keys: _$_PrivateStateAccessorsMixin.$stateKeys,
);

class _PrivateState extends _$_PrivateState with _$_PrivateStateAccessorsMixin {
  static const StateMeta meta = _$metaFor_PrivateState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$_PrivateState extends _$_PrivateState
    with _$_PrivateStateAccessorsMixin
    implements _PrivateState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_PrivateState(Map backingMap) : this._state = {} {
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
class _$PrivateComponent extends PrivateComponent {
  @override
  _$$_PrivateProps typedPropsFactory(Map backingMap) =>
      new _$$_PrivateProps(backingMap);

  @override
  _$$_PrivateState typedStateFactory(Map backingMap) =>
      new _$$_PrivateState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$_PrivateProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaFor_PrivateProps
  ];
}
