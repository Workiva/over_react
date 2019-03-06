// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_inheritance_super.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSuperComponentFactory = registerComponent(
    () => new _$GenericSuperComponent(),
    builderFactory: GenericSuper,
    componentClass: GenericSuperComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'GenericSuper');

abstract class _$GenericSuperPropsAccessorsMixin
    implements _$GenericSuperProps {
  @override
  Map get props;

  /// Go to [_$GenericSuperProps.otherSuperProp] to see the source code for this prop
  @override
  String get otherSuperProp =>
      props[_$key__otherSuperProp___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$GenericSuperProps.otherSuperProp] to see the source code for this prop
  @override
  set otherSuperProp(String value) =>
      props[_$key__otherSuperProp___$GenericSuperProps] = value;

  /// Go to [_$GenericSuperProps.superProp] to see the source code for this prop
  @override
  String get superProp =>
      props[_$key__superProp___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$GenericSuperProps.superProp] to see the source code for this prop
  @override
  set superProp(String value) =>
      props[_$key__superProp___$GenericSuperProps] = value;

  /// Go to [_$GenericSuperProps.superProp1] to see the source code for this prop
  @override
  String get superProp1 =>
      props[_$key__superProp1___$GenericSuperProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$GenericSuperProps.superProp1] to see the source code for this prop
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
  fields: _$GenericSuperPropsAccessorsMixin.$props,
  keys: _$GenericSuperPropsAccessorsMixin.$propKeys,
);

class GenericSuperProps extends _$GenericSuperProps
    with _$GenericSuperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForGenericSuperProps;
}

_$$GenericSuperProps _$GenericSuper([Map backingProps]) => backingProps == null
    ? new _$$GenericSuperProps$JsMap(new JsBackedMap())
    : new _$$GenericSuperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$GenericSuperProps extends _$GenericSuperProps
    with _$GenericSuperPropsAccessorsMixin
    implements GenericSuperProps {
  _$$GenericSuperProps._();
  factory _$$GenericSuperProps(Map backingMap) {
    if (backingMap is JsBackedMap) {
      return new _$$GenericSuperProps$PlainMap(backingMap);
    } else {
      return new _$$GenericSuperProps$JsMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $GenericSuperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSuperProps.';
}

class _$$GenericSuperProps$PlainMap extends _$$GenericSuperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

class _$$GenericSuperProps$JsMap extends _$$GenericSuperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
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

abstract class _$GenericSuperStateAccessorsMixin
    implements _$GenericSuperState {
  @override
  Map get state;

  /// Go to [_$GenericSuperState.superState] to see the source code for this prop
  @override
  String get superState =>
      state[_$key__superState___$GenericSuperState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$GenericSuperState.superState] to see the source code for this prop
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
  fields: _$GenericSuperStateAccessorsMixin.$state,
  keys: _$GenericSuperStateAccessorsMixin.$stateKeys,
);

class GenericSuperState extends _$GenericSuperState
    with _$GenericSuperStateAccessorsMixin {
  static const StateMeta meta = _$metaForGenericSuperState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$GenericSuperState extends _$GenericSuperState
    with _$GenericSuperStateAccessorsMixin
    implements GenericSuperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$GenericSuperState(Map backingMap) : this._state = {} {
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
class _$GenericSuperComponent extends GenericSuperComponent {
  @override
  _$$GenericSuperProps typedPropsFactory(Map backingMap) =>
      new _$$GenericSuperProps(backingMap);
  @override
  _$$GenericSuperProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$GenericSuperProps$JsMap(backingMap);

  @override
  _$$GenericSuperState typedStateFactory(Map backingMap) =>
      new _$$GenericSuperState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSuperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForGenericSuperProps
  ];
  _$$GenericSuperProps$JsMap _cachedTypedProps;
  @override
  _$$GenericSuperProps$JsMap get props => _cachedTypedProps;
  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }
}
