// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'props_meta_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $TestComponentFactory = registerComponent2(
  () => _$TestComponent(),
  builderFactory: _$Test,
  componentClass: TestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Test',
);

_$$TestProps _$Test([Map backingProps]) => backingProps == null
    ? _$$TestProps$JsMap(JsBackedMap())
    : _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestProps extends UiProps
    with
        TestPropsMixin,
        $TestPropsMixin, // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        FooPropsMixin,
        $FooPropsMixin, // If this generated mixin is undefined, it's likely because FooPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooPropsMixin, and check that $FooPropsMixin is exported/imported properly.
        BazPropsMixin,
        $BazPropsMixin // If this generated mixin is undefined, it's likely because BazPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BazPropsMixin, and check that $BazPropsMixin is exported/imported properly.
    implements
        TestProps {
  _$$TestProps._();

  factory _$$TestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because FooPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooPropsMixin, and check that $FooPropsMixin is exported/imported properly.
        FooPropsMixin: $FooPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because BazPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BazPropsMixin, and check that $BazPropsMixin is exported/imported properly.
        BazPropsMixin: $BazPropsMixin.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestProps$PlainMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$PlainMap(Map backingMap)
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
class _$$TestProps$JsMap extends _$$TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps$JsMap(JsBackedMap backingMap)
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
class _$TestComponent extends TestComponent {
  _$$TestProps$JsMap _cachedTypedProps;

  @override
  _$$TestProps$JsMap get props => _cachedTypedProps;

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
  _$$TestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestProps$JsMap(backingMap);

  @override
  _$$TestProps typedPropsFactory(Map backingMap) => _$$TestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by TestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestPropsMixin, and check that $TestPropsMixin is exported/imported properly.
        TestPropsMixin: $TestPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because FooPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of FooPropsMixin, and check that $FooPropsMixin is exported/imported properly.
        FooPropsMixin: $FooPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because BazPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of BazPropsMixin, and check that $BazPropsMixin is exported/imported properly.
        BazPropsMixin: $BazPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestPropsMixin on TestPropsMixin {
  static const PropsMeta meta = _$metaForTestPropsMixin;
  @override
  String get test => (props[_$key__test__TestPropsMixin] ?? null) as String;
  @override
  set test(String value) => props[_$key__test__TestPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__test__TestPropsMixin =
      PropDescriptor(_$key__test__TestPropsMixin);
  static const String _$key__test__TestPropsMixin = 'TestPropsMixin.test';

  static const List<PropDescriptor> $props = [_$prop__test__TestPropsMixin];
  static const List<String> $propKeys = [_$key__test__TestPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestPropsMixin = PropsMeta(
  fields: $TestPropsMixin.$props,
  keys: $TestPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FooPropsMixin on FooPropsMixin {
  static const PropsMeta meta = _$metaForFooPropsMixin;
  @override
  bool get foo => (props[_$key__foo__FooPropsMixin] ?? null) as bool;
  @override
  set foo(bool value) => props[_$key__foo__FooPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__foo__FooPropsMixin =
      PropDescriptor(_$key__foo__FooPropsMixin);
  static const String _$key__foo__FooPropsMixin = 'FooPropsMixin.foo';

  static const List<PropDescriptor> $props = [_$prop__foo__FooPropsMixin];
  static const List<String> $propKeys = [_$key__foo__FooPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFooPropsMixin = PropsMeta(
  fields: $FooPropsMixin.$props,
  keys: $FooPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BazPropsMixin on BazPropsMixin {
  static const PropsMeta meta = _$metaForBazPropsMixin;
  @override
  bool get baz => (props[_$key__baz__BazPropsMixin] ?? null) as bool;
  @override
  set baz(bool value) => props[_$key__baz__BazPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__baz__BazPropsMixin =
      PropDescriptor(_$key__baz__BazPropsMixin);
  static const String _$key__baz__BazPropsMixin = 'BazPropsMixin.baz';

  static const List<PropDescriptor> $props = [_$prop__baz__BazPropsMixin];
  static const List<String> $propKeys = [_$key__baz__BazPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBazPropsMixin = PropsMeta(
  fields: $BazPropsMixin.$props,
  keys: $BazPropsMixin.$propKeys,
);
