// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'over_react_redux.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class ConnectPropsMixin implements _$ConnectPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForConnectPropsMixin;

  /// <!-- Generated from [_$ConnectPropsMixin.dispatch] -->
  @override
  dynamic Function(dynamic action)? get dispatch =>
      (props[_$key__dispatch___$ConnectPropsMixin] ?? null) as dynamic Function(
          dynamic action)?;

  /// <!-- Generated from [_$ConnectPropsMixin.dispatch] -->
  @override
  set dispatch(dynamic Function(dynamic action)? value) =>
      props[_$key__dispatch___$ConnectPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__dispatch___$ConnectPropsMixin =
      PropDescriptor(_$key__dispatch___$ConnectPropsMixin);
  static const String _$key__dispatch___$ConnectPropsMixin = 'dispatch';

  static const List<PropDescriptor> $props = [
    _$prop__dispatch___$ConnectPropsMixin
  ];
  static const List<String> $propKeys = [_$key__dispatch___$ConnectPropsMixin];
}

const PropsMeta _$metaForConnectPropsMixin = PropsMeta(
  fields: ConnectPropsMixin.$props,
  keys: ConnectPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ReduxProviderPropsMixin on ReduxProviderPropsMixin {
  static const PropsMeta meta = _$metaForReduxProviderPropsMixin;
  @override
  Store get store =>
      (props[_$key__store__ReduxProviderPropsMixin] ?? null) as Store;
  @override
  set store(Store value) =>
      props[_$key__store__ReduxProviderPropsMixin] = value;
  @override
  dynamic get context =>
      (props[_$key__context__ReduxProviderPropsMixin] ?? null) as dynamic;
  @override
  set context(dynamic value) =>
      props[_$key__context__ReduxProviderPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__store__ReduxProviderPropsMixin =
      PropDescriptor(_$key__store__ReduxProviderPropsMixin,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__context__ReduxProviderPropsMixin =
      PropDescriptor(_$key__context__ReduxProviderPropsMixin);
  static const String _$key__store__ReduxProviderPropsMixin = 'store';
  static const String _$key__context__ReduxProviderPropsMixin = 'context';

  static const List<PropDescriptor> $props = [
    _$prop__store__ReduxProviderPropsMixin,
    _$prop__context__ReduxProviderPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__store__ReduxProviderPropsMixin,
    _$key__context__ReduxProviderPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForReduxProviderPropsMixin = PropsMeta(
  fields: $ReduxProviderPropsMixin.$props,
  keys: $ReduxProviderPropsMixin.$propKeys,
);

final UiFactoryConfig<_$$ReduxProviderProps> _$ReduxProviderConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$ReduxProviderProps(map),
          jsMap: (map) => _$$ReduxProviderProps$JsMap(map),
        ),
        displayName: 'ReduxProvider');

@Deprecated(r'Use the private variable, _$ReduxProviderConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$ReduxProviderProps> $ReduxProviderConfig =
    _$ReduxProviderConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ReduxProviderProps extends UiProps
    with
        ReduxProviderPropsMixin,
        // If this generated mixin is undefined, it's likely because ReduxProviderPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ReduxProviderPropsMixin, and check that $ReduxProviderPropsMixin is exported/imported properly.
        $ReduxProviderPropsMixin
    implements
        ReduxProviderProps {
  _$$ReduxProviderProps._();

  factory _$$ReduxProviderProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ReduxProviderProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ReduxProviderProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because ReduxProviderPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ReduxProviderPropsMixin, and check that $ReduxProviderPropsMixin is exported/imported properly.
        ReduxProviderPropsMixin: $ReduxProviderPropsMixin.meta,
      });

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ReduxProviderProps(
          accessMap, (map) => _$$ReduxProviderProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ReduxProviderProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ReduxProviderProps$PlainMap extends _$$ReduxProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxProviderProps$PlainMap(Map? backingMap)
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
class _$$ReduxProviderProps$JsMap extends _$$ReduxProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxProviderProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
