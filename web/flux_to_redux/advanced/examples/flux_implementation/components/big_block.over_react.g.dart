// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'big_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $BigBlockComponentFactory = registerComponent2(
  () => _$BigBlockComponent(),
  builderFactory: _$BigBlock,
  componentClass: BigBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'BigBlock',
);

_$$BigBlockProps _$BigBlock([Map backingProps]) => backingProps == null
    ? _$$BigBlockProps$JsMap(JsBackedMap())
    : _$$BigBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$BigBlockProps extends UiProps
    with
        FluxUiPropsMixin<RandomColorActions, RandomColorStore>,
        $FluxUiPropsMixin<RandomColorActions,
            RandomColorStore>, // If this generated mixin is undefined, it's likely because FluxUiPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FluxUiPropsMixin.
        BigBlockPropsMixin,
        $BigBlockPropsMixin // If this generated mixin is undefined, it's likely because BigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BigBlockPropsMixin.
    implements
        BigBlockProps {
  _$$BigBlockProps._();

  factory _$$BigBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BigBlockProps$JsMap(backingMap);
    } else {
      return _$$BigBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BigBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$BigBlockProps$PlainMap extends _$$BigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BigBlockProps$PlainMap(Map backingMap)
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
class _$$BigBlockProps$JsMap extends _$$BigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BigBlockProps$JsMap(JsBackedMap backingMap)
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
class _$BigBlockComponent extends BigBlockComponent {
  _$$BigBlockProps$JsMap _cachedTypedProps;

  @override
  _$$BigBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$BigBlockProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BigBlockProps$JsMap(backingMap);

  @override
  _$$BigBlockProps typedPropsFactory(Map backingMap) =>
      _$$BigBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from BigBlockProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FluxUiPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FluxUiPropsMixin.
        FluxUiPropsMixin: $FluxUiPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because BigBlockPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of BigBlockPropsMixin.
        BigBlockPropsMixin: $BigBlockPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $BigBlockPropsMixin on BigBlockPropsMixin {
  static const PropsMeta meta = _$metaForBigBlockPropsMixin;
  @override
  AnotherColorStore get store2 =>
      props[_$key__store2__BigBlockPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set store2(AnotherColorStore value) =>
      props[_$key__store2__BigBlockPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__store2__BigBlockPropsMixin =
      PropDescriptor(_$key__store2__BigBlockPropsMixin);
  static const String _$key__store2__BigBlockPropsMixin =
      'BigBlockPropsMixin.store2';

  static const List<PropDescriptor> $props = [
    _$prop__store2__BigBlockPropsMixin
  ];
  static const List<String> $propKeys = [_$key__store2__BigBlockPropsMixin];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForBigBlockPropsMixin = PropsMeta(
  fields: $BigBlockPropsMixin.$props,
  keys: $BigBlockPropsMixin.$propKeys,
);
