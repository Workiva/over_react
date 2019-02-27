// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TagComponentFactory = registerComponent(() => new _$TagComponent(),
    builderFactory: Tag,
    componentClass: TagComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Tag');

abstract class _$TagPropsAccessorsMixin implements _$TagProps {
  @override
  Map get props;

  /// Go to [_$TagProps.skin] to see the source code for this prop
  @override
  TagSkin get skin =>
      props[_$key__skin___$TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TagProps.skin] to see the source code for this prop
  @override
  set skin(TagSkin value) => props[_$key__skin___$TagProps] = value;

  /// Go to [_$TagProps.isPill] to see the source code for this prop
  @override
  bool get isPill =>
      props[_$key__isPill___$TagProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$TagProps.isPill] to see the source code for this prop
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

_$$TagProps _$Tag([Map backingProps]) => new _$$TagProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TagProps extends _$TagProps
    with _$TagPropsAccessorsMixin
    implements TagProps {
  _$$TagProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $TagComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TagProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TagComponent extends TagComponent {
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
