// @dart=2.11
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'compact_hoc_syntax_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $FooComponent290Factory = registerComponent2(
  () => _$FooComponent290(),
  builderFactory: _$Foo290,
  componentClass: FooComponent290,
  isWrapper: false,
  parentType: null,
);

_$$Foo290Props _$Foo290([Map backingProps]) => backingProps == null
    ? _$$Foo290Props$JsMap(JsBackedMap())
    : _$$Foo290Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$Foo290Props extends UiProps
    with
        Foo290Props,
        // If this generated mixin is undefined, it's likely because Foo290Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of Foo290Props, and check that $Foo290Props is exported/imported properly.
        $Foo290Props {
  _$$Foo290Props._();

  factory _$$Foo290Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$Foo290Props$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$Foo290Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FooComponent290Factory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because Foo290Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of Foo290Props, and check that $Foo290Props is exported/imported properly.
        Foo290Props: $Foo290Props.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$Foo290Props$PlainMap extends _$$Foo290Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Foo290Props$PlainMap(Map backingMap)
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
class _$$Foo290Props$JsMap extends _$$Foo290Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$Foo290Props$JsMap(JsBackedMap backingMap)
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
class _$FooComponent290 extends FooComponent290 {
  _$$Foo290Props$JsMap _cachedTypedProps;

  @override
  _$$Foo290Props$JsMap get props => _cachedTypedProps;

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
  _$$Foo290Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$Foo290Props$JsMap(backingMap);

  @override
  _$$Foo290Props typedPropsFactory(Map backingMap) =>
      _$$Foo290Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'Foo290';

  /// The default consumed props, comprising all props mixins used by Foo290Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because Foo290Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of Foo290Props, and check that $Foo290Props is exported/imported properly.
        Foo290Props: $Foo290Props.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $FooComponentFactory = registerComponent2(
  () => _$FooComponent(),
  builderFactory: _$Foo,
  componentClass: FooComponent,
  isWrapper: false,
  parentType: null,
);

_$$FooProps _$Foo([Map backingProps]) => backingProps == null
    ? _$$FooProps$JsMap(JsBackedMap())
    : _$$FooProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$FooProps extends UiProps
    with
        FooProps,
        // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooProps, and check that $FooProps is exported/imported properly.
        $FooProps {
  _$$FooProps._();

  factory _$$FooProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FooProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$FooProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FooComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooProps, and check that $FooProps is exported/imported properly.
        FooProps: $FooProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FooProps$PlainMap extends _$$FooProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps$PlainMap(Map backingMap)
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
class _$$FooProps$JsMap extends _$$FooProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FooProps$JsMap(JsBackedMap backingMap)
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
class _$FooComponent extends FooComponent {
  _$$FooProps$JsMap _cachedTypedProps;

  @override
  _$$FooProps$JsMap get props => _cachedTypedProps;

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
  _$$FooProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FooProps$JsMap(backingMap);

  @override
  _$$FooProps typedPropsFactory(Map backingMap) => _$$FooProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'Foo';

  /// The default consumed props, comprising all props mixins used by FooProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FooProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooProps, and check that $FooProps is exported/imported properly.
        FooProps: $FooProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $Foo290Props on Foo290Props {
  static const PropsMeta meta = _$metaForFoo290Props;
  @override
  String get foo => (props[_$key__foo__Foo290Props] ?? null) as String;
  @override
  set foo(String value) => props[_$key__foo__Foo290Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__Foo290Props =
      PropDescriptor(_$key__foo__Foo290Props);
  static const String _$key__foo__Foo290Props = 'Foo290Props.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__Foo290Props];
  static const List<String> $propKeys = [_$key__foo__Foo290Props];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFoo290Props = PropsMeta(
  fields: $Foo290Props.$props,
  keys: $Foo290Props.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FooProps on FooProps {
  static const PropsMeta meta = _$metaForFooProps;
  @override
  String get foo => (props[_$key__foo__FooProps] ?? null) as String;
  @override
  set foo(String value) => props[_$key__foo__FooProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__FooProps =
      PropDescriptor(_$key__foo__FooProps);
  static const String _$key__foo__FooProps = 'FooProps.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__FooProps];
  static const List<String> $propKeys = [_$key__foo__FooProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFooProps = PropsMeta(
  fields: $FooProps.$props,
  keys: $FooProps.$propKeys,
);
