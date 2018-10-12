part of 'basic_old.dart';

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent(() => new _$BasicComponent(),
    builderFactory: Basic,
    componentClass: BasicComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Basic'
);

abstract class _$BasicPropsAccessorsMixin {
  Map get props;

  String get basicProp => props[_$key__basicProp___$BasicProps];
  set basicProp(String value) => props[_$key__basicProp___$BasicProps] = value;
  String get basic1 => props[_$key__basic1___$BasicProps];
  set basic1(String value) => props[_$key__basic1___$BasicProps] = value;
  String get basic2 => props[_$key__basic2___$BasicProps];
  set basic2(String value) => props[_$key__basic2___$BasicProps] = value;
  String get basic3 => props[_$key__basic3___$BasicProps];
  set basic3(String value) => props[_$key__basic3___$BasicProps] = value;
  String get basic4 => props[_$key__basic4___$BasicProps];
  set basic4(String value) => props[_$key__basic4___$BasicProps] = value;
  String get basic5 => props[_$key__basic5___$BasicProps];
  set basic5(String value) => props[_$key__basic5___$BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp___$BasicProps = const PropDescriptor(_$key__basicProp___$BasicProps);
  static const PropDescriptor _$prop__basic1___$BasicProps = const PropDescriptor(_$key__basic1___$BasicProps);
  static const PropDescriptor _$prop__basic2___$BasicProps = const PropDescriptor(_$key__basic2___$BasicProps);
  static const PropDescriptor _$prop__basic3___$BasicProps = const PropDescriptor(_$key__basic3___$BasicProps);
  static const PropDescriptor _$prop__basic4___$BasicProps = const PropDescriptor(_$key__basic4___$BasicProps);
  static const PropDescriptor _$prop__basic5___$BasicProps = const PropDescriptor(_$key__basic5___$BasicProps);
  static const String _$key__basicProp___$BasicProps = '_\$BasicProps.basicProp';
  static const String _$key__basic1___$BasicProps = '_\$BasicProps.basic1';
  static const String _$key__basic2___$BasicProps = '_\$BasicProps.basic2';
  static const String _$key__basic3___$BasicProps = '_\$BasicProps.basic3';
  static const String _$key__basic4___$BasicProps = '_\$BasicProps.basic4';
  static const String _$key__basic5___$BasicProps = '_\$BasicProps.basic5';

  static const List<PropDescriptor> $props = const [_$prop__basicProp___$BasicProps, _$prop__basic1___$BasicProps, _$prop__basic2___$BasicProps, _$prop__basic3___$BasicProps, _$prop__basic4___$BasicProps, _$prop__basic5___$BasicProps];
  static const List<String> $propKeys = const [_$key__basicProp___$BasicProps, _$key__basic1___$BasicProps, _$key__basic2___$BasicProps, _$key__basic3___$BasicProps, _$key__basic4___$BasicProps, _$key__basic5___$BasicProps];
}

const PropsMeta $metaForBasicProps = const PropsMeta(
  fields: _$BasicPropsAccessorsMixin.$props,
  keys: _$BasicPropsAccessorsMixin.$propKeys,
);

_$BasicProps $Basic([Map backingProps]) => new _$BasicProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$BasicProps extends BasicProps with _$BasicPropsAccessorsMixin, $ReactPropsMixinAccessorsMixin, $UbiquitousDomPropsMixinAccessorsMixin, $CssClassPropsMixinAccessorsMixin {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$BasicProps(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '_\$BasicProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$BasicComponent extends BasicComponent {
  @override
  _$BasicProps typedPropsFactory(Map backingMap) => new _$BasicProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForBasicProps];
}
