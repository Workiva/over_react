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
      (props[_$key__initialCount__UseReducerExampleProps] ?? null) as int;
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

final UiFactoryConfig<_$$UseReducerExampleProps> _$UseReducerExampleConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseReducerExampleProps(map),
          jsMap: (map) => _$$UseReducerExampleProps$JsMap(map),
        ),
        displayName: 'UseReducerExample');

@Deprecated(r'Use the private variable, _$UseReducerExampleConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$UseReducerExampleProps> $UseReducerExampleConfig =
    _$UseReducerExampleConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseReducerExampleProps extends UiProps
    with
        UseReducerExampleProps,
        $UseReducerExampleProps // If this generated mixin is undefined, it's likely because UseReducerExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseReducerExampleProps, and check that $UseReducerExampleProps is exported/imported properly.
{
  _$$UseReducerExampleProps._();

  factory _$$UseReducerExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseReducerExampleProps$JsMap(backingMap as JsBackedMap);
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

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because UseReducerExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseReducerExampleProps, and check that $UseReducerExampleProps is exported/imported properly.
        UseReducerExampleProps: $UseReducerExampleProps.meta,
      });
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
