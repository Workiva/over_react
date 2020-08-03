// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'use_reducer_example.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseReducerExampleProps on UseReducerExampleProps {
  static const PropsMeta meta = _$metaForUseReducerExampleProps;
  @override
  int get initialCount =>
      props[_$key__initialCount__UseReducerExampleProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set initialCount(int value) =>
      props[_$key__initialCount__UseReducerExampleProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__initialCount__UseReducerExampleProps =
      PropDescriptor(_$key__initialCount__UseReducerExampleProps);
  static const String _$key__initialCount__UseReducerExampleProps =
      'UseReducerExampleProps.initialCount';

  static const List<PropDescriptor> $props = [
    _$prop__initialCount__UseReducerExampleProps
  ];
  static const List<String> $propKeys = [
    _$key__initialCount__UseReducerExampleProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseReducerExampleProps = PropsMeta(
  fields: $UseReducerExampleProps.$props,
  keys: $UseReducerExampleProps.$propKeys,
);

final UiFactoryConfig<_$$UseReducerExampleProps> $UseReducerExampleConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseReducerExampleProps(map),
          jsMap: (map) => _$$UseReducerExampleProps$JsMap(map),
        ),
        displayName: 'UseReducerExample');

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseReducerExampleProps extends UiProps
    with
        UseReducerExampleProps,
        $UseReducerExampleProps // If this generated mixin is undefined, it's likely because UseReducerExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of UseReducerExampleProps.
{
  _$$UseReducerExampleProps._();

  factory _$$UseReducerExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseReducerExampleProps$JsMap(backingMap);
    } else {
      return _$$UseReducerExampleProps$PlainMap(backingMap);
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
class _$$UseReducerExampleProps$PlainMap extends _$$UseReducerExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseReducerExampleProps$PlainMap(Map backingMap)
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
class _$$UseReducerExampleProps$JsMap extends _$$UseReducerExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseReducerExampleProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
