// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_with_state.dart';

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
    ? _$$BasicProps(JsBackedMap())
    : _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicProps extends UiProps
    with
        BasicProps,
        $BasicProps // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BasicProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

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
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BasicState extends UiState
    with
        BasicState,
        $BasicState // If this generated mixin is undefined, it's likely because BasicState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of BasicState.
{
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$BasicComponent extends BasicComponent {
  _$$BasicProps _cachedTypedProps;

  @override
  _$$BasicProps get props => _cachedTypedProps;

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
  _$$BasicProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicProps(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) => _$$BasicProps(backingMap);

  _$$BasicState _cachedTypedState;
  @override
  _$$BasicState get state => _cachedTypedState;

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
  _$$BasicState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$BasicState(backingMap);

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
        // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BasicProps.
        BasicProps: $BasicProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicProps on BasicProps {
  static const PropsMeta meta = _$metaForBasicProps;
  @override
  String get basicProp =>
      props[_$key__basicProp__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicProp(String value) => props[_$key__basicProp__BasicProps] = value;
  @override
  String get basic1 =>
      props[_$key__basic1__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic1(String value) => props[_$key__basic1__BasicProps] = value;
  @override
  String get basic2 =>
      props[_$key__basic2__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic2(String value) => props[_$key__basic2__BasicProps] = value;
  @override
  String get basic3 =>
      props[_$key__basic3__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic3(String value) => props[_$key__basic3__BasicProps] = value;
  @override
  String get basic4 =>
      props[_$key__basic4__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic4(String value) => props[_$key__basic4__BasicProps] = value;
  @override
  String get basic5 =>
      props[_$key__basic5__BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basic5(String value) => props[_$key__basic5__BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp__BasicProps =
      PropDescriptor(_$key__basicProp__BasicProps);
  static const PropDescriptor _$prop__basic1__BasicProps =
      PropDescriptor(_$key__basic1__BasicProps);
  static const PropDescriptor _$prop__basic2__BasicProps =
      PropDescriptor(_$key__basic2__BasicProps);
  static const PropDescriptor _$prop__basic3__BasicProps =
      PropDescriptor(_$key__basic3__BasicProps);
  static const PropDescriptor _$prop__basic4__BasicProps =
      PropDescriptor(_$key__basic4__BasicProps);
  static const PropDescriptor _$prop__basic5__BasicProps =
      PropDescriptor(_$key__basic5__BasicProps);
  static const String _$key__basicProp__BasicProps = 'BasicProps.basicProp';
  static const String _$key__basic1__BasicProps = 'BasicProps.basic1';
  static const String _$key__basic2__BasicProps = 'BasicProps.basic2';
  static const String _$key__basic3__BasicProps = 'BasicProps.basic3';
  static const String _$key__basic4__BasicProps = 'BasicProps.basic4';
  static const String _$key__basic5__BasicProps = 'BasicProps.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp__BasicProps,
    _$prop__basic1__BasicProps,
    _$prop__basic2__BasicProps,
    _$prop__basic3__BasicProps,
    _$prop__basic4__BasicProps,
    _$prop__basic5__BasicProps
  ];
  static const List<String> $propKeys = [
    _$key__basicProp__BasicProps,
    _$key__basic1__BasicProps,
    _$key__basic2__BasicProps,
    _$key__basic3__BasicProps,
    _$key__basic4__BasicProps,
    _$key__basic5__BasicProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: $BasicProps.$props,
  keys: $BasicProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasicState on BasicState {
  static const StateMeta meta = _$metaForBasicState;
  @override
  String get basicState =>
      state[_$key__basicState__BasicState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set basicState(String value) => state[_$key__basicState__BasicState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState__BasicState =
      StateDescriptor(_$key__basicState__BasicState);
  static const String _$key__basicState__BasicState = 'BasicState.basicState';

  static const List<StateDescriptor> $state = [_$prop__basicState__BasicState];
  static const List<String> $stateKeys = [_$key__basicState__BasicState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForBasicState = StateMeta(
  fields: $BasicState.$state,
  keys: $BasicState.$stateKeys,
);
