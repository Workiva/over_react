// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'generic_inheritance_sub.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $GenericSubComponentFactory = registerComponent2(
  () => _$GenericSubComponent(),
  builderFactory: _$GenericSub,
  componentClass: GenericSubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSub',
);

_$$GenericSubProps _$GenericSub([Map backingProps]) => backingProps == null
    ? _$$GenericSubProps(JsBackedMap())
    : _$$GenericSubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$GenericSubProps extends UiProps
    with
        GenericSuperPropsMixin,
        $GenericSuperPropsMixin, // If this generated mixin is undefined, it's likely because GenericSuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSuperPropsMixin.
        GenericSubPropsMixin,
        $GenericSubPropsMixin // If this generated mixin is undefined, it's likely because GenericSubPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSubPropsMixin.
    implements
        GenericSubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $GenericSubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$GenericSubState extends UiState
    with
        GenericSuperStateMixin,
        $GenericSuperStateMixin, // If this generated mixin is undefined, it's likely because GenericSuperStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSuperStateMixin.
        GenericSubStateMixin,
        $GenericSubStateMixin // If this generated mixin is undefined, it's likely because GenericSubStateMixin is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSubStateMixin.
    implements
        GenericSubState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubState(Map backingMap) : this._state = {} {
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
class _$GenericSubComponent extends GenericSubComponent {
  _$$GenericSubProps _cachedTypedProps;

  @override
  _$$GenericSubProps get props => _cachedTypedProps;

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
  _$$GenericSubProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$GenericSubProps(backingMap);

  @override
  _$$GenericSubProps typedPropsFactory(Map backingMap) =>
      _$$GenericSubProps(backingMap);

  _$$GenericSubState _cachedTypedState;
  @override
  _$$GenericSubState get state => _cachedTypedState;

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
  _$$GenericSubState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$GenericSubState(backingMap);

  @override
  _$$GenericSubState typedStateFactory(Map backingMap) =>
      _$$GenericSubState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by GenericSubProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because GenericSuperPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSuperPropsMixin.
        GenericSuperPropsMixin: $GenericSuperPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because GenericSubPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of GenericSubPropsMixin.
        GenericSubPropsMixin: $GenericSubPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $GenericSubPropsMixin on GenericSubPropsMixin {
  static const PropsMeta meta = _$metaForGenericSubPropsMixin;
  @override
  String get subProp =>
      props[_$key__subProp__GenericSubPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set subProp(String value) =>
      props[_$key__subProp__GenericSubPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp__GenericSubPropsMixin =
      PropDescriptor(_$key__subProp__GenericSubPropsMixin);
  static const String _$key__subProp__GenericSubPropsMixin =
      'GenericSubPropsMixin.subProp';

  static const List<PropDescriptor> $props = [
    _$prop__subProp__GenericSubPropsMixin
  ];
  static const List<String> $propKeys = [_$key__subProp__GenericSubPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForGenericSubPropsMixin = PropsMeta(
  fields: $GenericSubPropsMixin.$props,
  keys: $GenericSubPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $GenericSubStateMixin on GenericSubStateMixin {
  static const StateMeta meta = _$metaForGenericSubStateMixin;
  @override
  String get subState =>
      state[_$key__subState__GenericSubStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set subState(String value) =>
      state[_$key__subState__GenericSubStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__subState__GenericSubStateMixin =
      StateDescriptor(_$key__subState__GenericSubStateMixin);
  static const String _$key__subState__GenericSubStateMixin =
      'GenericSubStateMixin.subState';

  static const List<StateDescriptor> $state = [
    _$prop__subState__GenericSubStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__subState__GenericSubStateMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForGenericSubStateMixin = StateMeta(
  fields: $GenericSubStateMixin.$state,
  keys: $GenericSubStateMixin.$stateKeys,
);
