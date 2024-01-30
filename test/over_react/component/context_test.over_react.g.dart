// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'context_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ContextTypeDynamicComponentFactory = registerComponent2(
  () => _$ContextTypeDynamicComponent(),
  builderFactory: _$ContextTypeDynamic,
  componentClass: ContextTypeDynamicComponent,
  isWrapper: false,
  parentType: null,
);

_$$ContextTypeDynamicProps _$ContextTypeDynamic([Map? backingProps]) =>
    backingProps == null
        ? _$$ContextTypeDynamicProps$JsMap(JsBackedMap())
        : _$$ContextTypeDynamicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextTypeDynamicProps extends UiProps
    with
        ContextTypeDynamicProps,
        // If this generated mixin is undefined, it's likely because ContextTypeDynamicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeDynamicProps, and check that $ContextTypeDynamicProps is exported/imported properly.
        $ContextTypeDynamicProps {
  _$$ContextTypeDynamicProps._();

  factory _$$ContextTypeDynamicProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextTypeDynamicProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ContextTypeDynamicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextTypeDynamicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeDynamicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeDynamicProps, and check that $ContextTypeDynamicProps is exported/imported properly.
        ContextTypeDynamicProps: $ContextTypeDynamicProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ContextTypeDynamicProps(
          accessMap, (map) => _$$ContextTypeDynamicProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ContextTypeDynamicProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ContextTypeDynamicProps$PlainMap extends _$$ContextTypeDynamicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeDynamicProps$PlainMap(Map? backingMap)
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
class _$$ContextTypeDynamicProps$JsMap extends _$$ContextTypeDynamicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeDynamicProps$JsMap(JsBackedMap? backingMap)
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
class _$ContextTypeDynamicComponent extends ContextTypeDynamicComponent {
  late _$$ContextTypeDynamicProps$JsMap _cachedTypedProps;

  @override
  _$$ContextTypeDynamicProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ContextTypeDynamicProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ContextTypeDynamicProps$JsMap(backingMap);

  @override
  _$$ContextTypeDynamicProps typedPropsFactory(Map? backingMap) =>
      _$$ContextTypeDynamicProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ContextTypeDynamic';

  /// The default consumed props, comprising all props mixins used by ContextTypeDynamicProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeDynamicProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeDynamicProps, and check that $ContextTypeDynamicProps is exported/imported properly.
        ContextTypeDynamicProps: $ContextTypeDynamicProps.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ContextTypeWithoutDefaultComponentFactory = registerComponent2(
  () => _$ContextTypeWithoutDefaultComponent(),
  builderFactory: _$ContextTypeWithoutDefault,
  componentClass: ContextTypeWithoutDefaultComponent,
  isWrapper: false,
  parentType: null,
);

_$$ContextTypeWithoutDefaultProps _$ContextTypeWithoutDefault(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$ContextTypeWithoutDefaultProps$JsMap(JsBackedMap())
        : _$$ContextTypeWithoutDefaultProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextTypeWithoutDefaultProps extends UiProps
    with
        ContextTypeWithoutDefaultProps,
        // If this generated mixin is undefined, it's likely because ContextTypeWithoutDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithoutDefaultProps, and check that $ContextTypeWithoutDefaultProps is exported/imported properly.
        $ContextTypeWithoutDefaultProps {
  _$$ContextTypeWithoutDefaultProps._();

  factory _$$ContextTypeWithoutDefaultProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextTypeWithoutDefaultProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$ContextTypeWithoutDefaultProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextTypeWithoutDefaultComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeWithoutDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithoutDefaultProps, and check that $ContextTypeWithoutDefaultProps is exported/imported properly.
        ContextTypeWithoutDefaultProps: $ContextTypeWithoutDefaultProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ContextTypeWithoutDefaultProps(
          accessMap, (map) => _$$ContextTypeWithoutDefaultProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ContextTypeWithoutDefaultProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ContextTypeWithoutDefaultProps$PlainMap
    extends _$$ContextTypeWithoutDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeWithoutDefaultProps$PlainMap(Map? backingMap)
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
class _$$ContextTypeWithoutDefaultProps$JsMap
    extends _$$ContextTypeWithoutDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeWithoutDefaultProps$JsMap(JsBackedMap? backingMap)
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
class _$ContextTypeWithoutDefaultComponent
    extends ContextTypeWithoutDefaultComponent {
  late _$$ContextTypeWithoutDefaultProps$JsMap _cachedTypedProps;

  @override
  _$$ContextTypeWithoutDefaultProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ContextTypeWithoutDefaultProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ContextTypeWithoutDefaultProps$JsMap(backingMap);

  @override
  _$$ContextTypeWithoutDefaultProps typedPropsFactory(Map? backingMap) =>
      _$$ContextTypeWithoutDefaultProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ContextTypeWithoutDefault';

  /// The default consumed props, comprising all props mixins used by ContextTypeWithoutDefaultProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeWithoutDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithoutDefaultProps, and check that $ContextTypeWithoutDefaultProps is exported/imported properly.
        ContextTypeWithoutDefaultProps: $ContextTypeWithoutDefaultProps.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ContextTypeWithDefaultComponentFactory = registerComponent2(
  () => _$ContextTypeWithDefaultComponent(),
  builderFactory: _$ContextTypeWithDefault,
  componentClass: ContextTypeWithDefaultComponent,
  isWrapper: false,
  parentType: null,
);

_$$ContextTypeWithDefaultProps _$ContextTypeWithDefault([Map? backingProps]) =>
    backingProps == null
        ? _$$ContextTypeWithDefaultProps$JsMap(JsBackedMap())
        : _$$ContextTypeWithDefaultProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextTypeWithDefaultProps extends UiProps
    with
        ContextTypeWithDefaultProps,
        // If this generated mixin is undefined, it's likely because ContextTypeWithDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithDefaultProps, and check that $ContextTypeWithDefaultProps is exported/imported properly.
        $ContextTypeWithDefaultProps {
  _$$ContextTypeWithDefaultProps._();

  factory _$$ContextTypeWithDefaultProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextTypeWithDefaultProps$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ContextTypeWithDefaultProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextTypeWithDefaultComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeWithDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithDefaultProps, and check that $ContextTypeWithDefaultProps is exported/imported properly.
        ContextTypeWithDefaultProps: $ContextTypeWithDefaultProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ContextTypeWithDefaultProps(
          accessMap, (map) => _$$ContextTypeWithDefaultProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ContextTypeWithDefaultProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ContextTypeWithDefaultProps$PlainMap
    extends _$$ContextTypeWithDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeWithDefaultProps$PlainMap(Map? backingMap)
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
class _$$ContextTypeWithDefaultProps$JsMap
    extends _$$ContextTypeWithDefaultProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextTypeWithDefaultProps$JsMap(JsBackedMap? backingMap)
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
class _$ContextTypeWithDefaultComponent
    extends ContextTypeWithDefaultComponent {
  late _$$ContextTypeWithDefaultProps$JsMap _cachedTypedProps;

  @override
  _$$ContextTypeWithDefaultProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ContextTypeWithDefaultProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$ContextTypeWithDefaultProps$JsMap(backingMap);

  @override
  _$$ContextTypeWithDefaultProps typedPropsFactory(Map? backingMap) =>
      _$$ContextTypeWithDefaultProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ContextTypeWithDefault';

  /// The default consumed props, comprising all props mixins used by ContextTypeWithDefaultProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextTypeWithDefaultProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ContextTypeWithDefaultProps, and check that $ContextTypeWithDefaultProps is exported/imported properly.
        ContextTypeWithDefaultProps: $ContextTypeWithDefaultProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextTypeDynamicProps on ContextTypeDynamicProps {
  static const PropsMeta meta = _$metaForContextTypeDynamicProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForContextTypeDynamicProps = PropsMeta(
  fields: $ContextTypeDynamicProps.$props,
  keys: $ContextTypeDynamicProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextTypeWithoutDefaultProps on ContextTypeWithoutDefaultProps {
  static const PropsMeta meta = _$metaForContextTypeWithoutDefaultProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForContextTypeWithoutDefaultProps = PropsMeta(
  fields: $ContextTypeWithoutDefaultProps.$props,
  keys: $ContextTypeWithoutDefaultProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextTypeWithDefaultProps on ContextTypeWithDefaultProps {
  static const PropsMeta meta = _$metaForContextTypeWithDefaultProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForContextTypeWithDefaultProps = PropsMeta(
  fields: $ContextTypeWithDefaultProps.$props,
  keys: $ContextTypeWithDefaultProps.$propKeys,
);
