// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:over_react/over_react.dart';

import 'generic_inheritance_super.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSuperComponentFactory = registerComponent2(
  () => new _$GenericSuperComponent(),
  builderFactory: GenericSuper,
  componentClass: GenericSuperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSuper',
);

mixin $GenericSuperPropsMixin
    implements GenericSuperProps {
  @override
  Map get props;

  /// <!-- Generated from [_$GenericSuperProps.otherSuperProp] -->
  @override
  String get otherSuperProp =>
      props[_$key__otherSuperProp___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$GenericSuperProps.otherSuperProp] -->
  @override
  set otherSuperProp(String value) =>
      props[_$key__otherSuperProp___$GenericSuperProps] = value;

  /// <!-- Generated from [_$GenericSuperProps.superProp] -->
  @override
  String get superProp =>
      props[_$key__superProp___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$GenericSuperProps.superProp] -->
  @override
  set superProp(String value) =>
      props[_$key__superProp___$GenericSuperProps] = value;

  /// <!-- Generated from [_$GenericSuperProps.superProp1] -->
  @override
  String get superProp1 =>
      props[_$key__superProp1___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$GenericSuperProps.superProp1] -->
  @override
  set superProp1(String value) =>
      props[_$key__superProp1___$GenericSuperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__otherSuperProp___$GenericSuperProps =
      const PropDescriptor(_$key__otherSuperProp___$GenericSuperProps);
  static const PropDescriptor _$prop__superProp___$GenericSuperProps =
      const PropDescriptor(_$key__superProp___$GenericSuperProps);
  static const PropDescriptor _$prop__superProp1___$GenericSuperProps =
      const PropDescriptor(_$key__superProp1___$GenericSuperProps);
  static const String _$key__otherSuperProp___$GenericSuperProps =
      'GenericSuperProps.otherSuperProp';
  static const String _$key__superProp___$GenericSuperProps =
      'GenericSuperProps.superProp';
  static const String _$key__superProp1___$GenericSuperProps =
      'GenericSuperProps.superProp1';

  static const List<PropDescriptor> $props = const [
    _$prop__otherSuperProp___$GenericSuperProps,
    _$prop__superProp___$GenericSuperProps,
    _$prop__superProp1___$GenericSuperProps
  ];
  static const List<String> $propKeys = const [
    _$key__otherSuperProp___$GenericSuperProps,
    _$key__superProp___$GenericSuperProps,
    _$key__superProp1___$GenericSuperProps
  ];
}

const PropsMeta _$metaForGenericSuperProps = const PropsMeta(
  fields: $GenericSuperPropsMixin.$props,
  keys: $GenericSuperPropsMixin.$propKeys,
);

$GenericSuperProps $GenericSuper([Map backingProps]) => backingProps == null
    ? new _$$GenericSuperProps$JsMap(new JsBackedMap())
    : new $GenericSuperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class $GenericSuperProps extends GenericSuperProps
    with GenericSuperPropsMixin, $GenericSuperPropsMixin {
  $GenericSuperProps._();

  static const PropsMeta meta = _$metaForGenericSuperProps;

  factory $GenericSuperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$GenericSuperProps$JsMap(backingMap);
    } else {
      return new _$$GenericSuperProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $GenericSuperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSuperProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$GenericSuperProps$PlainMap extends $GenericSuperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperProps$PlainMap(Map backingMap)
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
class _$$GenericSuperProps$JsMap extends $GenericSuperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

mixin $GenericSuperStateMixin
    implements GenericSuperStateMixin {
  @override
  Map get state;

  /// <!-- Generated from [_$GenericSuperState.superState] -->
  @override
  String get superState =>
      state[_$key__superState___$GenericSuperState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$GenericSuperState.superState] -->
  @override
  set superState(String value) =>
      state[_$key__superState___$GenericSuperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__superState___$GenericSuperState =
      const StateDescriptor(_$key__superState___$GenericSuperState);
  static const String _$key__superState___$GenericSuperState =
      'GenericSuperState.superState';

  static const List<StateDescriptor> $state = const [
    _$prop__superState___$GenericSuperState
  ];
  static const List<String> $stateKeys = const [
    _$key__superState___$GenericSuperState
  ];
}

const StateMeta _$metaForGenericSuperState = const StateMeta(
  fields: $GenericSuperStateMixin.$state,
  keys: $GenericSuperStateMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
class $GenericSuperState extends UiState with GenericSuperStateMixin, $GenericSuperStateMixin {
  $GenericSuperState._();

  static const StateMeta meta = _$metaForGenericSuperState;

  factory $GenericSuperState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$GenericSuperState$JsMap(backingMap);
    } else {
      return new _$$GenericSuperState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$GenericSuperState$PlainMap extends $GenericSuperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperState$PlainMap(Map backingMap)
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
class _$$GenericSuperState$JsMap extends $GenericSuperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperState$JsMap(JsBackedMap backingMap)
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
class _$GenericSuperComponent extends GenericSuperComponent {
  _$$GenericSuperProps$JsMap _cachedTypedProps;

  @override
  _$$GenericSuperProps$JsMap get props => _cachedTypedProps;

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
  _$$GenericSuperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$GenericSuperProps$JsMap(backingMap);

  @override
  $GenericSuperProps typedPropsFactory(Map backingMap) =>
      new $GenericSuperProps(backingMap);

  _$$GenericSuperState$JsMap _cachedTypedState;
  @override
  _$$GenericSuperState$JsMap get state => _cachedTypedState;

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
  _$$GenericSuperState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$GenericSuperState$JsMap(backingMap);

  @override
  $GenericSuperState typedStateFactory(Map backingMap) =>
      new $GenericSuperState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSuperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForGenericSuperProps
  ];
}
