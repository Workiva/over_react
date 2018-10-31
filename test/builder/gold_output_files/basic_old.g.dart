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

abstract class BasicPropsAccessorsMixin implements BasicProps {
  Map get props;

  @override
  String get basicProp => props[_$key__basicProp__BasicProps];
  @override
  set basicProp(String value) => props[_$key__basicProp__BasicProps] = value;
  @override
  String get basic1 => props[_$key__basic1__BasicProps];
  @override
  set basic1(String value) => props[_$key__basic1__BasicProps] = value;
  @override
  String get basic2 => props[_$key__basic2__BasicProps];
  @override
  set basic2(String value) => props[_$key__basic2__BasicProps] = value;
  @override
  String get basic3 => props[_$key__basic3__BasicProps];
  @override
  set basic3(String value) => props[_$key__basic3__BasicProps] = value;
  @override
  String get basic4 => props[_$key__basic4__BasicProps];
  @override
  set basic4(String value) => props[_$key__basic4__BasicProps] = value;
  @override
  String get basic5 => props[_$key__basic5__BasicProps];
  @override
  set basic5(String value) => props[_$key__basic5__BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp__BasicProps = const PropDescriptor(_$key__basicProp__BasicProps);
  static const PropDescriptor _$prop__basic1__BasicProps = const PropDescriptor(_$key__basic1__BasicProps);
  static const PropDescriptor _$prop__basic2__BasicProps = const PropDescriptor(_$key__basic2__BasicProps);
  static const PropDescriptor _$prop__basic3__BasicProps = const PropDescriptor(_$key__basic3__BasicProps);
  static const PropDescriptor _$prop__basic4__BasicProps = const PropDescriptor(_$key__basic4__BasicProps);
  static const PropDescriptor _$prop__basic5__BasicProps = const PropDescriptor(_$key__basic5__BasicProps);
  static const String _$key__basicProp__BasicProps = 'BasicProps.basicProp';
  static const String _$key__basic1__BasicProps = 'BasicProps.basic1';
  static const String _$key__basic2__BasicProps = 'BasicProps.basic2';
  static const String _$key__basic3__BasicProps = 'BasicProps.basic3';
  static const String _$key__basic4__BasicProps = 'BasicProps.basic4';
  static const String _$key__basic5__BasicProps = 'BasicProps.basic5';

  static const List<PropDescriptor> $props = const [_$prop__basicProp__BasicProps, _$prop__basic1__BasicProps, _$prop__basic2__BasicProps, _$prop__basic3__BasicProps, _$prop__basic4__BasicProps, _$prop__basic5__BasicProps];
  static const List<String> $propKeys = const [_$key__basicProp__BasicProps, _$key__basic1__BasicProps, _$key__basic2__BasicProps, _$key__basic3__BasicProps, _$key__basic4__BasicProps, _$key__basic5__BasicProps];
}

const PropsMeta $metaForBasicProps = const PropsMeta(
  fields: BasicPropsAccessorsMixin.$props,
  keys: BasicPropsAccessorsMixin.$propKeys,
);

BasicProps $Basic([Map backingProps]) => new BasicProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class BasicProps extends BasicProps with BasicPropsAccessorsMixin implements BasicProps {
  BasicProps(Map backingMap) : this._props = {} {
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
  ReactComponentFactoryProxy get componentFactory => $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';

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
  BasicProps typedPropsFactory(Map backingMap) => new BasicProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from BasicProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForBasicProps];
}
