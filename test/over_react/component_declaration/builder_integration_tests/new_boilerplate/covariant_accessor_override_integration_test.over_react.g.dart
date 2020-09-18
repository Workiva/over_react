// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'covariant_accessor_override_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BasePropsMixin on BasePropsMixin {
  static const PropsMeta meta = _$metaForBasePropsMixin;
  @override
  Object get foo =>
      props[_$key__foo__BasePropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set foo(Object value) => props[_$key__foo__BasePropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__BasePropsMixin =
      PropDescriptor(_$key__foo__BasePropsMixin);
  static const String _$key__foo__BasePropsMixin = 'BasePropsMixin.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__BasePropsMixin];
  static const List<String> $propKeys = [_$key__foo__BasePropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBasePropsMixin = PropsMeta(
  fields: $BasePropsMixin.$props,
  keys: $BasePropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $OverridePropsMixin on OverridePropsMixin {
  static const PropsMeta meta = _$metaForOverridePropsMixin;
  @override
  @override
  String get foo =>
      props[_$key__foo__OverridePropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @override
  set foo(covariant String value) =>
      props[_$key__foo__OverridePropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__OverridePropsMixin =
      PropDescriptor(_$key__foo__OverridePropsMixin);
  static const String _$key__foo__OverridePropsMixin = 'OverridePropsMixin.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__OverridePropsMixin];
  static const List<String> $propKeys = [_$key__foo__OverridePropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForOverridePropsMixin = PropsMeta(
  fields: $OverridePropsMixin.$props,
  keys: $OverridePropsMixin.$propKeys,
);

_$$TestProps _$Test([Map backingProps]) => backingProps == null
    ? _$$TestProps$JsMap(JsBackedMap())
    : _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestProps extends UiProps
    with
        BasePropsMixin,
        $BasePropsMixin, // If this generated mixin is undefined, it's likely because BasePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BasePropsMixin, and check that $BasePropsMixin is exported/imported properly.
        OverridePropsMixin,
        $OverridePropsMixin // If this generated mixin is undefined, it's likely because OverridePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OverridePropsMixin, and check that $OverridePropsMixin is exported/imported properly.
    implements
        TestProps {
  _$$TestProps._();

  factory _$$TestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestProps$JsMap(backingMap);
    } else {
      return _$$TestProps$PlainMap(backingMap);
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
class _$$TestProps$PlainMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$PlainMap(Map backingMap)
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
class _$$TestProps$JsMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
