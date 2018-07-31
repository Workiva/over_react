part of 'abstract_inheritance.dart';

abstract class $SubPropsAccessorsMixin {
  Map get props;

  @override
  String get subProp => props[_$key__subProp__subProps];
  @override
  set subProp(String value) => props[_$key__subProp__subProps] = value;

  static const PropDescriptor _$prop__subProp__subProps = const PropDescriptor(_$key__subProp__subProps);
  static const List<PropDescriptor> $props = const [_$prop__subProp__subProps];
  static const String _$key__subProp__subProps = 'SubProps.subProp';
  static const List<String> $propKeys = const [_$key__subProp__subProps];
}

abstract class $SuperPropsAccessorsMixin {
  Map get props;

  @override
  String get superProp => props[_$key__superProp__SuperProps];
  @override
  set superProp(String value) => props[_$key__superProp__SuperProps] = value;

  /* GENERATED CONSTANTS */
  static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys);
  static const PropDescriptor _$prop__superProp__SuperProps = const PropDescriptor(_$key__superProp__SuperProps);
  static const List<PropDescriptor> $props = const [_$prop__superProp__SuperProps];
  static const String _$key__superProp__SuperProps = 'SuperProps.superProp';
  static const List<String> $propKeys = const [_$key__superProp__SuperProps];
}



_$SubProps $Sub([Map backingProps]) => new _$SubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$SubProps extends SubProps with $SuperPropsAccessorsMixin, $SubPropsAccessorsMixin {
  static const List<PropDescriptor> $props = const []; // FIXME concatenate all accessors mixed in
  static const List<String> $propKeys = const []; // FIXME concatenate all accessors mixed in

  /* GENERATED CONSTANTS */
  static const ConsumedProps $consumedProps = const ConsumedProps($props, $propKeys);

  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$SubProps(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  Function get componentFactory => $SubComponentFactory;

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
  _$SubComponent() : super._();

  @override
  _$SubProps typedPropsFactory(Map backingMap) => new _$SubProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from SubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$SubProps.$consumedProps];
}
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


