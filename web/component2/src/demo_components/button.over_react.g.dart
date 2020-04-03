// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'button.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonComponentFactory = registerComponent2(
  () => _$ButtonComponent(),
  builderFactory: _$Button,
  componentClass: ButtonComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Button',
);

abstract class _$ButtonPropsAccessorsMixin implements _$ButtonProps {
  @override
  Map get props;

  /// The skin / "context" for the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#examples>.
  ///
  /// Default: [ButtonSkin.PRIMARY]
  ///
  /// <!-- Generated from [_$ButtonProps.skin] -->
  @override
  ButtonSkin get skin =>
      props[_$key__skin___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The skin / "context" for the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#examples>.
  ///
  /// Default: [ButtonSkin.PRIMARY]
  ///
  /// <!-- Generated from [_$ButtonProps.skin] -->
  @override
  set skin(ButtonSkin value) => props[_$key__skin___$ButtonProps] = value;

  /// The size of the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#sizes>.
  ///
  /// Default: [ButtonSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonProps.size] -->
  @override
  ButtonSize get size =>
      props[_$key__size___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The size of the [Button].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#sizes>.
  ///
  /// Default: [ButtonSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonProps.size] -->
  @override
  set size(ButtonSize value) => props[_$key__size___$ButtonProps] = value;

  /// Whether the [Button] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#active-state>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isActive] -->
  @override
  bool get isActive =>
      props[_$key__isActive___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [Button] should appear "active".
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#active-state>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isActive] -->
  @override
  set isActive(bool value) => props[_$key__isActive___$ButtonProps] = value;

  /// Whether the [Button] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#disabled-state>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isDisabled] -->
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled =>
      props[_$key__isDisabled___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [Button] is disabled.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/buttons/#disabled-state>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isDisabled] -->
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  set isDisabled(bool value) => props[_$key__isDisabled___$ButtonProps] = value;

  /// Whether the [Button] is a block level button -- that which spans the full
  /// width of its parent.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isBlock] -->
  @override
  bool get isBlock =>
      props[_$key__isBlock___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [Button] is a block level button -- that which spans the full
  /// width of its parent.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonProps.isBlock] -->
  @override
  set isBlock(bool value) => props[_$key__isBlock___$ButtonProps] = value;

  /// The HTML `href` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  ///
  /// <!-- Generated from [_$ButtonProps.href] -->
  @override
  @Accessor(keyNamespace: '')
  String get href =>
      props[_$key__href___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `href` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.href]_
  ///
  /// <!-- Generated from [_$ButtonProps.href] -->
  @override
  @Accessor(keyNamespace: '')
  set href(String value) => props[_$key__href___$ButtonProps] = value;

  /// The HTML `target` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  ///
  /// <!-- Generated from [_$ButtonProps.target] -->
  @override
  @Accessor(keyNamespace: '')
  String get target =>
      props[_$key__target___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `target` attribute value for the [Button].
  ///
  /// If set, the item will render via [Dom.a].
  ///
  /// _Proxies [DomProps.target]_
  ///
  /// <!-- Generated from [_$ButtonProps.target] -->
  @override
  @Accessor(keyNamespace: '')
  set target(String value) => props[_$key__target___$ButtonProps] = value;

  /// The HTML `type` attribute value for the [Button] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [href] is not set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ///
  /// <!-- Generated from [_$ButtonProps.type] -->
  @override
  ButtonType get type =>
      props[_$key__type___$ButtonProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The HTML `type` attribute value for the [Button] when
  /// rendered via [Dom.button].
  ///
  /// This will only be applied if [href] is not set.
  ///
  /// _Proxies [DomProps.type]_
  ///
  /// Default: [ButtonType.BUTTON]
  ///
  /// <!-- Generated from [_$ButtonProps.type] -->
  @override
  set type(ButtonType value) => props[_$key__type___$ButtonProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__skin___$ButtonProps =
      PropDescriptor(_$key__skin___$ButtonProps);
  static const PropDescriptor _$prop__size___$ButtonProps =
      PropDescriptor(_$key__size___$ButtonProps);
  static const PropDescriptor _$prop__isActive___$ButtonProps =
      PropDescriptor(_$key__isActive___$ButtonProps);
  static const PropDescriptor _$prop__isDisabled___$ButtonProps =
      PropDescriptor(_$key__isDisabled___$ButtonProps);
  static const PropDescriptor _$prop__isBlock___$ButtonProps =
      PropDescriptor(_$key__isBlock___$ButtonProps);
  static const PropDescriptor _$prop__href___$ButtonProps =
      PropDescriptor(_$key__href___$ButtonProps);
  static const PropDescriptor _$prop__target___$ButtonProps =
      PropDescriptor(_$key__target___$ButtonProps);
  static const PropDescriptor _$prop__type___$ButtonProps =
      PropDescriptor(_$key__type___$ButtonProps);
  static const String _$key__skin___$ButtonProps = 'ButtonProps.skin';
  static const String _$key__size___$ButtonProps = 'ButtonProps.size';
  static const String _$key__isActive___$ButtonProps = 'ButtonProps.isActive';
  static const String _$key__isDisabled___$ButtonProps = 'disabled';
  static const String _$key__isBlock___$ButtonProps = 'ButtonProps.isBlock';
  static const String _$key__href___$ButtonProps = 'href';
  static const String _$key__target___$ButtonProps = 'target';
  static const String _$key__type___$ButtonProps = 'ButtonProps.type';

  static const List<PropDescriptor> $props = [
    _$prop__skin___$ButtonProps,
    _$prop__size___$ButtonProps,
    _$prop__isActive___$ButtonProps,
    _$prop__isDisabled___$ButtonProps,
    _$prop__isBlock___$ButtonProps,
    _$prop__href___$ButtonProps,
    _$prop__target___$ButtonProps,
    _$prop__type___$ButtonProps
  ];
  static const List<String> $propKeys = [
    _$key__skin___$ButtonProps,
    _$key__size___$ButtonProps,
    _$key__isActive___$ButtonProps,
    _$key__isDisabled___$ButtonProps,
    _$key__isBlock___$ButtonProps,
    _$key__href___$ButtonProps,
    _$key__target___$ButtonProps,
    _$key__type___$ButtonProps
  ];
}

const PropsMeta _$metaForButtonProps = PropsMeta(
  fields: _$ButtonPropsAccessorsMixin.$props,
  keys: _$ButtonPropsAccessorsMixin.$propKeys,
);

class ButtonProps extends _$ButtonProps with _$ButtonPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForButtonProps;
}

_$$ButtonProps _$Button([Map backingProps]) => backingProps == null
    ? _$$ButtonProps$JsMap(JsBackedMap())
    : _$$ButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ButtonProps extends _$ButtonProps
    with _$ButtonPropsAccessorsMixin
    implements ButtonProps {
  _$$ButtonProps._();

  factory _$$ButtonProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ButtonProps$JsMap(backingMap);
    } else {
      return _$$ButtonProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ButtonProps$PlainMap extends _$$ButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonProps$PlainMap(Map backingMap)
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
class _$$ButtonProps$JsMap extends _$$ButtonProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$ButtonStateAccessorsMixin implements _$ButtonState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForButtonState = StateMeta(
  fields: _$ButtonStateAccessorsMixin.$state,
  keys: _$ButtonStateAccessorsMixin.$stateKeys,
);

class ButtonState extends _$ButtonState with _$ButtonStateAccessorsMixin {
  static const StateMeta meta = _$metaForButtonState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ButtonState extends _$ButtonState
    with _$ButtonStateAccessorsMixin
    implements ButtonState {
  _$$ButtonState._();

  factory _$$ButtonState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ButtonState$JsMap(backingMap);
    } else {
      return _$$ButtonState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ButtonState$PlainMap extends _$$ButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonState$PlainMap(Map backingMap)
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
class _$$ButtonState$JsMap extends _$$ButtonState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonState$JsMap(JsBackedMap backingMap)
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
class _$ButtonComponent extends ButtonComponent {
  _$$ButtonProps$JsMap _cachedTypedProps;

  @override
  _$$ButtonProps$JsMap get props => _cachedTypedProps;

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
  _$$ButtonProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonProps$JsMap(backingMap);

  @override
  _$$ButtonProps typedPropsFactory(Map backingMap) =>
      _$$ButtonProps(backingMap);

  _$$ButtonState$JsMap _cachedTypedState;
  @override
  _$$ButtonState$JsMap get state => _cachedTypedState;

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
  _$$ButtonState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonState$JsMap(backingMap);

  @override
  _$$ButtonState typedStateFactory(Map backingMap) =>
      _$$ButtonState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ButtonProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForButtonProps
  ];
}
