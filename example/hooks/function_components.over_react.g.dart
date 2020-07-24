// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'function_components.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseReducerTestProps on UseReducerTestProps {
  static const PropsMeta meta = _$metaForUseReducerTestProps;
  @override
  int get initialCount =>
      props[_$key__initialCount__UseReducerTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set initialCount(int value) =>
      props[_$key__initialCount__UseReducerTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__initialCount__UseReducerTestProps =
      PropDescriptor(_$key__initialCount__UseReducerTestProps);
  static const String _$key__initialCount__UseReducerTestProps =
      'UseReducerTestProps.initialCount';

  static const List<PropDescriptor> $props = [
    _$prop__initialCount__UseReducerTestProps
  ];
  static const List<String> $propKeys = [
    _$key__initialCount__UseReducerTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseReducerTestProps = PropsMeta(
  fields: $UseReducerTestProps.$props,
  keys: $UseReducerTestProps.$propKeys,
);

final FunctionComponentConfig<_$$UseReducerTestProps> $UseReducerTestConfig =
    FunctionComponentConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseReducerTestProps(map),
          jsMap: (map) => _$$UseReducerTestProps$JsMap(map),
        ),
        displayName: 'UseReducerTest');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseReducerTestProps extends UiProps
    with
        UseReducerTestProps,
        $UseReducerTestProps // If this generated mixin is undefined, it's likely because UseReducerTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UseReducerTestProps.
{
  _$$UseReducerTestProps._();

  factory _$$UseReducerTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseReducerTestProps$JsMap(backingMap);
    } else {
      return _$$UseReducerTestProps$PlainMap(backingMap);
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
class _$$UseReducerTestProps$PlainMap extends _$$UseReducerTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseReducerTestProps$PlainMap(Map backingMap)
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
class _$$UseReducerTestProps$JsMap extends _$$UseReducerTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseReducerTestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
