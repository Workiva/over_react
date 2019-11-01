// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safe_render_manager_helper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SafeRenderManagerHelperComponentFactory = registerComponent(
    () => new _$SafeRenderManagerHelperComponent(),
    builderFactory: SafeRenderManagerHelper,
    componentClass: SafeRenderManagerHelperComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'SafeRenderManagerHelper');

abstract class _$SafeRenderManagerHelperPropsAccessorsMixin
    implements _$SafeRenderManagerHelperProps {
  @override
  Map get props;

  /// <!-- Generated from [_$SafeRenderManagerHelperProps.getInitialContent] -->
  @override
  @requiredProp
  _GetInitialContent get getInitialContent =>
      props[_$key__getInitialContent___$SafeRenderManagerHelperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SafeRenderManagerHelperProps.getInitialContent] -->
  @override
  @requiredProp
  set getInitialContent(_GetInitialContent value) =>
      props[_$key__getInitialContent___$SafeRenderManagerHelperProps] = value;

  /// <!-- Generated from [_$SafeRenderManagerHelperProps.contentRef] -->
  @override
  CallbackRef get contentRef =>
      props[_$key__contentRef___$SafeRenderManagerHelperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SafeRenderManagerHelperProps.contentRef] -->
  @override
  set contentRef(CallbackRef value) =>
      props[_$key__contentRef___$SafeRenderManagerHelperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__getInitialContent___$SafeRenderManagerHelperProps =
      const PropDescriptor(
          _$key__getInitialContent___$SafeRenderManagerHelperProps,
          isRequired: true);
  static const PropDescriptor
      _$prop__contentRef___$SafeRenderManagerHelperProps =
      const PropDescriptor(_$key__contentRef___$SafeRenderManagerHelperProps);
  static const String _$key__getInitialContent___$SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.getInitialContent';
  static const String _$key__contentRef___$SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.contentRef';

  static const List<PropDescriptor> $props = const [
    _$prop__getInitialContent___$SafeRenderManagerHelperProps,
    _$prop__contentRef___$SafeRenderManagerHelperProps
  ];
  static const List<String> $propKeys = const [
    _$key__getInitialContent___$SafeRenderManagerHelperProps,
    _$key__contentRef___$SafeRenderManagerHelperProps
  ];
}

const PropsMeta _$metaForSafeRenderManagerHelperProps = const PropsMeta(
  fields: _$SafeRenderManagerHelperPropsAccessorsMixin.$props,
  keys: _$SafeRenderManagerHelperPropsAccessorsMixin.$propKeys,
);

_$$SafeRenderManagerHelperProps _$SafeRenderManagerHelper([Map backingProps]) =>
    new _$$SafeRenderManagerHelperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$SafeRenderManagerHelperProps extends _$SafeRenderManagerHelperProps
    with _$SafeRenderManagerHelperPropsAccessorsMixin
    implements SafeRenderManagerHelperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $SafeRenderManagerHelperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SafeRenderManagerHelperProps.';
}

abstract class _$SafeRenderManagerHelperStateAccessorsMixin
    implements _$SafeRenderManagerHelperState {
  @override
  Map get state;

  /// <!-- Generated from [_$SafeRenderManagerHelperState.content] -->
  @override
  ReactElement get content =>
      state[_$key__content___$SafeRenderManagerHelperState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SafeRenderManagerHelperState.content] -->
  @override
  set content(ReactElement value) =>
      state[_$key__content___$SafeRenderManagerHelperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__content___$SafeRenderManagerHelperState =
      const StateDescriptor(_$key__content___$SafeRenderManagerHelperState);
  static const String _$key__content___$SafeRenderManagerHelperState =
      'SafeRenderManagerHelperState.content';

  static const List<StateDescriptor> $state = const [
    _$prop__content___$SafeRenderManagerHelperState
  ];
  static const List<String> $stateKeys = const [
    _$key__content___$SafeRenderManagerHelperState
  ];
}

const StateMeta _$metaForSafeRenderManagerHelperState = const StateMeta(
  fields: _$SafeRenderManagerHelperStateAccessorsMixin.$state,
  keys: _$SafeRenderManagerHelperStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$SafeRenderManagerHelperState extends _$SafeRenderManagerHelperState
    with _$SafeRenderManagerHelperStateAccessorsMixin
    implements SafeRenderManagerHelperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperState(Map backingMap) : this._state = {} {
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
class _$SafeRenderManagerHelperComponent
    extends SafeRenderManagerHelperComponent {
  @override
  _$$SafeRenderManagerHelperProps typedPropsFactory(Map backingMap) =>
      new _$$SafeRenderManagerHelperProps(backingMap);

  @override
  _$$SafeRenderManagerHelperState typedStateFactory(Map backingMap) =>
      new _$$SafeRenderManagerHelperState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SafeRenderManagerHelperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForSafeRenderManagerHelperProps
  ];
}
