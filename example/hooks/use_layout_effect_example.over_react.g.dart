// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'use_layout_effect_example.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseLayoutEffectProps on UseLayoutEffectProps {
  static const PropsMeta meta = _$metaForUseLayoutEffectProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseLayoutEffectProps = PropsMeta(
  fields: $UseLayoutEffectProps.$props,
  keys: $UseLayoutEffectProps.$propKeys,
);

final FunctionComponentConfig<_$$UseLayoutEffectProps>
    $UseLayoutEffectExampleConfig = FunctionComponentConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseLayoutEffectProps(map),
          jsMap: (map) => _$$UseLayoutEffectProps$JsMap(map),
        ),
        displayName: 'UseLayoutEffectExample');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseLayoutEffectProps extends UiProps
    with
        UseLayoutEffectProps,
        $UseLayoutEffectProps // If this generated mixin is undefined, it's likely because UseLayoutEffectProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UseLayoutEffectProps.
{
  _$$UseLayoutEffectProps._();

  factory _$$UseLayoutEffectProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseLayoutEffectProps$JsMap(backingMap);
    } else {
      return _$$UseLayoutEffectProps$PlainMap(backingMap);
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
class _$$UseLayoutEffectProps$PlainMap extends _$$UseLayoutEffectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseLayoutEffectProps$PlainMap(Map backingMap)
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
class _$$UseLayoutEffectProps$JsMap extends _$$UseLayoutEffectProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseLayoutEffectProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
