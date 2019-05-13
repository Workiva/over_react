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

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
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
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
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

  /// <!-- Generated from [_$FlawedState.hasError] -->
  @override
  bool get hasError =>
      state[_$key__hasError___$FlawedState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FlawedState.hasError] -->
  @override
  set hasError(bool value) => state[_$key__hasError___$FlawedState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$FlawedState =
      const StateDescriptor(_$key__hasError___$FlawedState);
  static const String _$key__hasError___$FlawedState = 'FlawedState.hasError';

  static const List<StateDescriptor> $state = const [
    _$prop__hasError___$FlawedState
  ];
  static const List<String> $stateKeys = const [_$key__hasError___$FlawedState];
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
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
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
