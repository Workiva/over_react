// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'suspense_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SuspensePropsMixin on SuspensePropsMixin {
  static const PropsMeta meta = _$metaForSuspensePropsMixin;
  @override
  dynamic get fallback =>
      (props[_$key__fallback__SuspensePropsMixin] ?? null) as dynamic;
  @override
  set fallback(dynamic value) =>
      props[_$key__fallback__SuspensePropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__fallback__SuspensePropsMixin =
      PropDescriptor(_$key__fallback__SuspensePropsMixin);
  static const String _$key__fallback__SuspensePropsMixin = 'fallback';

  static const List<PropDescriptor> $props = [
    _$prop__fallback__SuspensePropsMixin
  ];
  static const List<String> $propKeys = [_$key__fallback__SuspensePropsMixin];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSuspensePropsMixin = PropsMeta(
  fields: $SuspensePropsMixin.$props,
  keys: $SuspensePropsMixin.$propKeys,
);

final UiFactoryConfig<_$$SuspenseProps> _$SuspenseConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$SuspenseProps(map),
      jsMap: (map) => _$$SuspenseProps(map),
    ),
    displayName: 'Suspense');

@Deprecated(r'Use the private variable, _$SuspenseConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$SuspenseProps> $SuspenseConfig = _$SuspenseConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SuspenseProps extends UiProps
    with
        SuspensePropsMixin,
        // If this generated mixin is undefined, it's likely because SuspensePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SuspensePropsMixin, and check that $SuspensePropsMixin is exported/imported properly.
        $SuspensePropsMixin
    implements
        SuspenseProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SuspenseProps(Map? backingMap) : this._props = {} {
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
        // If this generated mixin is undefined, it's likely because SuspensePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SuspensePropsMixin, and check that $SuspensePropsMixin is exported/imported properly.
        SuspensePropsMixin: $SuspensePropsMixin.meta,
      });
}
