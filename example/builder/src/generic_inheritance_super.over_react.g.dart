// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'generic_inheritance_super.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $GenericSuperComponentFactory = registerComponent2(
  () => _$GenericSuperComponent(),
  builderFactory: _$GenericSuper,
  componentClass: GenericSuperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSuper',
);

_$$GenericSuperProps _$GenericSuper([Map backingProps]) => backingProps == null
    ? _$$GenericSuperProps$JsMap(JsBackedMap())
    : _$$GenericSuperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$GenericSuperProps extends UiProps
    with
        GenericSuperPropsMixin,
        $GenericSuperPropsMixin // If this generated mixin is undefined, it's likely because GenericSuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of GenericSuperPropsMixin, and check that $GenericSuperPropsMixin is exported/imported properly.
    implements
        GenericSuperProps {
  _$$GenericSuperProps._();

  factory _$$GenericSuperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSuperProps$JsMap(backingMap);
    } else {
      return _$$GenericSuperProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $GenericSuperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsInstanceMeta get $meta => PropsInstanceMeta({
        // If this generated mixin is undefined, it's likely because GenericSuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of GenericSuperPropsMixin, and check that $GenericSuperPropsMixin is exported/imported properly.
        GenericSuperPropsMixin: $GenericSuperPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$GenericSuperProps$PlainMap extends _$$GenericSuperProps {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$GenericSuperProps$JsMap extends _$$GenericSuperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$GenericSuperStateMixin extends UiState
    with
        GenericSuperStateMixin,
        $GenericSuperStateMixin // If this generated mixin is undefined, it's likely because GenericSuperStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of GenericSuperStateMixin, and check that $GenericSuperStateMixin is exported/imported properly.
{
  _$$GenericSuperStateMixin._();

  factory _$$GenericSuperStateMixin(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$GenericSuperStateMixin$JsMap(backingMap);
    } else {
      return _$$GenericSuperStateMixin$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$GenericSuperStateMixin$PlainMap extends _$$GenericSuperStateMixin {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperStateMixin$PlainMap(Map backingMap)
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
class _$$GenericSuperStateMixin$JsMap extends _$$GenericSuperStateMixin {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSuperStateMixin$JsMap(JsBackedMap backingMap)
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
      _$$GenericSuperProps$JsMap(backingMap);

  @override
  _$$GenericSuperProps typedPropsFactory(Map backingMap) =>
      _$$GenericSuperProps(backingMap);

  _$$GenericSuperStateMixin$JsMap _cachedTypedState;
  @override
  _$$GenericSuperStateMixin$JsMap get state => _cachedTypedState;

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
  _$$GenericSuperStateMixin$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$GenericSuperStateMixin$JsMap(backingMap);

  @override
  _$$GenericSuperStateMixin typedStateFactory(Map backingMap) =>
      _$$GenericSuperStateMixin(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by GenericSuperProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because GenericSuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of GenericSuperPropsMixin, and check that $GenericSuperPropsMixin is exported/imported properly.
        GenericSuperPropsMixin: $GenericSuperPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $GenericSuperPropsMixin on GenericSuperPropsMixin {
  static const PropsMeta meta = _$metaForGenericSuperPropsMixin;
  @override
  String get otherSuperProp =>
      props[_$key__otherSuperProp__GenericSuperPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set otherSuperProp(String value) =>
      props[_$key__otherSuperProp__GenericSuperPropsMixin] = value;
  @override
  String get superProp =>
      props[_$key__superProp__GenericSuperPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superProp(String value) =>
      props[_$key__superProp__GenericSuperPropsMixin] = value;
  @override
  String get superProp1 =>
      props[_$key__superProp1__GenericSuperPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superProp1(String value) =>
      props[_$key__superProp1__GenericSuperPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__otherSuperProp__GenericSuperPropsMixin =
      PropDescriptor(_$key__otherSuperProp__GenericSuperPropsMixin);
  static const PropDescriptor _$prop__superProp__GenericSuperPropsMixin =
      PropDescriptor(_$key__superProp__GenericSuperPropsMixin);
  static const PropDescriptor _$prop__superProp1__GenericSuperPropsMixin =
      PropDescriptor(_$key__superProp1__GenericSuperPropsMixin);
  static const String _$key__otherSuperProp__GenericSuperPropsMixin =
      'GenericSuperPropsMixin.otherSuperProp';
  static const String _$key__superProp__GenericSuperPropsMixin =
      'GenericSuperPropsMixin.superProp';
  static const String _$key__superProp1__GenericSuperPropsMixin =
      'GenericSuperPropsMixin.superProp1';

  static const List<PropDescriptor> $props = [
    _$prop__otherSuperProp__GenericSuperPropsMixin,
    _$prop__superProp__GenericSuperPropsMixin,
    _$prop__superProp1__GenericSuperPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__otherSuperProp__GenericSuperPropsMixin,
    _$key__superProp__GenericSuperPropsMixin,
    _$key__superProp1__GenericSuperPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForGenericSuperPropsMixin = PropsMeta(
  fields: $GenericSuperPropsMixin.$props,
  keys: $GenericSuperPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $GenericSuperStateMixin on GenericSuperStateMixin {
  static const StateMeta meta = _$metaForGenericSuperStateMixin;
  @override
  String get superState =>
      state[_$key__superState__GenericSuperStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set superState(String value) =>
      state[_$key__superState__GenericSuperStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__superState__GenericSuperStateMixin =
      StateDescriptor(_$key__superState__GenericSuperStateMixin);
  static const String _$key__superState__GenericSuperStateMixin =
      'GenericSuperStateMixin.superState';

  static const List<StateDescriptor> $state = [
    _$prop__superState__GenericSuperStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__superState__GenericSuperStateMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForGenericSuperStateMixin = StateMeta(
  fields: $GenericSuperStateMixin.$state,
  keys: $GenericSuperStateMixin.$stateKeys,
);
