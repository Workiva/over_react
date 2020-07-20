// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'function_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

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
  static const String _$key__basicProp__BasicProps = 'BasicProps.basicProp';
  static const String _$key__basic1__BasicProps = 'BasicProps.basic1';
  static const String _$key__basic2__BasicProps = 'BasicProps.basic2';
  static const String _$key__basic3__BasicProps = 'BasicProps.basic3';
  static const String _$key__basic4__BasicProps = 'BasicProps.basic4';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp__BasicProps,
    _$prop__basic1__BasicProps,
    _$prop__basic2__BasicProps,
    _$prop__basic3__BasicProps,
    _$prop__basic4__BasicProps
  ];
  static const List<String> $propKeys = [
    _$key__basicProp__BasicProps,
    _$key__basic1__BasicProps,
    _$key__basic2__BasicProps,
    _$key__basic3__BasicProps,
    _$key__basic4__BasicProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: $BasicProps.$props,
  keys: $BasicProps.$propKeys,
);

final FunctionComponentConfig<_$$BasicProps> $BasicPropsConfig =
    FunctionComponentConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$BasicProps(map),
          jsMap: (map) => _$$BasicProps$JsMap(map),
        ),
        componentName: 'Basic');

final FunctionComponentConfig<_$$BasicProps> $SimplePropsConfig =
    FunctionComponentConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$BasicProps(map),
          jsMap: (map) => _$$BasicProps$JsMap(map),
        ),
        componentName: 'Simple');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BasicProps extends UiProps
    with
        BasicProps,
        $BasicProps // If this generated mixin is undefined, it's likely because BasicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BasicProps.
{
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

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
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
