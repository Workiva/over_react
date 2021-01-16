// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'hoc.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $HocComponentFactory = registerComponent2(
  () => _$HocComponent(),
  builderFactory: _$Hoc,
  componentClass: HocComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Hoc',
);

_$$HocProps _$Hoc([Map backingProps]) => backingProps == null
    ? _$$HocProps$JsMap(JsBackedMap())
    : _$$HocProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$HocProps extends UiProps
    with
        HocProps,
        $HocProps // If this generated mixin is undefined, it's likely because HocProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocProps, and check that $HocProps is exported/imported properly.
{
  _$$HocProps._();

  factory _$$HocProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$HocProps$JsMap(backingMap);
    } else {
      return _$$HocProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $HocComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because HocProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocProps, and check that $HocProps is exported/imported properly.
        HocProps: $HocProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$HocProps$PlainMap extends _$$HocProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$HocProps$PlainMap(Map backingMap)
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
class _$$HocProps$JsMap extends _$$HocProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$HocProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$HocComponent extends HocComponent {
  _$$HocProps$JsMap _cachedTypedProps;

  @override
  _$$HocProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$HocProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$HocProps$JsMap(backingMap);

  @override
  _$$HocProps typedPropsFactory(Map backingMap) => _$$HocProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by HocProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because HocProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocProps, and check that $HocProps is exported/imported properly.
        HocProps: $HocProps.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $HocWithTwoFactoriesComponentFactory = registerComponent2(
  () => _$HocWithTwoFactoriesComponent(),
  builderFactory: _$HocWithTwoFactories,
  componentClass: HocWithTwoFactoriesComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'HocWithTwoFactories',
);

_$$HocWithTwoFactoriesProps _$HocWithTwoFactories([Map backingProps]) =>
    backingProps == null
        ? _$$HocWithTwoFactoriesProps$JsMap(JsBackedMap())
        : _$$HocWithTwoFactoriesProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$HocWithTwoFactoriesProps extends UiProps
    with
        HocWithTwoFactoriesProps,
        $HocWithTwoFactoriesProps // If this generated mixin is undefined, it's likely because HocWithTwoFactoriesProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocWithTwoFactoriesProps, and check that $HocWithTwoFactoriesProps is exported/imported properly.
{
  _$$HocWithTwoFactoriesProps._();

  factory _$$HocWithTwoFactoriesProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$HocWithTwoFactoriesProps$JsMap(backingMap);
    } else {
      return _$$HocWithTwoFactoriesProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $HocWithTwoFactoriesComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because HocWithTwoFactoriesProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocWithTwoFactoriesProps, and check that $HocWithTwoFactoriesProps is exported/imported properly.
        HocWithTwoFactoriesProps: $HocWithTwoFactoriesProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$HocWithTwoFactoriesProps$PlainMap extends _$$HocWithTwoFactoriesProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$HocWithTwoFactoriesProps$PlainMap(Map backingMap)
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
class _$$HocWithTwoFactoriesProps$JsMap extends _$$HocWithTwoFactoriesProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$HocWithTwoFactoriesProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$HocWithTwoFactoriesComponent extends HocWithTwoFactoriesComponent {
  _$$HocWithTwoFactoriesProps$JsMap _cachedTypedProps;

  @override
  _$$HocWithTwoFactoriesProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$HocWithTwoFactoriesProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$HocWithTwoFactoriesProps$JsMap(backingMap);

  @override
  _$$HocWithTwoFactoriesProps typedPropsFactory(Map backingMap) =>
      _$$HocWithTwoFactoriesProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by HocWithTwoFactoriesProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because HocWithTwoFactoriesProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of HocWithTwoFactoriesProps, and check that $HocWithTwoFactoriesProps is exported/imported properly.
        HocWithTwoFactoriesProps: $HocWithTwoFactoriesProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $HocProps on HocProps {
  static const PropsMeta meta = _$metaForHocProps;
  @override
  String get foo =>
      props[_$key__foo__HocProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set foo(String value) => props[_$key__foo__HocProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__HocProps =
      PropDescriptor(_$key__foo__HocProps);
  static const String _$key__foo__HocProps = 'HocProps.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__HocProps];
  static const List<String> $propKeys = [_$key__foo__HocProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForHocProps = PropsMeta(
  fields: $HocProps.$props,
  keys: $HocProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $HocWithTwoFactoriesProps on HocWithTwoFactoriesProps {
  static const PropsMeta meta = _$metaForHocWithTwoFactoriesProps;
  @override
  String get foo =>
      props[_$key__foo__HocWithTwoFactoriesProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set foo(String value) => props[_$key__foo__HocWithTwoFactoriesProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__HocWithTwoFactoriesProps =
      PropDescriptor(_$key__foo__HocWithTwoFactoriesProps);
  static const String _$key__foo__HocWithTwoFactoriesProps =
      'HocWithTwoFactoriesProps.foo';

  static const List<PropDescriptor> $props = [
    _$prop__foo__HocWithTwoFactoriesProps
  ];
  static const List<String> $propKeys = [_$key__foo__HocWithTwoFactoriesProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForHocWithTwoFactoriesProps = PropsMeta(
  fields: $HocWithTwoFactoriesProps.$props,
  keys: $HocWithTwoFactoriesProps.$propKeys,
);
