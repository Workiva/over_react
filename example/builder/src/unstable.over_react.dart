// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'unstable.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UnstableTestProps on UnstableTestProps {
  static const PropsMeta meta = _$metaForUnstableTestProps;
  @override
  bool get legitProp =>
      (props[_$key__legitProp__UnstableTestProps] ?? null) as bool;
  @override
  set legitProp(bool value) =>
      props[_$key__legitProp__UnstableTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__legitProp__UnstableTestProps =
      PropDescriptor(_$key__legitProp__UnstableTestProps);
  static const String _$key__legitProp__UnstableTestProps =
      'UnstableTestProps.legitProp';

  static const List<PropDescriptor> $props = [
    _$prop__legitProp__UnstableTestProps
  ];
  static const List<String> $propKeys = [_$key__legitProp__UnstableTestProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUnstableTestProps = PropsMeta(
  fields: $UnstableTestProps.$props,
  keys: $UnstableTestProps.$propKeys,
);

final UiFactoryConfig<_$$UnstableTestProps> _$UnstableTestConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UnstableTestProps(map),
          jsMap: (map) => _$$UnstableTestProps$JsMap(map),
        ),
        displayName: 'UnstableTest');

@Deprecated(r'Use the private variable, _$UnstableTestConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$UnstableTestProps> $UnstableTestConfig =
    _$UnstableTestConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UnstableTestProps extends UnstableUiProps
    with
        UnstableTestProps,
        $UnstableTestProps // If this generated mixin is undefined, it's likely because UnstableTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UnstableTestProps, and check that $UnstableTestProps is exported/imported properly.
{
  _$$UnstableTestProps._();

  factory _$$UnstableTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UnstableTestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$UnstableTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UnstableUiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because UnstableTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UnstableTestProps, and check that $UnstableTestProps is exported/imported properly.
        UnstableTestProps: $UnstableTestProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$UnstableTestProps$PlainMap extends _$$UnstableTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UnstableTestProps$PlainMap(Map backingMap)
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
class _$$UnstableTestProps$JsMap extends _$$UnstableTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UnstableTestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
