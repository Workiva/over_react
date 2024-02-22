// @dart=2.11
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'flux_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FluxUiPropsMixin<ActionsT, StoresT>
    on FluxUiPropsMixin<ActionsT, StoresT> {
  static const PropsMeta meta = _$metaForFluxUiPropsMixin;
  @override
  @override
  ActionsT get actions =>
      (props[_$key__actions__FluxUiPropsMixin] ?? null) as ActionsT;
  @override
  @override
  set actions(ActionsT value) =>
      props[_$key__actions__FluxUiPropsMixin] = value;
  @override
  @override
  StoresT get store =>
      (props[_$key__store__FluxUiPropsMixin] ?? null) as StoresT;
  @override
  @override
  set store(StoresT value) => props[_$key__store__FluxUiPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__actions__FluxUiPropsMixin =
      PropDescriptor(_$key__actions__FluxUiPropsMixin,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__store__FluxUiPropsMixin = PropDescriptor(
      _$key__store__FluxUiPropsMixin,
      isRequired: true,
      isNullable: true);
  static const String _$key__actions__FluxUiPropsMixin =
      'FluxUiPropsMixin.actions';
  static const String _$key__store__FluxUiPropsMixin = 'FluxUiPropsMixin.store';

  static const List<PropDescriptor> $props = [
    _$prop__actions__FluxUiPropsMixin,
    _$prop__store__FluxUiPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__actions__FluxUiPropsMixin,
    _$key__store__FluxUiPropsMixin
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('FluxUiPropsMixin.actions') &&
        !requiredPropNamesToSkipValidation.contains('actions')) {
      throw MissingRequiredPropsError('Required prop `actions` is missing.');
    }

    if (!props.containsKey('FluxUiPropsMixin.store') &&
        !requiredPropNamesToSkipValidation.contains('store')) {
      throw MissingRequiredPropsError('Required prop `store` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFluxUiPropsMixin = PropsMeta(
  fields: $FluxUiPropsMixin.$props,
  keys: $FluxUiPropsMixin.$propKeys,
);
