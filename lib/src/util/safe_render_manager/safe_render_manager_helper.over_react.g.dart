// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'safe_render_manager_helper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SafeRenderManagerHelperComponentFactory = registerComponent2(
  () => _$SafeRenderManagerHelperComponent(),
  builderFactory: _$SafeRenderManagerHelper,
  componentClass: SafeRenderManagerHelperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'SafeRenderManagerHelper',
);

abstract class _$SafeRenderManagerHelperPropsAccessorsMixin
    implements _$SafeRenderManagerHelperProps {
  @override
  Map get props;

  /// <!-- Generated from [_$SafeRenderManagerHelperProps.getInitialContent] -->
  @override
  @requiredProp
  ReactElement Function() get getInitialContent =>
      props[_$key__getInitialContent___$SafeRenderManagerHelperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SafeRenderManagerHelperProps.getInitialContent] -->
  @override
  @requiredProp
  set getInitialContent(ReactElement Function() value) =>
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
      PropDescriptor(_$key__getInitialContent___$SafeRenderManagerHelperProps,
          isRequired: true);
  static const PropDescriptor
      _$prop__contentRef___$SafeRenderManagerHelperProps =
      PropDescriptor(_$key__contentRef___$SafeRenderManagerHelperProps);
  static const String _$key__getInitialContent___$SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.getInitialContent';
  static const String _$key__contentRef___$SafeRenderManagerHelperProps =
      'SafeRenderManagerHelperProps.contentRef';

  static const List<PropDescriptor> $props = [
    _$prop__getInitialContent___$SafeRenderManagerHelperProps,
    _$prop__contentRef___$SafeRenderManagerHelperProps
  ];
  static const List<String> $propKeys = [
    _$key__getInitialContent___$SafeRenderManagerHelperProps,
    _$key__contentRef___$SafeRenderManagerHelperProps
  ];
}

const PropsMeta _$metaForSafeRenderManagerHelperProps = PropsMeta(
  fields: _$SafeRenderManagerHelperPropsAccessorsMixin.$props,
  keys: _$SafeRenderManagerHelperPropsAccessorsMixin.$propKeys,
);

_$$SafeRenderManagerHelperProps _$SafeRenderManagerHelper([Map backingProps]) =>
    backingProps == null
        ? _$$SafeRenderManagerHelperProps$JsMap(JsBackedMap())
        : _$$SafeRenderManagerHelperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$SafeRenderManagerHelperProps
    extends _$SafeRenderManagerHelperProps
    with _$SafeRenderManagerHelperPropsAccessorsMixin
    implements SafeRenderManagerHelperProps {
  _$$SafeRenderManagerHelperProps._();

  factory _$$SafeRenderManagerHelperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SafeRenderManagerHelperProps$JsMap(backingMap);
    } else {
      return _$$SafeRenderManagerHelperProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SafeRenderManagerHelperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SafeRenderManagerHelperProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$SafeRenderManagerHelperProps$PlainMap
    extends _$$SafeRenderManagerHelperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperProps$PlainMap(Map backingMap)
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
class _$$SafeRenderManagerHelperProps$JsMap
    extends _$$SafeRenderManagerHelperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
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
      StateDescriptor(_$key__content___$SafeRenderManagerHelperState);
  static const String _$key__content___$SafeRenderManagerHelperState =
      'SafeRenderManagerHelperState.content';

  static const List<StateDescriptor> $state = [
    _$prop__content___$SafeRenderManagerHelperState
  ];
  static const List<String> $stateKeys = [
    _$key__content___$SafeRenderManagerHelperState
  ];
}

const StateMeta _$metaForSafeRenderManagerHelperState = StateMeta(
  fields: _$SafeRenderManagerHelperStateAccessorsMixin.$state,
  keys: _$SafeRenderManagerHelperStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$SafeRenderManagerHelperState
    extends _$SafeRenderManagerHelperState
    with _$SafeRenderManagerHelperStateAccessorsMixin
    implements SafeRenderManagerHelperState {
  _$$SafeRenderManagerHelperState._();

  factory _$$SafeRenderManagerHelperState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SafeRenderManagerHelperState$JsMap(backingMap);
    } else {
      return _$$SafeRenderManagerHelperState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$SafeRenderManagerHelperState$PlainMap
    extends _$$SafeRenderManagerHelperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperState$PlainMap(Map backingMap)
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
class _$$SafeRenderManagerHelperState$JsMap
    extends _$$SafeRenderManagerHelperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SafeRenderManagerHelperState$JsMap(JsBackedMap backingMap)
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
class _$SafeRenderManagerHelperComponent
    extends SafeRenderManagerHelperComponent {
  _$$SafeRenderManagerHelperProps$JsMap _cachedTypedProps;

  @override
  _$$SafeRenderManagerHelperProps$JsMap get props => _cachedTypedProps;

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
  _$$SafeRenderManagerHelperProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$SafeRenderManagerHelperProps$JsMap(backingMap);

  @override
  _$$SafeRenderManagerHelperProps typedPropsFactory(Map backingMap) =>
      _$$SafeRenderManagerHelperProps(backingMap);

  _$$SafeRenderManagerHelperState$JsMap _cachedTypedState;
  @override
  _$$SafeRenderManagerHelperState$JsMap get state => _cachedTypedState;

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
  _$$SafeRenderManagerHelperState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$SafeRenderManagerHelperState$JsMap(backingMap);

  @override
  _$$SafeRenderManagerHelperState typedStateFactory(Map backingMap) =>
      _$$SafeRenderManagerHelperState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SafeRenderManagerHelperProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForSafeRenderManagerHelperProps
  ];
}
