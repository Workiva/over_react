// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'lazy_load_me_props.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $LazyLoadMePropsMixin on LazyLoadMePropsMixin {
  static const PropsMeta meta = _$metaForLazyLoadMePropsMixin;
  @override
  num? get initialCount =>
      (props[_$key__initialCount__LazyLoadMePropsMixin] ?? null) as num?;
  @override
  set initialCount(num? value) =>
      props[_$key__initialCount__LazyLoadMePropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__initialCount__LazyLoadMePropsMixin =
      PropDescriptor(_$key__initialCount__LazyLoadMePropsMixin);
  static const String _$key__initialCount__LazyLoadMePropsMixin =
      'initialCount';

  static const List<PropDescriptor> $props = [
    _$prop__initialCount__LazyLoadMePropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__initialCount__LazyLoadMePropsMixin
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForLazyLoadMePropsMixin = PropsMeta(
  fields: $LazyLoadMePropsMixin.$props,
  keys: $LazyLoadMePropsMixin.$propKeys,
);

_$$LazyLoadMePropsMixin _$LazyLoadMePropsMapView([Map? backingProps]) =>
    _$$LazyLoadMePropsMixin(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$LazyLoadMePropsMixin extends UiProps
    with
        LazyLoadMePropsMixin,
        // If this generated mixin is undefined, it's likely because LazyLoadMePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of LazyLoadMePropsMixin, and check that $LazyLoadMePropsMixin is exported/imported properly.
        $LazyLoadMePropsMixin {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LazyLoadMePropsMixin(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because LazyLoadMePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of LazyLoadMePropsMixin, and check that $LazyLoadMePropsMixin is exported/imported properly.
        LazyLoadMePropsMixin: $LazyLoadMePropsMixin.meta,
      });
}
