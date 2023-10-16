// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'class_names.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class CssClassPropsMixin implements _$CssClassPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForCssClassPropsMixin;

  /// String of space-delimited CSS classes to be added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [classNameBlacklist] prop (see
  /// `UiComponent.forwardingClassNameBuilder`).
  ///
  /// <!-- Generated from [_$CssClassPropsMixin.className] -->
  @override
  String? get className =>
      (props[_$key__className___$CssClassPropsMixin] ?? null) as String?;

  /// String of space-delimited CSS classes to be added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [classNameBlacklist] prop (see
  /// `UiComponent.forwardingClassNameBuilder`).
  ///
  /// <!-- Generated from [_$CssClassPropsMixin.className] -->
  @override
  set className(String? value) =>
      props[_$key__className___$CssClassPropsMixin] = value;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [className] prop (see
  /// `UiComponent.forwardingClassNameBuilder`).
  ///
  /// <!-- Generated from [_$CssClassPropsMixin.classNameBlacklist] -->
  @override
  String? get classNameBlacklist =>
      (props[_$key__classNameBlacklist___$CssClassPropsMixin] ?? null)
          as String?;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [className] prop (see
  /// `UiComponent.forwardingClassNameBuilder`).
  ///
  /// <!-- Generated from [_$CssClassPropsMixin.classNameBlacklist] -->
  @override
  set classNameBlacklist(String? value) =>
      props[_$key__classNameBlacklist___$CssClassPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__className___$CssClassPropsMixin =
      PropDescriptor(_$key__className___$CssClassPropsMixin);
  static const PropDescriptor _$prop__classNameBlacklist___$CssClassPropsMixin =
      PropDescriptor(_$key__classNameBlacklist___$CssClassPropsMixin);
  static const String _$key__className___$CssClassPropsMixin = 'className';
  static const String _$key__classNameBlacklist___$CssClassPropsMixin =
      'classNameBlacklist';

  static const List<PropDescriptor> $props = [
    _$prop__className___$CssClassPropsMixin,
    _$prop__classNameBlacklist___$CssClassPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__className___$CssClassPropsMixin,
    _$key__classNameBlacklist___$CssClassPropsMixin
  ];
}

const PropsMeta _$metaForCssClassPropsMixin = PropsMeta(
  fields: CssClassPropsMixin.$props,
  keys: CssClassPropsMixin.$propKeys,
);
