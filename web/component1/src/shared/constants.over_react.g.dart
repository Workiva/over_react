// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'constants.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class AbstractInputPropsMixin implements _$AbstractInputPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForAbstractInputPropsMixin;
  @override
  String? get id;

  /// The HTML `name` attribute to be applied to `<input>`.
  ///
  /// If unspecified, [AbstractInputStateMixin.name] will be generated.
  ///
  /// _Proxies [DomPropsMixin.name]._
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.name] -->
  @override
  @Accessor(keyNamespace: '')
  String? get name =>
      (props[_$key__name___$AbstractInputPropsMixin] ?? null) as String?;

  /// The HTML `name` attribute to be applied to `<input>`.
  ///
  /// If unspecified, [AbstractInputStateMixin.name] will be generated.
  ///
  /// _Proxies [DomPropsMixin.name]._
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.name] -->
  @override
  @Accessor(keyNamespace: '')
  set name(String? value) =>
      props[_$key__name___$AbstractInputPropsMixin] = value;

  /// The value of the input. Setting this will make the input's value _controlled_; it will not update automatically in
  /// response to user input, but instead will always render the value of this prop.
  ///
  /// See: [React Controlled Components](https://facebook.github.io/react/docs/forms.html#controlled-components)
  ///
  /// _Proxies [DomPropsMixin.value]._
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.value] -->
  @override
  @Accessor(keyNamespace: '')
  dynamic get value =>
      (props[_$key__value___$AbstractInputPropsMixin] ?? null) as dynamic;

  /// The value of the input. Setting this will make the input's value _controlled_; it will not update automatically in
  /// response to user input, but instead will always render the value of this prop.
  ///
  /// See: [React Controlled Components](https://facebook.github.io/react/docs/forms.html#controlled-components)
  ///
  /// _Proxies [DomPropsMixin.value]._
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.value] -->
  @override
  @Accessor(keyNamespace: '')
  set value(dynamic value) =>
      props[_$key__value___$AbstractInputPropsMixin] = value;

  /// The type of "toggle" behavior an HTML `<input>` should exhibit:
  ///
  /// * [ToggleBehaviorType.CHECKBOX] - More than one can be active at once.
  /// * [ToggleBehaviorType.RADIO] - Only one can be active at once.
  ///
  /// Default: [ToggleBehaviorType.CHECKBOX]
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.toggleType] -->
  @override
  ToggleBehaviorType? get toggleType =>
      (props[_$key__toggleType___$AbstractInputPropsMixin] ?? null)
          as ToggleBehaviorType?;

  /// The type of "toggle" behavior an HTML `<input>` should exhibit:
  ///
  /// * [ToggleBehaviorType.CHECKBOX] - More than one can be active at once.
  /// * [ToggleBehaviorType.RADIO] - Only one can be active at once.
  ///
  /// Default: [ToggleBehaviorType.CHECKBOX]
  ///
  /// <!-- Generated from [_$AbstractInputPropsMixin.toggleType] -->
  @override
  set toggleType(ToggleBehaviorType? value) =>
      props[_$key__toggleType___$AbstractInputPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__name___$AbstractInputPropsMixin =
      PropDescriptor(_$key__name___$AbstractInputPropsMixin);
  static const PropDescriptor _$prop__value___$AbstractInputPropsMixin =
      PropDescriptor(_$key__value___$AbstractInputPropsMixin);
  static const PropDescriptor _$prop__toggleType___$AbstractInputPropsMixin =
      PropDescriptor(_$key__toggleType___$AbstractInputPropsMixin);
  static const String _$key__name___$AbstractInputPropsMixin = 'name';
  static const String _$key__value___$AbstractInputPropsMixin = 'value';
  static const String _$key__toggleType___$AbstractInputPropsMixin =
      'AbstractInputPropsMixin.toggleType';

  static const List<PropDescriptor> $props = [
    _$prop__name___$AbstractInputPropsMixin,
    _$prop__value___$AbstractInputPropsMixin,
    _$prop__toggleType___$AbstractInputPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__name___$AbstractInputPropsMixin,
    _$key__value___$AbstractInputPropsMixin,
    _$key__toggleType___$AbstractInputPropsMixin
  ];
}

const PropsMeta _$metaForAbstractInputPropsMixin = PropsMeta(
  fields: AbstractInputPropsMixin.$props,
  keys: AbstractInputPropsMixin.$propKeys,
);

abstract class AbstractInputStateMixin implements _$AbstractInputStateMixin {
  @override
  Map get state;

  static const StateMeta meta = _$metaForAbstractInputStateMixin;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.id] prop is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML ids are needed in inputs for proper label linking and accessibility support,
  /// so this state value ensures there's always a valid ID value to use.
  ///
  /// <!-- Generated from [_$AbstractInputStateMixin.id] -->
  @override
  String? get id =>
      (state[_$key__id___$AbstractInputStateMixin] ?? null) as String?;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.id] prop is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML ids are needed in inputs for proper label linking and accessibility support,
  /// so this state value ensures there's always a valid ID value to use.
  ///
  /// <!-- Generated from [_$AbstractInputStateMixin.id] -->
  @override
  set id(String? value) => state[_$key__id___$AbstractInputStateMixin] = value;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.name] is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML names must be the same for anything that renders an HTML `<input type="radio">` element
  /// so that only one can be selected at a time.
  ///
  /// <!-- Generated from [_$AbstractInputStateMixin.name] -->
  @override
  String? get name =>
      (state[_$key__name___$AbstractInputStateMixin] ?? null) as String?;

  /// An auto-generated GUID, used as a fallback when the [AbstractInputPropsMixin.name] is unspecified,
  /// and saved on the state so it will persist across remounts.
  ///
  /// HTML names must be the same for anything that renders an HTML `<input type="radio">` element
  /// so that only one can be selected at a time.
  ///
  /// <!-- Generated from [_$AbstractInputStateMixin.name] -->
  @override
  set name(String? value) =>
      state[_$key__name___$AbstractInputStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__id___$AbstractInputStateMixin =
      StateDescriptor(_$key__id___$AbstractInputStateMixin);
  static const StateDescriptor _$prop__name___$AbstractInputStateMixin =
      StateDescriptor(_$key__name___$AbstractInputStateMixin);
  static const String _$key__id___$AbstractInputStateMixin =
      'AbstractInputStateMixin.id';
  static const String _$key__name___$AbstractInputStateMixin =
      'AbstractInputStateMixin.name';

  static const List<StateDescriptor> $state = [
    _$prop__id___$AbstractInputStateMixin,
    _$prop__name___$AbstractInputStateMixin
  ];
  static const List<String> $stateKeys = [
    _$key__id___$AbstractInputStateMixin,
    _$key__name___$AbstractInputStateMixin
  ];
}

const StateMeta _$metaForAbstractInputStateMixin = StateMeta(
  fields: AbstractInputStateMixin.$state,
  keys: AbstractInputStateMixin.$stateKeys,
);
