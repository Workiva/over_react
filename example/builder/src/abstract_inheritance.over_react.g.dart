// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'abstract_inheritance.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $SubComponentFactory = registerComponent2(
  () => _$SubComponent(),
  builderFactory: Sub,
  componentClass: SubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Sub',
);

_$$SubProps _$Sub([Map backingProps]) => backingProps == null
    ? _$$SubProps$JsMap(JsBackedMap())
    : _$$SubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SubProps extends UiProps
    with
        SuperPropsMixin,
        $SuperPropsMixin, // If this generated mixin is undefined, it's likely because SuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SuperPropsMixin.
        SubPropsMixin,
        $SubPropsMixin // If this generated mixin is undefined, it's likely because SubPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SubPropsMixin.
    implements
        SubProps {
  _$$SubProps._();

  factory _$$SubProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubProps$JsMap(backingMap);
    } else {
      return _$$SubProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $SubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SubProps$PlainMap extends _$$SubProps {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SubProps$JsMap extends _$$SubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SubState extends UiState
    with
        SuperStateMixin,
        $SuperStateMixin, // If this generated mixin is undefined, it's likely because SuperStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of SuperStateMixin.
        SubStateMixin,
        $SubStateMixin // If this generated mixin is undefined, it's likely because SubStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of SubStateMixin.
    implements
        SubState {
  _$$SubState._();

  factory _$$SubState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SubState$JsMap(backingMap);
    } else {
      return _$$SubState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SubState$PlainMap extends _$$SubState {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SubState$JsMap extends _$$SubState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SubState$JsMap(JsBackedMap backingMap)
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
      _$$SubProps$JsMap(backingMap);

  @override
  _$$SubProps typedPropsFactory(Map backingMap) => _$$SubProps(backingMap);

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
      _$$SubState$JsMap(backingMap);

  @override
  _$$SubState typedStateFactory(Map backingMap) => _$$SubState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from SubProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because SuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SuperPropsMixin.
        SuperPropsMixin: $SuperPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because SubPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of SubPropsMixin.
        SubPropsMixin: $SubPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SuperPropsMixin on SuperPropsMixin {
  static const PropsMeta meta = _$metaForSuperPropsMixin;
  @override
  String get superProp =>
      props[_$key__superProp__SuperPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superProp(String value) =>
      props[_$key__superProp__SuperPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__superProp__SuperPropsMixin =
      PropDescriptor(_$key__superProp__SuperPropsMixin);
  static const String _$key__superProp__SuperPropsMixin =
      'SuperPropsMixin.superProp';

  static const List<PropDescriptor> $props = [
    _$prop__superProp__SuperPropsMixin
  ];
  static const List<String> $propKeys = [_$key__superProp__SuperPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSuperPropsMixin = PropsMeta(
  fields: $SuperPropsMixin.$props,
  keys: $SuperPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SubPropsMixin on SubPropsMixin {
  static const PropsMeta meta = _$metaForSubPropsMixin;
  @override
  String get subProp =>
      props[_$key__subProp__SubPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set subProp(String value) => props[_$key__subProp__SubPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp__SubPropsMixin =
      PropDescriptor(_$key__subProp__SubPropsMixin);
  static const String _$key__subProp__SubPropsMixin = 'SubPropsMixin.subProp';

  static const List<PropDescriptor> $props = [_$prop__subProp__SubPropsMixin];
  static const List<String> $propKeys = [_$key__subProp__SubPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSubPropsMixin = PropsMeta(
  fields: $SubPropsMixin.$props,
  keys: $SubPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SuperStateMixin on SuperStateMixin {
  static const StateMeta meta = _$metaForSuperStateMixin;
  @override
  String get superState =>
      state[_$key__superState__SuperStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superState(String value) =>
      state[_$key__superState__SuperStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__superState__SuperStateMixin =
      StateDescriptor(_$key__superState__SuperStateMixin);
  static const String _$key__superState__SuperStateMixin =
      'SuperStateMixin.superState';

  static const List<StateDescriptor> $state = [
    _$prop__superState__SuperStateMixin
  ];
  static const List<String> $stateKeys = [_$key__superState__SuperStateMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForSuperStateMixin = StateMeta(
  fields: $SuperStateMixin.$state,
  keys: $SuperStateMixin.$stateKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SubStateMixin on SubStateMixin {
  static const StateMeta meta = _$metaForSubStateMixin;
  @override
  String get subState =>
      state[_$key__subState__SubStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set subState(String value) => state[_$key__subState__SubStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__subState__SubStateMixin =
      StateDescriptor(_$key__subState__SubStateMixin);
  static const String _$key__subState__SubStateMixin = 'SubStateMixin.subState';

  static const List<StateDescriptor> $state = [_$prop__subState__SubStateMixin];
  static const List<String> $stateKeys = [_$key__subState__SubStateMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForSubStateMixin = StateMeta(
  fields: $SubStateMixin.$state,
  keys: $SubStateMixin.$stateKeys,
);
