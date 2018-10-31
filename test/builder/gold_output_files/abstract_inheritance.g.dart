part of 'abstract_inheritance.dart';

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SubComponentFactory = registerComponent(() => new _$SubComponent(),
    builderFactory: Sub,
    componentClass: SubComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Sub'
);

abstract class _$SubPropsAccessorsMixin implements _$SubProps {
  Map get props;

  @override
  String get subProp => props[_$key__subProp___$SubProps];
  @override
  set subProp(String value) => props[_$key__subProp___$SubProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp___$SubProps = const PropDescriptor(_$key__subProp___$SubProps);
  static const String _$key__subProp___$SubProps = 'SubProps.subProp';

  static const List<PropDescriptor> $props = const [_$prop__subProp___$SubProps];
  static const List<String> $propKeys = const [_$key__subProp___$SubProps];
}

const PropsMeta $metaForSubProps = const PropsMeta(
  fields: _$SubPropsAccessorsMixin.$props,
  keys: _$SubPropsAccessorsMixin.$propKeys,
);

_$$SubProps $Sub([Map backingProps]) => new _$$SubProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$SubProps extends _$SubProps with _$SubPropsAccessorsMixin implements SubProps {
  _$$SubProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? ({});
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $SubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SubProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$SubComponent extends SubComponent {
  @override
  _$$SubProps typedPropsFactory(Map backingMap) => new _$$SubProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForSubProps];
}
abstract class _$SuperPropsAccessorsMixin implements _$SuperProps {
  Map get props;

  @override
  String get superProp => props[_$key__superProp___$SuperProps];
  @override
  set superProp(String value) => props[_$key__superProp___$SuperProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__superProp___$SuperProps = const PropDescriptor(_$key__superProp___$SuperProps);
  static const String _$key__superProp___$SuperProps = 'SuperProps.superProp';

  static const List<PropDescriptor> $props = const [_$prop__superProp___$SuperProps];
  static const List<String> $propKeys = const [_$key__superProp___$SuperProps];
}

const PropsMeta $metaForSuperProps = const PropsMeta(
  fields: _$SuperPropsAccessorsMixin.$props,
  keys: _$SuperPropsAccessorsMixin.$propKeys,
);

