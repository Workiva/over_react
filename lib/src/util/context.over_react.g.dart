// @dart=2.11
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'context.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $_ProviderPropsMixin<TValue> on _ProviderPropsMixin<TValue> {
  static const PropsMeta meta = _$metaFor_ProviderPropsMixin;
  @override
  TValue get value =>
      (props[_$key__value___ProviderPropsMixin] ?? null) as TValue;
  @override
  set value(TValue value) => props[_$key__value___ProviderPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__value___ProviderPropsMixin =
      PropDescriptor(_$key__value___ProviderPropsMixin,
          isRequired: true, isNullable: true);
  static const String _$key__value___ProviderPropsMixin = 'value';

  static const List<PropDescriptor> $props = [
    _$prop__value___ProviderPropsMixin
  ];
  static const List<String> $propKeys = [_$key__value___ProviderPropsMixin];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('value') &&
        !requiredPropNamesToSkipValidation.contains('value')) {
      throw MissingRequiredPropsError('Required prop `value` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaFor_ProviderPropsMixin = PropsMeta(
  fields: $_ProviderPropsMixin.$props,
  keys: $_ProviderPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $_ConsumerPropsMixin<TValue> on _ConsumerPropsMixin<TValue> {
  static const PropsMeta meta = _$metaFor_ConsumerPropsMixin;
  @override
  @experimental
  dynamic get unstable_observedBits =>
      (props[_$key__unstable_observedBits___ConsumerPropsMixin] ?? null)
          as dynamic;
  @override
  @experimental
  set unstable_observedBits(dynamic value) =>
      props[_$key__unstable_observedBits___ConsumerPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__unstable_observedBits___ConsumerPropsMixin =
      PropDescriptor(_$key__unstable_observedBits___ConsumerPropsMixin);
  static const String _$key__unstable_observedBits___ConsumerPropsMixin =
      'unstable_observedBits';

  static const List<PropDescriptor> $props = [
    _$prop__unstable_observedBits___ConsumerPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__unstable_observedBits___ConsumerPropsMixin
  ];

  @override
  @UiProps.$mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaFor_ConsumerPropsMixin = PropsMeta(
  fields: $_ConsumerPropsMixin.$props,
  keys: $_ConsumerPropsMixin.$propKeys,
);

_$$ProviderProps _$_Provider([Map backingProps]) => backingProps == null
    ? _$$ProviderProps$JsMap(JsBackedMap())
    : _$$ProviderProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ProviderProps<TValue> extends UiProps
    with
        _ProviderPropsMixin<TValue>,
        // If this generated mixin is undefined, it's likely because _ProviderPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of _ProviderPropsMixin, and check that $_ProviderPropsMixin is exported/imported properly.
        $_ProviderPropsMixin<TValue>
    implements
        ProviderProps<TValue> {
  _$$ProviderProps._();

  factory _$$ProviderProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ProviderProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ProviderProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because _ProviderPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of _ProviderPropsMixin, and check that $_ProviderPropsMixin is exported/imported properly.
        _ProviderPropsMixin: $_ProviderPropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ProviderProps(accessMap, (map) => _$$ProviderProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ProviderProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ProviderProps$PlainMap<TValue> extends _$$ProviderProps<TValue> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProviderProps$PlainMap(Map backingMap)
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
class _$$ProviderProps$JsMap<TValue> extends _$$ProviderProps<TValue> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ProviderProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

_$$ConsumerProps _$_Consumer([Map backingProps]) => backingProps == null
    ? _$$ConsumerProps$JsMap(JsBackedMap())
    : _$$ConsumerProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ConsumerProps<TValue> extends UiProps
    with
        _ConsumerPropsMixin<TValue>,
        // If this generated mixin is undefined, it's likely because _ConsumerPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of _ConsumerPropsMixin, and check that $_ConsumerPropsMixin is exported/imported properly.
        $_ConsumerPropsMixin<TValue>
    implements
        ConsumerProps<TValue> {
  _$$ConsumerProps._();

  factory _$$ConsumerProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ConsumerProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ConsumerProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because _ConsumerPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of _ConsumerPropsMixin, and check that $_ConsumerPropsMixin is exported/imported properly.
        _ConsumerPropsMixin: $_ConsumerPropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ConsumerProps(accessMap, (map) => _$$ConsumerProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ConsumerProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ConsumerProps$PlainMap<TValue> extends _$$ConsumerProps<TValue> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConsumerProps$PlainMap(Map backingMap)
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
class _$$ConsumerProps$JsMap<TValue> extends _$$ConsumerProps<TValue> {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConsumerProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
