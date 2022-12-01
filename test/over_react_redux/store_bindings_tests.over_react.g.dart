// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'store_bindings_tests.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestSelectorProps on TestSelectorProps {
  static const PropsMeta meta = _$metaForTestSelectorProps;
  @override
  void Function(Object selectedValue) get onRender =>
      (props[_$key__onRender__TestSelectorProps] ?? null) as void Function(
          Object selectedValue);
  @override
  set onRender(void Function(Object selectedValue) value) =>
      props[_$key__onRender__TestSelectorProps] = value;
  @override
  bool Function(dynamic next, dynamic prev) get equality =>
      (props[_$key__equality__TestSelectorProps] ?? null) as bool Function(
          dynamic next, dynamic prev);
  @override
  set equality(bool Function(dynamic next, dynamic prev) value) =>
      props[_$key__equality__TestSelectorProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onRender__TestSelectorProps =
      PropDescriptor(_$key__onRender__TestSelectorProps);
  static const PropDescriptor _$prop__equality__TestSelectorProps =
      PropDescriptor(_$key__equality__TestSelectorProps);
  static const String _$key__onRender__TestSelectorProps =
      'TestSelectorProps.onRender';
  static const String _$key__equality__TestSelectorProps =
      'TestSelectorProps.equality';

  static const List<PropDescriptor> $props = [
    _$prop__onRender__TestSelectorProps,
    _$prop__equality__TestSelectorProps
  ];
  static const List<String> $propKeys = [
    _$key__onRender__TestSelectorProps,
    _$key__equality__TestSelectorProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestSelectorProps = PropsMeta(
  fields: $TestSelectorProps.$props,
  keys: $TestSelectorProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestConnectPropsMixin on TestConnectPropsMixin {
  static const PropsMeta meta = _$metaForTestConnectPropsMixin;
  @override
  Object get interestingValue =>
      (props[_$key__interestingValue__TestConnectPropsMixin] ?? null) as Object;
  @override
  set interestingValue(Object value) =>
      props[_$key__interestingValue__TestConnectPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__interestingValue__TestConnectPropsMixin =
      PropDescriptor(_$key__interestingValue__TestConnectPropsMixin);
  static const String _$key__interestingValue__TestConnectPropsMixin =
      'TestConnectPropsMixin.interestingValue';

  static const List<PropDescriptor> $props = [
    _$prop__interestingValue__TestConnectPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__interestingValue__TestConnectPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestConnectPropsMixin = PropsMeta(
  fields: $TestConnectPropsMixin.$props,
  keys: $TestConnectPropsMixin.$propKeys,
);

final UiFactoryConfig<_$$TestSelectorProps> _$TestSelectorConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestSelectorProps(map),
          jsMap: (map) => _$$TestSelectorProps$JsMap(map),
        ),
        displayName: 'TestSelector');

@Deprecated(r'Use the private variable, _$TestSelectorConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestSelectorProps> $TestSelectorConfig =
    _$TestSelectorConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestSelectorProps extends UiProps
    with
        TestSelectorProps,
        $TestSelectorProps // If this generated mixin is undefined, it's likely because TestSelectorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSelectorProps, and check that $TestSelectorProps is exported/imported properly.
{
  _$$TestSelectorProps._();

  factory _$$TestSelectorProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestSelectorProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestSelectorProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestSelectorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSelectorProps, and check that $TestSelectorProps is exported/imported properly.
        TestSelectorProps: $TestSelectorProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestSelectorProps$PlainMap extends _$$TestSelectorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSelectorProps$PlainMap(Map backingMap)
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
class _$$TestSelectorProps$JsMap extends _$$TestSelectorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestSelectorProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$TestConnectProps> _$TestConnectMapViewConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$TestConnectProps(map),
          jsMap: (map) => _$$TestConnectProps$JsMap(map),
        ),
        displayName: 'TestConnectMapView');

@Deprecated(r'Use the private variable, _$TestConnectMapViewConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$TestConnectProps> $TestConnectMapViewConfig =
    _$TestConnectMapViewConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestConnectProps extends UiProps
    with
        TestSelectorProps,
        $TestSelectorProps, // If this generated mixin is undefined, it's likely because TestSelectorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSelectorProps, and check that $TestSelectorProps is exported/imported properly.
        TestConnectPropsMixin,
        $TestConnectPropsMixin // If this generated mixin is undefined, it's likely because TestConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestConnectPropsMixin, and check that $TestConnectPropsMixin is exported/imported properly.
    implements
        TestConnectProps {
  _$$TestConnectProps._();

  factory _$$TestConnectProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestConnectProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestConnectProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestSelectorProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestSelectorProps, and check that $TestSelectorProps is exported/imported properly.
        TestSelectorProps: $TestSelectorProps.meta,
        // If this generated mixin is undefined, it's likely because TestConnectPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestConnectPropsMixin, and check that $TestConnectPropsMixin is exported/imported properly.
        TestConnectPropsMixin: $TestConnectPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestConnectProps$PlainMap extends _$$TestConnectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestConnectProps$PlainMap(Map backingMap)
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
class _$$TestConnectProps$JsMap extends _$$TestConnectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestConnectProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
