// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'little_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $LittleBlockComponentFactory = registerComponent2(
  () => _$LittleBlockComponent(),
  builderFactory: _$LittleBlock,
  componentClass: LittleBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'LittleBlock',
);

_$$LittleBlockProps _$LittleBlock([Map backingProps]) => backingProps == null
    ? _$$LittleBlockProps$JsMap(JsBackedMap())
    : _$$LittleBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$LittleBlockProps extends UiProps
    with
        LittleBlockProps,
        $LittleBlockProps // If this generated mixin is undefined, it's likely because LittleBlockProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LittleBlockProps.
{
  _$$LittleBlockProps._();

  factory _$$LittleBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$LittleBlockProps$JsMap(backingMap);
    } else {
      return _$$LittleBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $LittleBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$LittleBlockProps$PlainMap extends _$$LittleBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LittleBlockProps$PlainMap(Map backingMap)
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
class _$$LittleBlockProps$JsMap extends _$$LittleBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$LittleBlockProps$JsMap(JsBackedMap backingMap)
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
class _$LittleBlockComponent extends LittleBlockComponent {
  _$$LittleBlockProps$JsMap _cachedTypedProps;

  @override
  _$$LittleBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$LittleBlockProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$LittleBlockProps$JsMap(backingMap);

  @override
  _$$LittleBlockProps typedPropsFactory(Map backingMap) =>
      _$$LittleBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from LittleBlockProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because LittleBlockProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of LittleBlockProps.
        LittleBlockProps: $LittleBlockProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $LittleBlockProps on LittleBlockProps {
  static const PropsMeta meta = _$metaForLittleBlockProps;
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor__LittleBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor__LittleBlockProps] = value;
  @override
  String get colorString =>
      props[_$key__colorString__LittleBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set colorString(String value) =>
      props[_$key__colorString__LittleBlockProps] = value;
  @override
  String get blockTitle =>
      props[_$key__blockTitle__LittleBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set blockTitle(String value) =>
      props[_$key__blockTitle__LittleBlockProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor__LittleBlockProps =
      PropDescriptor(_$key__backgroundColor__LittleBlockProps);
  static const PropDescriptor _$prop__colorString__LittleBlockProps =
      PropDescriptor(_$key__colorString__LittleBlockProps);
  static const PropDescriptor _$prop__blockTitle__LittleBlockProps =
      PropDescriptor(_$key__blockTitle__LittleBlockProps);
  static const String _$key__backgroundColor__LittleBlockProps =
      'LittleBlockProps.backgroundColor';
  static const String _$key__colorString__LittleBlockProps =
      'LittleBlockProps.colorString';
  static const String _$key__blockTitle__LittleBlockProps =
      'LittleBlockProps.blockTitle';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor__LittleBlockProps,
    _$prop__colorString__LittleBlockProps,
    _$prop__blockTitle__LittleBlockProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor__LittleBlockProps,
    _$key__colorString__LittleBlockProps,
    _$key__blockTitle__LittleBlockProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForLittleBlockProps = PropsMeta(
  fields: $LittleBlockProps.$props,
  keys: $LittleBlockProps.$propKeys,
);
