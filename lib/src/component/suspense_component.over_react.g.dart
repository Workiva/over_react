// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'suspense_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SuspensePropsMixin on SuspensePropsMixin {
  static const PropsMeta meta = _$metaForSuspensePropsMixin;
  @override
  get fallback =>
      (props[_$key__fallback__SuspensePropsMixin] ?? null) as dynamic;
  @override
  set fallback(value) => props[_$key__fallback__SuspensePropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__fallback__SuspensePropsMixin =
      PropDescriptor(_$key__fallback__SuspensePropsMixin);
  static const String _$key__fallback__SuspensePropsMixin = 'fallback';

  static const List<PropDescriptor> $props = [
    _$prop__fallback__SuspensePropsMixin
  ];
  static const List<String> $propKeys = [_$key__fallback__SuspensePropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSuspensePropsMixin = PropsMeta(
  fields: $SuspensePropsMixin.$props,
  keys: $SuspensePropsMixin.$propKeys,
);

final UiFactoryConfig<_$$SuspenseProps> _$SuspenseConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$SuspenseProps(map),
      jsMap: (map) => _$$SuspenseProps$JsMap(map),
    ),
    displayName: 'Suspense');

@Deprecated(r'Use the private variable, _$SuspenseConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final UiFactoryConfig<_$$SuspenseProps> $SuspenseConfig = _$SuspenseConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SuspenseProps extends UiProps
    with
        SuspensePropsMixin,
        $SuspensePropsMixin // If this generated mixin is undefined, it's likely because SuspensePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SuspensePropsMixin, and check that $SuspensePropsMixin is exported/imported properly.
    implements
        SuspenseProps {
  _$$SuspenseProps._();

  factory _$$SuspenseProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SuspenseProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$SuspenseProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because SuspensePropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SuspensePropsMixin, and check that $SuspensePropsMixin is exported/imported properly.
        SuspensePropsMixin: $SuspensePropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SuspenseProps$PlainMap extends _$$SuspenseProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SuspenseProps$PlainMap(Map? backingMap)
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
class _$$SuspenseProps$JsMap extends _$$SuspenseProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SuspenseProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
