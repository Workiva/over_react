// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TagComponentFactory = registerComponent2(
  () => new _$TagComponent(),
  builderFactory: Tag,
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
  TagSkin get skin => props[_$key__skin___$TagProps];

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
  bool get isPill => props[_$key__isPill___$TagProps];

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
      const PropDescriptor(_$key__skin___$TagProps);
  static const PropDescriptor _$prop__isPill___$TagProps =
      const PropDescriptor(_$key__isPill___$TagProps);
  static const String _$key__skin___$TagProps = 'TagProps.skin';
  static const String _$key__isPill___$TagProps = 'TagProps.isPill';

  static const List<PropDescriptor> $props = const [
    _$prop__skin___$TagProps,
    _$prop__isPill___$TagProps
  ];
  static const List<String> $propKeys = const [
    _$key__skin___$TagProps,
    _$key__isPill___$TagProps
  ];
}

const PropsMeta _$metaForTagProps = const PropsMeta(
  fields: _$TagPropsAccessorsMixin.$props,
  keys: _$TagPropsAccessorsMixin.$propKeys,
);

class TagProps extends _$TagProps with _$TagPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTagProps;
}

_$$TagProps _$Tag([Map backingProps]) => backingProps == null
    ? new _$$TagProps$JsMap(new JsBackedMap())
    : new _$$TagProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TagProps extends _$TagProps
    with _$TagPropsAccessorsMixin
    implements TagProps {
  _$$TagProps._();

  factory _$$TagProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$TagProps$JsMap(backingMap);
    } else {
      return new _$$TagProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TagComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TagProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TagProps$PlainMap extends _$$TagProps {
  _$$TagProps$PlainMap(Map backingMap)
      : this.props = backingMap ?? {},
        super._();

  /// The backing props map proxied by this class.
  @override
  final Map props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$TagProps$JsMap extends _$$TagProps {
  _$$TagProps$JsMap(JsBackedMap backingMap)
      : this.props = backingMap ?? new JsBackedMap(),
        super._();

  /// The backing props map proxied by this class.
  @override
  final JsBackedMap props;
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
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$TagProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$TagProps$JsMap(backingMap);

  @override
  _$$TagProps typedPropsFactory(Map backingMap) => new _$$TagProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TagProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForTagProps];
}
