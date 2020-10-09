// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'use_memo_example.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseMemoExampleProps on UseMemoExampleProps {
  static const PropsMeta meta = _$metaForUseMemoExampleProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseMemoExampleProps = PropsMeta(
  fields: $UseMemoExampleProps.$props,
  keys: $UseMemoExampleProps.$propKeys,
);

final UiFactoryConfig<_$$UseMemoExampleProps> $UseMemoExampleConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseMemoExampleProps(map),
          jsMap: (map) => _$$UseMemoExampleProps$JsMap(map),
        ),
        displayName: 'UseMemoExample');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseMemoExampleProps extends UiProps
    with
        UseMemoExampleProps,
        $UseMemoExampleProps // If this generated mixin is undefined, it's likely because UseMemoExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseMemoExampleProps, and check that $UseMemoExampleProps is exported/imported properly.
{
  _$$UseMemoExampleProps._();

  factory _$$UseMemoExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseMemoExampleProps$JsMap(backingMap);
    } else {
      return _$$UseMemoExampleProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsInstanceMeta get $meta => PropsInstanceMeta({});
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$UseMemoExampleProps$PlainMap extends _$$UseMemoExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseMemoExampleProps$PlainMap(Map backingMap)
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
class _$$UseMemoExampleProps$JsMap extends _$$UseMemoExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseMemoExampleProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
