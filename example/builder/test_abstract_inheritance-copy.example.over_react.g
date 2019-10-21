// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:over_react/over_react.dart';

import 'abstract_inheritance.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SubComponentFactory = registerComponent2(
  () => new _$SubComponent(),
  builderFactory: Sub,
  componentClass: SubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Sub',
);

mixin $SubPropsMixin implements SubPropsMixin {
  @override
  Map get props;

  /// <!-- Generated from [_$SubProps.subProp] -->
  @override
  String get subProp =>
      props[_$key__subProp___$SubProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SubProps.subProp] -->
  @override
  set subProp(String value) => props[_$key__subProp___$SubProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp___$SubProps =
      const PropDescriptor(_$key__subProp___$SubProps);
  static const String _$key__subProp___$SubProps = 'SubProps.subProp';

  static const List<PropDescriptor> $props = const [
    _$prop__subProp___$SubProps
  ];
  static const List<String> $propKeys = const [_$key__subProp___$SubProps];
}

const PropsMeta _$metaForSubProps = const PropsMeta(
  fields: $SubPropsMixin.$props,
  keys: $SubPropsMixin.$propKeys,
);

$SubProps $Sub([Map backingProps]) => backingProps == null
    ? new _$$SubProps$JsMap(new JsBackedMap())
    : new $SubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class $SubProps extends SubProps
    with SubPropsMixin, $SubPropsMixin {
  $SubProps._();

  static const PropsMeta meta = _$metaForSubProps;

  factory $SubProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$SubProps$JsMap(backingMap);
    } else {
      return new _$$SubProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SubProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$SubProps$PlainMap extends $SubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubProps$PlainMap(Map backingMap)
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
class _$$SubProps$JsMap extends $SubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $SubStateMixin implements SubStateMixin {
  @override
  Map get state;

  /// <!-- Generated from [_$SubState.subState] -->
  @override
  String get subState =>
      state[_$key__subState___$SubState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SubState.subState] -->
  @override
  set subState(String value) => state[_$key__subState___$SubState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__subState___$SubState =
      const StateDescriptor(_$key__subState___$SubState);
  static const String _$key__subState___$SubState = 'SubState.subState';

  static const List<StateDescriptor> $state = const [
    _$prop__subState___$SubState
  ];
  static const List<String> $stateKeys = const [_$key__subState___$SubState];
}

const StateMeta _$metaForSubState = const StateMeta(
  fields: $SubStateMixin.$state,
  keys: $SubStateMixin.$stateKeys,
);


// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class $SubState extends SubState
    with SubStateMixin, $SubStateMixin {
  $SubState._();

  static const StateMeta meta = _$metaForSubState;

  factory $SubState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$SubState$JsMap(backingMap);
    } else {
      return new _$$SubState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$SubState$PlainMap extends $SubState
  with SubStateMixin, $SubStateMixin {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubState$PlainMap(Map backingMap)
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
class _$$SubState$JsMap extends $SubState
    with SubStateMixin, $SubStateMixin {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubState$JsMap(JsBackedMap backingMap)
      : this._state = new JsBackedMap(),
        super._() {
    this._state = backingMap ?? new JsBackedMap();
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
class _$SubComponent extends SubComponent {
  _$$SubProps$JsMap _cachedTypedProps;

  @override
  _$$SubProps$JsMap get props => _cachedTypedProps;

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
  _$$SubProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$SubProps$JsMap(backingMap);

  @override
  $SubProps typedPropsFactory(Map backingMap) => new $SubProps(backingMap);

  _$$SubState$JsMap _cachedTypedState;
  @override
  _$$SubState$JsMap get state => _cachedTypedState;

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
  _$$SubState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$SubState$JsMap(backingMap);

  @override
  $SubState typedStateFactory(Map backingMap) => new $SubState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForSubProps];
}

mixin $SuperPropsMixin implements SuperPropsMixin {
  @override
  Map get props;

  /// <!-- Generated from [_$SuperProps.superProp] -->
  @override
  String get superProp =>
      props[_$key__superProp___$SuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SuperProps.superProp] -->
  @override
  set superProp(String value) => props[_$key__superProp___$SuperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__superProp___$SuperProps =
      const PropDescriptor(_$key__superProp___$SuperProps);
  static const String _$key__superProp___$SuperProps = 'SuperProps.superProp';

  static const List<PropDescriptor> $props = const [
    _$prop__superProp___$SuperProps
  ];
  static const List<String> $propKeys = const [_$key__superProp___$SuperProps];
}

const PropsMeta _$metaForSuperProps = const PropsMeta(
  fields: $SuperPropsMixin.$props,
  keys: $SuperPropsMixin.$propKeys,
);

class $SuperProps extends UiProps with SuperPropsMixin, $SuperPropsMixin {
  static const PropsMeta meta = _$metaForSuperProps;
}

mixin $SuperStateMixin implements SuperStateMixin {

  static const StateMeta meta = _$metaForSuperState;

  @override
  Map get state;

  /// <!-- Generated from [_$SuperState.superState] -->
  @override
  String get superState =>
      state[_$key__superState___$SuperState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$SuperState.superState] -->
  @override
  set superState(String value) =>
      state[_$key__superState___$SuperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__superState___$SuperState =
      const StateDescriptor(_$key__superState___$SuperState);
  static const String _$key__superState___$SuperState = 'SuperState.superState';

  static const List<StateDescriptor> $state = const [
    _$prop__superState___$SuperState
  ];
  static const List<String> $stateKeys = const [
    _$key__superState___$SuperState
  ];
}

const StateMeta _$metaForSuperState = const StateMeta(
  fields: $SuperStateMixin.$state,
  keys: $SuperStateMixin.$stateKeys,
);
