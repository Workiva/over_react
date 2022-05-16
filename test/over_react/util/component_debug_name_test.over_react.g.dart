// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'component_debug_name_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $TestComponent2ComponentFactory = registerComponent2(
  () => _$TestComponent2Component(),
  builderFactory: _$TestComponent2,
  componentClass: TestComponent2Component,
  isWrapper: false,
  parentType: null,
  displayName: 'TestComponent2',
);

_$$TestComponent2Props _$TestComponent2([Map backingProps]) =>
    backingProps == null
        ? _$$TestComponent2Props$JsMap(JsBackedMap())
        : _$$TestComponent2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$TestComponent2Props extends UiProps
    with
        TestComponent2Props,
        $TestComponent2Props // If this generated mixin is undefined, it's likely because TestComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestComponent2Props, and check that $TestComponent2Props is exported/imported properly.
{
  _$$TestComponent2Props._();

  factory _$$TestComponent2Props(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TestComponent2Props$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$TestComponent2Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestComponent2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestComponent2Props, and check that $TestComponent2Props is exported/imported properly.
        TestComponent2Props: $TestComponent2Props.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestComponent2Props$PlainMap extends _$$TestComponent2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestComponent2Props$PlainMap(Map backingMap)
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
class _$$TestComponent2Props$JsMap extends _$$TestComponent2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestComponent2Props$JsMap(JsBackedMap backingMap)
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
class _$TestComponent2Component extends TestComponent2Component {
  _$$TestComponent2Props$JsMap _cachedTypedProps;

  @override
  _$$TestComponent2Props$JsMap get props => _cachedTypedProps;

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
  _$$TestComponent2Props$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TestComponent2Props$JsMap(backingMap);

  @override
  _$$TestComponent2Props typedPropsFactory(Map backingMap) =>
      _$$TestComponent2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by TestComponent2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestComponent2Props is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestComponent2Props, and check that $TestComponent2Props is exported/imported properly.
        TestComponent2Props: $TestComponent2Props.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestComponentComponentFactory = registerComponent(
  () => _$TestComponentComponent(),
  builderFactory: _$TestComponent,
  componentClass: TestComponentComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'TestComponent',
);

abstract class _$TestComponentPropsAccessorsMixin
    implements _$TestComponentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestComponentProps = PropsMeta(
  fields: _$TestComponentPropsAccessorsMixin.$props,
  keys: _$TestComponentPropsAccessorsMixin.$propKeys,
);

_$$TestComponentProps _$TestComponent([Map backingProps]) =>
    _$$TestComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestComponentProps extends _$TestComponentProps
    with _$TestComponentPropsAccessorsMixin
    implements TestComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestComponentProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestComponentProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestComponentComponent extends TestComponentComponent {
  @override
  _$$TestComponentProps typedPropsFactory(Map backingMap) =>
      _$$TestComponentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TestComponentProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestComponentProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestComponent2Props on TestComponent2Props {
  static const PropsMeta meta = _$metaForTestComponent2Props;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestComponent2Props = PropsMeta(
  fields: $TestComponent2Props.$props,
  keys: $TestComponent2Props.$propKeys,
);
