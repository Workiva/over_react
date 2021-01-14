// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'functional_consumed_props.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ParentOnlyPropsMixin on ParentOnlyPropsMixin {
  static const PropsMeta meta = _$metaForParentOnlyPropsMixin;
  @override
  String get aParentProp =>
      props[_$key__aParentProp__ParentOnlyPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set aParentProp(String value) =>
      props[_$key__aParentProp__ParentOnlyPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__aParentProp__ParentOnlyPropsMixin =
      PropDescriptor(_$key__aParentProp__ParentOnlyPropsMixin);
  static const String _$key__aParentProp__ParentOnlyPropsMixin =
      'ParentOnlyPropsMixin.aParentProp';

  static const List<PropDescriptor> $props = [
    _$prop__aParentProp__ParentOnlyPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__aParentProp__ParentOnlyPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForParentOnlyPropsMixin = PropsMeta(
  fields: $ParentOnlyPropsMixin.$props,
  keys: $ParentOnlyPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $SharedPropsMixin on SharedPropsMixin {
  static const PropsMeta meta = _$metaForSharedPropsMixin;
  @override
  String get aPropToBePassed =>
      props[_$key__aPropToBePassed__SharedPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set aPropToBePassed(String value) =>
      props[_$key__aPropToBePassed__SharedPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__aPropToBePassed__SharedPropsMixin =
      PropDescriptor(_$key__aPropToBePassed__SharedPropsMixin);
  static const String _$key__aPropToBePassed__SharedPropsMixin =
      'SharedPropsMixin.aPropToBePassed';

  static const List<PropDescriptor> $props = [
    _$prop__aPropToBePassed__SharedPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__aPropToBePassed__SharedPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForSharedPropsMixin = PropsMeta(
  fields: $SharedPropsMixin.$props,
  keys: $SharedPropsMixin.$propKeys,
);

final UiFactoryConfig<_$$SomeParentProps> _$SomeParentConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$SomeParentProps(map),
      jsMap: (map) => _$$SomeParentProps$JsMap(map),
    ),
    displayName: 'SomeParent');

@Deprecated(r'Use the private variable, _$SomeParentConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final dynamic $SomeParentConfig = _$SomeParentConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SomeParentProps extends UiProps
    with
        ParentOnlyPropsMixin,
        $ParentOnlyPropsMixin, // If this generated mixin is undefined, it's likely because ParentOnlyPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ParentOnlyPropsMixin, and check that $ParentOnlyPropsMixin is exported/imported properly.
        SharedPropsMixin,
        $SharedPropsMixin // If this generated mixin is undefined, it's likely because SharedPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPropsMixin, and check that $SharedPropsMixin is exported/imported properly.
    implements
        SomeParentProps {
  _$$SomeParentProps._();

  factory _$$SomeParentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SomeParentProps$JsMap(backingMap);
    } else {
      return _$$SomeParentProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because ParentOnlyPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ParentOnlyPropsMixin, and check that $ParentOnlyPropsMixin is exported/imported properly.
        ParentOnlyPropsMixin: $ParentOnlyPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because SharedPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPropsMixin, and check that $SharedPropsMixin is exported/imported properly.
        SharedPropsMixin: $SharedPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SomeParentProps$PlainMap extends _$$SomeParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SomeParentProps$PlainMap(Map backingMap)
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
class _$$SomeParentProps$JsMap extends _$$SomeParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SomeParentProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

final UiFactoryConfig<_$$SomeChildProps> _$SomeChildConfig = UiFactoryConfig(
    propsFactory: PropsFactory(
      map: (map) => _$$SomeChildProps(map),
      jsMap: (map) => _$$SomeChildProps$JsMap(map),
    ),
    displayName: 'SomeChild');

@Deprecated(r'Use the private variable, _$SomeChildConfig, instead '
    'and update the `over_react` lower bound to version 4.1.0. '
    'For information on why this is deprecated, see https://github.com/Workiva/over_react/pull/650')
final dynamic $SomeChildConfig = _$SomeChildConfig;

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$SomeChildProps extends UiProps
    with
        SharedPropsMixin,
        $SharedPropsMixin // If this generated mixin is undefined, it's likely because SharedPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPropsMixin, and check that $SharedPropsMixin is exported/imported properly.
    implements
        SomeChildProps {
  _$$SomeChildProps._();

  factory _$$SomeChildProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$SomeChildProps$JsMap(backingMap);
    } else {
      return _$$SomeChildProps$PlainMap(backingMap);
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
        // If this generated mixin is undefined, it's likely because SharedPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of SharedPropsMixin, and check that $SharedPropsMixin is exported/imported properly.
        SharedPropsMixin: $SharedPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$SomeChildProps$PlainMap extends _$$SomeChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SomeChildProps$PlainMap(Map backingMap)
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
class _$$SomeChildProps$JsMap extends _$$SomeChildProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$SomeChildProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
