// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'tag.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TagComponentFactory = registerComponent2(
  () => _$TagComponent(),
  builderFactory: _$Tag,
  componentClass: TagComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Tag',
);

abstract class _$TagPropsAccessorsMixin implements _$TagProps {
  @override
  Map get props;

  /// The skin / "context" for the [Tag].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#contextual-variations>.
  ///
  /// Default: [TagSkin.DEFAULT]
  ///
  /// <!-- Generated from [_$TagProps.skin] -->
  @override
  TagSkin get skin =>
      props[_$key__skin___$TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The skin / "context" for the [Tag].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#contextual-variations>.
  ///
  /// Default: [TagSkin.DEFAULT]
  ///
  /// <!-- Generated from [_$TagProps.skin] -->
  @override
  set skin(TagSkin value) => props[_$key__skin___$TagProps] = value;

  /// Whether to render the [Tag] with rounded corners that make it look
  /// more like a "pill" (a.k.a Bootstrap v3 "badge")
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#pill-tags>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$TagProps.isPill] -->
  @override
  bool get isPill =>
      props[_$key__isPill___$TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether to render the [Tag] with rounded corners that make it look
  /// more like a "pill" (a.k.a Bootstrap v3 "badge")
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/tag/#pill-tags>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$TagProps.isPill] -->
  @override
  set isPill(bool value) => props[_$key__isPill___$TagProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__skin___$TagProps =
      PropDescriptor(_$key__skin___$TagProps);
  static const PropDescriptor _$prop__isPill___$TagProps =
      PropDescriptor(_$key__isPill___$TagProps);
  static const String _$key__skin___$TagProps = 'TagProps.skin';
  static const String _$key__isPill___$TagProps = 'TagProps.isPill';

  static const List<PropDescriptor> $props = [
    _$prop__skin___$TagProps,
    _$prop__isPill___$TagProps
  ];
  static const List<String> $propKeys = [
    _$key__skin___$TagProps,
    _$key__isPill___$TagProps
  ];
}

const PropsMeta _$metaForTagProps = PropsMeta(
  fields: _$TagPropsAccessorsMixin.$props,
  keys: _$TagPropsAccessorsMixin.$propKeys,
);

class TagProps extends _$TagProps with _$TagPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTagProps;
}

_$$TagProps _$Tag([Map backingProps]) => backingProps == null
    ? _$$TagProps$JsMap(JsBackedMap())
    : _$$TagProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TagProps extends _$TagProps
    with _$TagPropsAccessorsMixin
    implements TagProps {
  _$$TagProps._();

  factory _$$TagProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$TagProps$JsMap(backingMap);
    } else {
      return _$$TagProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TagComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TagProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TagProps$PlainMap extends _$$TagProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TagProps$PlainMap(Map backingMap)
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
class _$$TagProps$JsMap extends _$$TagProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TagProps$JsMap(JsBackedMap backingMap)
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
class _$TagComponent extends TagComponent {
  _$$TagProps$JsMap _cachedTypedProps;

  @override
  _$$TagProps$JsMap get props => _cachedTypedProps;

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
  _$$TagProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$TagProps$JsMap(backingMap);

  @override
  _$$TagProps typedPropsFactory(Map backingMap) => _$$TagProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TagProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTagProps];
}
