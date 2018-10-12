import 'package:over_react/over_react.dart';
import 'generic_inheritance_sub.dart';

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSubComponentFactory = registerComponent(() => new _$GenericSubComponent(),
    builderFactory: GenericSub,
    componentClass: GenericSubComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'GenericSub'
);

abstract class $GenericSubPropsAccessorsMixin {
  Map get props;

  String get subProp => props[_$key__subProp__GenericSubProps];
  set subProp(String value) => props[_$key__subProp__GenericSubProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp__GenericSubProps = const PropDescriptor(_$key__subProp__GenericSubProps);
  static const String _$key__subProp__GenericSubProps = 'GenericSubProps.subProp';

  static const List<PropDescriptor> $props = const [_$prop__subProp__GenericSubProps];
  static const List<String> $propKeys = const [_$key__subProp__GenericSubProps];
}

const PropsMeta $metaForGenericSubProps = const PropsMeta(
  fields: $GenericSubPropsAccessorsMixin.$props,
  keys: $GenericSubPropsAccessorsMixin.$propKeys,
);

_$GenericSubProps $GenericSub([Map backingProps]) => new _$GenericSubProps(backingProps);
// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$GenericSubProps extends GenericSubProps with $GenericSubPropsAccessorsMixin, $ReactPropsMixinAccessorsMixin, $UbiquitousDomPropsMixinAccessorsMixin, $CssClassPropsMixinAccessorsMixin {
  /// The backing props map proxied by this class.
  @override
  final Map props;

  _$GenericSubProps(Map backingMap) : this.props = backingMap ?? ({});

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $GenericSubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSubProps.';

  // Work around https://github.com/dart-lang/sdk/issues/16030 by making
  // the original props class abstract and redeclaring `call` in the impl class.
  @override
  call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$GenericSubComponent extends GenericSubComponent {
  @override
  _$GenericSubProps typedPropsFactory(Map backingMap) => new _$GenericSubProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from GenericSubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [$metaForGenericSubProps];
}
