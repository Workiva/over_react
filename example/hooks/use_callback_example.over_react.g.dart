// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'use_callback_example.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $UseCallbackExampleProps on UseCallbackExampleProps {
  static const PropsMeta meta = _$metaForUseCallbackExampleProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForUseCallbackExampleProps = PropsMeta(
  fields: $UseCallbackExampleProps.$props,
  keys: $UseCallbackExampleProps.$propKeys,
);

final UiFactoryConfig<_$$UseCallbackExampleProps> _$UseCallbackExampleConfig =
    UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UseCallbackExampleProps(map),
          jsMap: (map) => _$$UseCallbackExampleProps$JsMap(map),
        ),
        displayName: 'UseCallbackExample');

@Deprecated(
    r'This member is incompatible with Dart >2.9.0. Use `_$UseCallbackExampleConfig` instead.')
final UiFactoryConfig<_$$UseCallbackExampleProps> $UseCallbackExampleConfig =
    _$UseCallbackExampleConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$UseCallbackExampleProps extends UiProps
    with
        UseCallbackExampleProps,
        $UseCallbackExampleProps // If this generated mixin is undefined, it's likely because UseCallbackExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseCallbackExampleProps, and check that $UseCallbackExampleProps is exported/imported properly.
{
  _$$UseCallbackExampleProps._();

  factory _$$UseCallbackExampleProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$UseCallbackExampleProps$JsMap(backingMap);
    } else {
      return _$$UseCallbackExampleProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because UseCallbackExampleProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of UseCallbackExampleProps, and check that $UseCallbackExampleProps is exported/imported properly.
        UseCallbackExampleProps: $UseCallbackExampleProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$UseCallbackExampleProps$PlainMap extends _$$UseCallbackExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseCallbackExampleProps$PlainMap(Map backingMap)
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
class _$$UseCallbackExampleProps$JsMap extends _$$UseCallbackExampleProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$UseCallbackExampleProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
