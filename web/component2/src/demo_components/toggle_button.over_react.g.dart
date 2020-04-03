// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'toggle_button.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ToggleButtonComponentFactory = registerComponent2(
  () => _$ToggleButtonComponent(),
  builderFactory: _$ToggleButton,
  componentClass: ToggleButtonComponent,
  isWrapper: false,
  parentType: $ButtonComponentFactory,
  /* from `subtypeOf: ButtonComponent` */
  displayName: 'ToggleButton',
);

abstract class _$ToggleButtonPropsAccessorsMixin
    implements _$ToggleButtonProps {
  @override
  Map get props;

  /// Whether the `<input>` rendered by the [ToggleButton] should have focus upon mounting.
  ///
  /// _Proxies [DomProps.autoFocus]._
  ///
  /// Default: `false`
  ///
  /// <!-- Generated from [_$ToggleButtonProps.autoFocus] -->
  @override
  @Accessor(keyNamespace: '')
  bool get autoFocus =>
      props[_$key__autoFocus___$ToggleButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the `<input>` rendered by the [ToggleButton] should have focus upon mounting.
  ///
  /// _Proxies [DomProps.autoFocus]._
  ///
  /// Default: `false`
  ///
  /// <!-- Generated from [_$ToggleButtonProps.autoFocus] -->
  @override
  @Accessor(keyNamespace: '')
  set autoFocus(bool value) =>
      props[_$key__autoFocus___$ToggleButtonProps] = value;

  /// Whether the [ToggleButton] is checked by default.
  ///
  /// Setting this without the setting the [checked] prop to will make the
  /// [ToggleButton] _uncontrolled_; it will initially render checked or unchecked
  /// depending on the value of this prop, and then update itself automatically
  /// in response to user input, like a normal HTML input.
  ///
  /// Related: [checked]
  ///
  /// _Proxies [DomProps.defaultChecked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#uncontrolled-components>.
  ///
  /// <!-- Generated from [_$ToggleButtonProps.defaultChecked] -->
  @override
  @Accessor(keyNamespace: '')
  bool get defaultChecked =>
      props[_$key__defaultChecked___$ToggleButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ToggleButton] is checked by default.
  ///
  /// Setting this without the setting the [checked] prop to will make the
  /// [ToggleButton] _uncontrolled_; it will initially render checked or unchecked
  /// depending on the value of this prop, and then update itself automatically
  /// in response to user input, like a normal HTML input.
  ///
  /// Related: [checked]
  ///
  /// _Proxies [DomProps.defaultChecked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#uncontrolled-components>.
  ///
  /// <!-- Generated from [_$ToggleButtonProps.defaultChecked] -->
  @override
  @Accessor(keyNamespace: '')
  set defaultChecked(bool value) =>
      props[_$key__defaultChecked___$ToggleButtonProps] = value;

  /// Whether the [ToggleButton] is checked.
  ///
  /// Setting this will make the [ToggleButton] _controlled_; it will not update
  /// automatically in response to user input, but instead will always render
  /// checked or unchecked depending on the value of this prop.
  ///
  /// Related: [defaultChecked]
  ///
  /// _Proxies [DomProps.checked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#controlled-components>.
  ///
  /// <!-- Generated from [_$ToggleButtonProps.checked] -->
  @override
  @Accessor(keyNamespace: '')
  bool get checked =>
      props[_$key__checked___$ToggleButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ToggleButton] is checked.
  ///
  /// Setting this will make the [ToggleButton] _controlled_; it will not update
  /// automatically in response to user input, but instead will always render
  /// checked or unchecked depending on the value of this prop.
  ///
  /// Related: [defaultChecked]
  ///
  /// _Proxies [DomProps.checked]._
  ///
  /// See: <https://facebook.github.io/react/docs/forms.html#controlled-components>.
  ///
  /// <!-- Generated from [_$ToggleButtonProps.checked] -->
  @override
  @Accessor(keyNamespace: '')
  set checked(bool value) => props[_$key__checked___$ToggleButtonProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__autoFocus___$ToggleButtonProps =
      PropDescriptor(_$key__autoFocus___$ToggleButtonProps);
  static const PropDescriptor _$prop__defaultChecked___$ToggleButtonProps =
      PropDescriptor(_$key__defaultChecked___$ToggleButtonProps);
  static const PropDescriptor _$prop__checked___$ToggleButtonProps =
      PropDescriptor(_$key__checked___$ToggleButtonProps);
  static const String _$key__autoFocus___$ToggleButtonProps = 'autoFocus';
  static const String _$key__defaultChecked___$ToggleButtonProps =
      'defaultChecked';
  static const String _$key__checked___$ToggleButtonProps = 'checked';

  static const List<PropDescriptor> $props = [
    _$prop__autoFocus___$ToggleButtonProps,
    _$prop__defaultChecked___$ToggleButtonProps,
    _$prop__checked___$ToggleButtonProps
  ];
  static const List<String> $propKeys = [
    _$key__autoFocus___$ToggleButtonProps,
    _$key__defaultChecked___$ToggleButtonProps,
    _$key__checked___$ToggleButtonProps
  ];
}

const PropsMeta _$metaForToggleButtonProps = PropsMeta(
  fields: _$ToggleButtonPropsAccessorsMixin.$props,
  keys: _$ToggleButtonPropsAccessorsMixin.$propKeys,
);

class ToggleButtonProps extends _$ToggleButtonProps
    with _$ToggleButtonPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForToggleButtonProps;
}

_$$ToggleButtonProps _$ToggleButton([Map backingProps]) => backingProps == null
    ? _$$ToggleButtonProps$JsMap(JsBackedMap())
    : _$$ToggleButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ToggleButtonProps extends _$ToggleButtonProps
    with _$ToggleButtonPropsAccessorsMixin
    implements ToggleButtonProps {
  _$$ToggleButtonProps._();

  factory _$$ToggleButtonProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonProps$JsMap(backingMap);
    } else {
      return _$$ToggleButtonProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ToggleButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ToggleButtonProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ToggleButtonProps$PlainMap extends _$$ToggleButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonProps$PlainMap(Map backingMap)
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
class _$$ToggleButtonProps$JsMap extends _$$ToggleButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$ToggleButtonStateAccessorsMixin
    implements _$ToggleButtonState {
  @override
  Map get state;

  /// Tracks if the [ToggleButton] is focused. Determines whether to render with the `js-focus` CSS
  /// class.
  ///
  /// Initial: [ToggleButtonProps.autoFocus]
  ///
  /// <!-- Generated from [_$ToggleButtonState.isFocused] -->
  @override
  bool get isFocused =>
      state[_$key__isFocused___$ToggleButtonState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Tracks if the [ToggleButton] is focused. Determines whether to render with the `js-focus` CSS
  /// class.
  ///
  /// Initial: [ToggleButtonProps.autoFocus]
  ///
  /// <!-- Generated from [_$ToggleButtonState.isFocused] -->
  @override
  set isFocused(bool value) =>
      state[_$key__isFocused___$ToggleButtonState] = value;

  /// Tracks if the [ToggleButton] input is `checked`. Determines whether to render with the `active` CSS class.
  ///
  /// Initial: [ToggleButtonProps.checked] `??` [ToggleButtonProps.defaultChecked] `?? false`
  ///
  /// <!-- Generated from [_$ToggleButtonState.isChecked] -->
  @override
  bool get isChecked =>
      state[_$key__isChecked___$ToggleButtonState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Tracks if the [ToggleButton] input is `checked`. Determines whether to render with the `active` CSS class.
  ///
  /// Initial: [ToggleButtonProps.checked] `??` [ToggleButtonProps.defaultChecked] `?? false`
  ///
  /// <!-- Generated from [_$ToggleButtonState.isChecked] -->
  @override
  set isChecked(bool value) =>
      state[_$key__isChecked___$ToggleButtonState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__isFocused___$ToggleButtonState =
      StateDescriptor(_$key__isFocused___$ToggleButtonState);
  static const StateDescriptor _$prop__isChecked___$ToggleButtonState =
      StateDescriptor(_$key__isChecked___$ToggleButtonState);
  static const String _$key__isFocused___$ToggleButtonState =
      'ToggleButtonState.isFocused';
  static const String _$key__isChecked___$ToggleButtonState =
      'ToggleButtonState.isChecked';

  static const List<StateDescriptor> $state = [
    _$prop__isFocused___$ToggleButtonState,
    _$prop__isChecked___$ToggleButtonState
  ];
  static const List<String> $stateKeys = [
    _$key__isFocused___$ToggleButtonState,
    _$key__isChecked___$ToggleButtonState
  ];
}

const StateMeta _$metaForToggleButtonState = StateMeta(
  fields: _$ToggleButtonStateAccessorsMixin.$state,
  keys: _$ToggleButtonStateAccessorsMixin.$stateKeys,
);

class ToggleButtonState extends _$ToggleButtonState
    with _$ToggleButtonStateAccessorsMixin {
  static const StateMeta meta = _$metaForToggleButtonState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ToggleButtonState extends _$ToggleButtonState
    with _$ToggleButtonStateAccessorsMixin
    implements ToggleButtonState {
  _$$ToggleButtonState._();

  factory _$$ToggleButtonState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ToggleButtonState$JsMap(backingMap);
    } else {
      return _$$ToggleButtonState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ToggleButtonState$PlainMap extends _$$ToggleButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonState$PlainMap(Map backingMap)
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
class _$$ToggleButtonState$JsMap extends _$$ToggleButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ToggleButtonState$JsMap(JsBackedMap backingMap)
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
class _$ToggleButtonComponent extends ToggleButtonComponent {
  _$$ToggleButtonProps$JsMap _cachedTypedProps;

  @override
  _$$ToggleButtonProps$JsMap get props => _cachedTypedProps;

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
  _$$ToggleButtonProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonProps$JsMap(backingMap);

  @override
  _$$ToggleButtonProps typedPropsFactory(Map backingMap) =>
      _$$ToggleButtonProps(backingMap);

  _$$ToggleButtonState$JsMap _cachedTypedState;
  @override
  _$$ToggleButtonState$JsMap get state => _cachedTypedState;

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
  _$$ToggleButtonState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ToggleButtonState$JsMap(backingMap);

  @override
  _$$ToggleButtonState typedStateFactory(Map backingMap) =>
      _$$ToggleButtonState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ToggleButtonProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForToggleButtonProps
  ];
}
