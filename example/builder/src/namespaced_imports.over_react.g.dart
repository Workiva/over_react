// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'namespaced_imports.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: _$Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? _$$BasicProps$JsMap(JsBackedMap())
    : _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicProps extends UiProps
    with
        pm.ExamplePropsMixin,
        pm.$ExamplePropsMixin, // If this generated mixin is undefined, it's likely because pm.ExamplePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of pm.ExamplePropsMixin, and check that pm.$ExamplePropsMixin is exported/imported properly.
        BasicPropsMixin,
        $BasicPropsMixin // If this generated mixin is undefined, it's likely because BasicPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicPropsMixin, and check that $BasicPropsMixin is exported/imported properly.
    implements
        BasicProps {
  _$$BasicProps._();

  factory _$$BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsInstanceMeta get $meta => PropsInstanceMeta({
        // If this generated mixin is undefined, it's likely because pm.ExamplePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of pm.ExamplePropsMixin, and check that pm.$ExamplePropsMixin is exported/imported properly.
        pm.ExamplePropsMixin: pm.$ExamplePropsMixin.meta,
        // If this generated mixin is undefined, it's likely because BasicPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicPropsMixin, and check that $BasicPropsMixin is exported/imported properly.
        BasicPropsMixin: $BasicPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicProps$PlainMap extends _$$BasicProps {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicProps$JsMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$BasicState extends UiState
    with
        sm.ExampleStateMixin,
        sm.$ExampleStateMixin, // If this generated mixin is undefined, it's likely because sm.ExampleStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of sm.ExampleStateMixin, and check that sm.$ExampleStateMixin is exported/imported properly.
        BasicStateMixin,
        $BasicStateMixin // If this generated mixin is undefined, it's likely because BasicStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicStateMixin, and check that $BasicStateMixin is exported/imported properly.
    implements
        BasicState {
  _$$BasicState._();

  factory _$$BasicState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicState$JsMap(backingMap);
    } else {
      return _$$BasicState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicState$PlainMap extends _$$BasicState {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicState$JsMap extends _$$BasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState$JsMap(JsBackedMap backingMap)
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
      _$$BasicProps$JsMap(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) => _$$BasicProps(backingMap);

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
      _$$BasicState$JsMap(backingMap);

  @override
  _$$BasicState typedStateFactory(Map backingMap) => _$$BasicState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by BasicProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because pm.ExamplePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of pm.ExamplePropsMixin, and check that pm.$ExamplePropsMixin is exported/imported properly.
        pm.ExamplePropsMixin: pm.$ExamplePropsMixin.meta,
        // If this generated mixin is undefined, it's likely because BasicPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasicPropsMixin, and check that $BasicPropsMixin is exported/imported properly.
        BasicPropsMixin: $BasicPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicPropsMixin on BasicPropsMixin {
  static const PropsMeta meta = _$metaForBasicPropsMixin;
  @override
  String get basicProp =>
      props[_$key__basicProp__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicProp(String value) =>
      props[_$key__basicProp__BasicPropsMixin] = value;
  @override
  String get basic1 =>
      props[_$key__basic1__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic1(String value) => props[_$key__basic1__BasicPropsMixin] = value;
  @override
  String get basic2 =>
      props[_$key__basic2__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic2(String value) => props[_$key__basic2__BasicPropsMixin] = value;
  @override
  String get basic3 =>
      props[_$key__basic3__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic3(String value) => props[_$key__basic3__BasicPropsMixin] = value;
  @override
  String get basic4 =>
      props[_$key__basic4__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic4(String value) => props[_$key__basic4__BasicPropsMixin] = value;
  @override
  String get basic5 =>
      props[_$key__basic5__BasicPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic5(String value) => props[_$key__basic5__BasicPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp__BasicPropsMixin =
      PropDescriptor(_$key__basicProp__BasicPropsMixin);
  static const PropDescriptor _$prop__basic1__BasicPropsMixin =
      PropDescriptor(_$key__basic1__BasicPropsMixin);
  static const PropDescriptor _$prop__basic2__BasicPropsMixin =
      PropDescriptor(_$key__basic2__BasicPropsMixin);
  static const PropDescriptor _$prop__basic3__BasicPropsMixin =
      PropDescriptor(_$key__basic3__BasicPropsMixin);
  static const PropDescriptor _$prop__basic4__BasicPropsMixin =
      PropDescriptor(_$key__basic4__BasicPropsMixin);
  static const PropDescriptor _$prop__basic5__BasicPropsMixin =
      PropDescriptor(_$key__basic5__BasicPropsMixin);
  static const String _$key__basicProp__BasicPropsMixin =
      'BasicPropsMixin.basicProp';
  static const String _$key__basic1__BasicPropsMixin = 'BasicPropsMixin.basic1';
  static const String _$key__basic2__BasicPropsMixin = 'BasicPropsMixin.basic2';
  static const String _$key__basic3__BasicPropsMixin = 'BasicPropsMixin.basic3';
  static const String _$key__basic4__BasicPropsMixin = 'BasicPropsMixin.basic4';
  static const String _$key__basic5__BasicPropsMixin = 'BasicPropsMixin.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp__BasicPropsMixin,
    _$prop__basic1__BasicPropsMixin,
    _$prop__basic2__BasicPropsMixin,
    _$prop__basic3__BasicPropsMixin,
    _$prop__basic4__BasicPropsMixin,
    _$prop__basic5__BasicPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__basicProp__BasicPropsMixin,
    _$key__basic1__BasicPropsMixin,
    _$key__basic2__BasicPropsMixin,
    _$key__basic3__BasicPropsMixin,
    _$key__basic4__BasicPropsMixin,
    _$key__basic5__BasicPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicPropsMixin = PropsMeta(
  fields: $BasicPropsMixin.$props,
  keys: $BasicPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicStateMixin on BasicStateMixin {
  static const StateMeta meta = _$metaForBasicStateMixin;
  @override
  String get basicState =>
      state[_$key__basicState__BasicStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicState(String value) =>
      state[_$key__basicState__BasicStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState__BasicStateMixin =
      StateDescriptor(_$key__basicState__BasicStateMixin);
  static const String _$key__basicState__BasicStateMixin =
      'BasicStateMixin.basicState';

  static const List<StateDescriptor> $state = [
    _$prop__basicState__BasicStateMixin
  ];
  static const List<String> $stateKeys = [_$key__basicState__BasicStateMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForBasicStateMixin = StateMeta(
  fields: $BasicStateMixin.$state,
  keys: $BasicStateMixin.$stateKeys,
);
