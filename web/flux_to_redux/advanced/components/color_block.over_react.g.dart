// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'color_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ColorBlockComponentFactory = registerComponent2(
  () => _$ColorBlockComponent(),
  builderFactory: ColorBlock,
  componentClass: ColorBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ColorBlock',
);

abstract class _$ColorBlockPropsAccessorsMixin implements _$ColorBlockProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ColorBlockProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$ColorBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ColorBlockProps.backgroundColor] -->
  @override
  set backgroundColor(String value) => props[_$key__backgroundColor___$ColorBlockProps] = value;

  /// <!-- Generated from [_$ColorBlockProps.colorString] -->
  @override
  String get colorString =>
      props[_$key__colorString___$ColorBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ColorBlockProps.colorString] -->
  @override
  set colorString(String value) => props[_$key__colorString___$ColorBlockProps] = value;

  /// <!-- Generated from [_$ColorBlockProps.blockTitle] -->
  @override
  String get blockTitle =>
      props[_$key__blockTitle___$ColorBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ColorBlockProps.blockTitle] -->
  @override
  set blockTitle(String value) => props[_$key__blockTitle___$ColorBlockProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor___$ColorBlockProps =
      PropDescriptor(_$key__backgroundColor___$ColorBlockProps);
  static const PropDescriptor _$prop__colorString___$ColorBlockProps =
      PropDescriptor(_$key__colorString___$ColorBlockProps);
  static const PropDescriptor _$prop__blockTitle___$ColorBlockProps =
      PropDescriptor(_$key__blockTitle___$ColorBlockProps);
  static const String _$key__backgroundColor___$ColorBlockProps = 'ColorBlockProps.backgroundColor';
  static const String _$key__colorString___$ColorBlockProps = 'ColorBlockProps.colorString';
  static const String _$key__blockTitle___$ColorBlockProps = 'ColorBlockProps.blockTitle';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$ColorBlockProps,
    _$prop__colorString___$ColorBlockProps,
    _$prop__blockTitle___$ColorBlockProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$ColorBlockProps,
    _$key__colorString___$ColorBlockProps,
    _$key__blockTitle___$ColorBlockProps
  ];
}

const PropsMeta _$metaForColorBlockProps = PropsMeta(
  fields: _$ColorBlockPropsAccessorsMixin.$props,
  keys: _$ColorBlockPropsAccessorsMixin.$propKeys,
);

class ColorBlockProps extends _$ColorBlockProps with _$ColorBlockPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForColorBlockProps;
}

_$$ColorBlockProps _$ColorBlock([Map backingProps]) => backingProps == null
    ? _$$ColorBlockProps$JsMap(JsBackedMap())
    : _$$ColorBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ColorBlockProps extends _$ColorBlockProps
    with _$ColorBlockPropsAccessorsMixin
    implements ColorBlockProps {
  _$$ColorBlockProps._();

  factory _$$ColorBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ColorBlockProps$JsMap(backingMap);
    } else {
      return _$$ColorBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ColorBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ColorBlockProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ColorBlockProps$PlainMap extends _$$ColorBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ColorBlockProps$PlainMap(Map backingMap)
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
class _$$ColorBlockProps$JsMap extends _$$ColorBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ColorBlockProps$JsMap(JsBackedMap backingMap)
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
class _$ColorBlockComponent extends ColorBlockComponent {
  _$$ColorBlockProps$JsMap _cachedTypedProps;

  @override
  _$$ColorBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$ColorBlockProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ColorBlockProps$JsMap(backingMap);

  @override
  _$$ColorBlockProps typedPropsFactory(Map backingMap) => _$$ColorBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ColorBlockProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForColorBlockProps];
}
