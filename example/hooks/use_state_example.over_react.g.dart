// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'use_state_example.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseStateExampleProps on UseStateExampleProps {
  static const PropsMeta meta = _$metaForUseStateExampleProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseStateExampleProps = PropsMeta(
  fields: $UseStateExampleProps.$props,
  keys: $UseStateExampleProps.$propKeys,
);

final UiFactoryConfig<_$$UseStateExampleProps> _$UseStateExampleConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseStateExampleProps(map),
          jsMap: (map) => _$$UseStateExampleProps$JsMap(map),
        ),
        displayName: 'UseStateExample');

@Deprecated(r'Use the private variable, _$UseStateExampleConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$UseStateExampleProps> $UseStateExampleConfig =
    _$UseStateExampleConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseStateExampleProps extends UiProps
    with
        UseStateExampleProps,
        $UseStateExampleProps // If this generated mixin is undefined, it's likely because UseStateExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseStateExampleProps, and check that $UseStateExampleProps is exported/imported properly.
{
  _$$UseStateExampleProps._();

  factory _$$UseStateExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseStateExampleProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$UseStateExampleProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because UseStateExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseStateExampleProps, and check that $UseStateExampleProps is exported/imported properly.
        UseStateExampleProps: $UseStateExampleProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$UseStateExampleProps$PlainMap extends _$$UseStateExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseStateExampleProps$PlainMap(Map backingMap)
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
class _$$UseStateExampleProps$JsMap extends _$$UseStateExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseStateExampleProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
