// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:over_react/over_react.dart';

import 'basic_with_state.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent2(
  () => new _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

mixin $BasicPropsMixin implements BasicPropsMixin {
  @override
  Map get props;

  /// <!-- Generated from [_$BasicProps.basicProp] -->
  @override
  String get basicProp =>
      props[_$key__basicProp___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basicProp] -->
  @override
  set basicProp(String value) => props[_$key__basicProp___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic1] -->
  @override
  String get basic1 =>
      props[_$key__basic1___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic1] -->
  @override
  set basic1(String value) => props[_$key__basic1___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic2] -->
  @override
  String get basic2 =>
      props[_$key__basic2___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic2] -->
  @override
  set basic2(String value) => props[_$key__basic2___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic3] -->
  @override
  String get basic3 =>
      props[_$key__basic3___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic3] -->
  @override
  set basic3(String value) => props[_$key__basic3___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic4] -->
  @override
  String get basic4 =>
      props[_$key__basic4___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic4] -->
  @override
  set basic4(String value) => props[_$key__basic4___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic5] -->
  @override
  String get basic5 =>
      props[_$key__basic5___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic5] -->
  @override
  set basic5(String value) => props[_$key__basic5___$BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp___$BasicProps =
      const PropDescriptor(_$key__basicProp___$BasicProps);
  static const PropDescriptor _$prop__basic1___$BasicProps =
      const PropDescriptor(_$key__basic1___$BasicProps);
  static const PropDescriptor _$prop__basic2___$BasicProps =
      const PropDescriptor(_$key__basic2___$BasicProps);
  static const PropDescriptor _$prop__basic3___$BasicProps =
      const PropDescriptor(_$key__basic3___$BasicProps);
  static const PropDescriptor _$prop__basic4___$BasicProps =
      const PropDescriptor(_$key__basic4___$BasicProps);
  static const PropDescriptor _$prop__basic5___$BasicProps =
      const PropDescriptor(_$key__basic5___$BasicProps);
  static const String _$key__basicProp___$BasicProps = 'BasicProps.basicProp';
  static const String _$key__basic1___$BasicProps = 'BasicProps.basic1';
  static const String _$key__basic2___$BasicProps = 'BasicProps.basic2';
  static const String _$key__basic3___$BasicProps = 'BasicProps.basic3';
  static const String _$key__basic4___$BasicProps = 'BasicProps.basic4';
  static const String _$key__basic5___$BasicProps = 'BasicProps.basic5';

  static const List<PropDescriptor> $props = const [
    _$prop__basicProp___$BasicProps,
    _$prop__basic1___$BasicProps,
    _$prop__basic2___$BasicProps,
    _$prop__basic3___$BasicProps,
    _$prop__basic4___$BasicProps,
    _$prop__basic5___$BasicProps
  ];
  static const List<String> $propKeys = const [
    _$key__basicProp___$BasicProps,
    _$key__basic1___$BasicProps,
    _$key__basic2___$BasicProps,
    _$key__basic3___$BasicProps,
    _$key__basic4___$BasicProps,
    _$key__basic5___$BasicProps
  ];
}

const PropsMeta _$metaForBasicProps = const PropsMeta(
  fields: $BasicPropsMixin.$props,
  keys: $BasicPropsMixin.$propKeys,
);

$BasicProps $Basic([Map backingProps]) => backingProps == null
    ? new _$$BasicProps$JsMap(new JsBackedMap())
    : new $BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class $BasicProps extends BasicProps
    with BasicPropsMixin, $BasicPropsMixin {
  $BasicProps._();

  static const PropsMeta meta = _$metaForBasicProps;

  factory $BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$BasicProps$JsMap(backingMap);
    } else {
      return new _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// The backing props map proxied by this class.
  @override
  Map get props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicProps$PlainMap extends $BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$PlainMap(Map backingMap)
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
class _$$BasicProps$JsMap extends $BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $BasicStateMixin implements BasicStateMixin {
  @override
  Map get state;

  /// <!-- Generated from [_$BasicState.basicState] -->
  @override
  String get basicState =>
      state[_$key__basicState___$BasicState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicState.basicState] -->
  @override
  set basicState(String value) =>
      state[_$key__basicState___$BasicState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState___$BasicState =
      const StateDescriptor(_$key__basicState___$BasicState);
  static const String _$key__basicState___$BasicState = 'BasicState.basicState';

  static const List<StateDescriptor> $state = const [
    _$prop__basicState___$BasicState
  ];
  static const List<String> $stateKeys = const [
    _$key__basicState___$BasicState
  ];
}

const StateMeta _$metaForBasicState = const StateMeta(
  fields: $BasicStateMixin.$state,
  keys: $BasicStateMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class $BasicState extends BasicState
    with BasicStateMixin, $BasicStateMixin {
  $BasicState._();

  factory $BasicState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$BasicState$JsMap(backingMap);
    } else {
      return new _$$BasicState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$BasicState$PlainMap extends $BasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState$PlainMap(Map backingMap)
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
class _$$BasicState$JsMap extends $BasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$BasicProps$JsMap(backingMap);

  @override
  $BasicProps typedPropsFactory(Map backingMap) =>
      new $BasicProps(backingMap);

  _$$BasicState$JsMap _cachedTypedState;
  @override
  _$$BasicState$JsMap get state => _cachedTypedState;

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
  _$$BasicState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$BasicState$JsMap(backingMap);

  @override
  $BasicState typedStateFactory(Map backingMap) =>
      new $BasicState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
