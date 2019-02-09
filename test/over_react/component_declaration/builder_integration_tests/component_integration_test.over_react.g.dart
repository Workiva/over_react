// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_integration_test.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent(
    () => new _$ComponentTestComponent(),
    builderFactory: ComponentTest,
    componentClass: ComponentTestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ComponentTest');

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// Go to [_$ComponentTestProps.stringProp] to see the source code for this prop
  @override
  String get stringProp => props['ComponentTestProps.stringProp'];

  /// Go to [_$ComponentTestProps.stringProp] to see the source code for this prop
  @override
  set stringProp(String value) =>
      props['ComponentTestProps.stringProp'] = value;

  /// Go to [_$ComponentTestProps.dynamicProp] to see the source code for this prop
  @override
  dynamic get dynamicProp => props['ComponentTestProps.dynamicProp'];

  /// Go to [_$ComponentTestProps.dynamicProp] to see the source code for this prop
  @override
  set dynamicProp(dynamic value) =>
      props['ComponentTestProps.dynamicProp'] = value;

  /// Go to [_$ComponentTestProps.untypedProp] to see the source code for this prop
  @override
  get untypedProp => props['ComponentTestProps.untypedProp'];

  /// Go to [_$ComponentTestProps.untypedProp] to see the source code for this prop
  @override
  set untypedProp(value) => props['ComponentTestProps.untypedProp'] = value;

  /// Go to [_$ComponentTestProps.customKeyProp] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  get customKeyProp => props['ComponentTestProps.custom key!'];

  /// Go to [_$ComponentTestProps.customKeyProp] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  set customKeyProp(value) => props['ComponentTestProps.custom key!'] = value;

  /// Go to [_$ComponentTestProps.customNamespaceProp] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  get customNamespaceProp => props['custom namespace~~customNamespaceProp'];

  /// Go to [_$ComponentTestProps.customNamespaceProp] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceProp(value) =>
      props['custom namespace~~customNamespaceProp'] = value;

  /// Go to [_$ComponentTestProps.customKeyAndNamespaceProp] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  get customKeyAndNamespaceProp => props['custom namespace~~custom key!'];

  /// Go to [_$ComponentTestProps.customKeyAndNamespaceProp] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceProp(value) =>
      props['custom namespace~~custom key!'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ComponentTestProps.stringProp'),
    const PropDescriptor('ComponentTestProps.dynamicProp'),
    const PropDescriptor('ComponentTestProps.untypedProp'),
    const PropDescriptor('ComponentTestProps.custom key!'),
    const PropDescriptor('custom namespace~~customNamespaceProp'),
    const PropDescriptor('custom namespace~~custom key!')
  ];
  static const List<String> $propKeys = const [
    'ComponentTestProps.stringProp',
    'ComponentTestProps.dynamicProp',
    'ComponentTestProps.untypedProp',
    'ComponentTestProps.custom key!',
    'custom namespace~~customNamespaceProp',
    'custom namespace~~custom key!'
  ];
}

const PropsMeta _$metaForComponentTestProps = const PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

class ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForComponentTestProps;
}

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    new _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  _$$ComponentTestProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ComponentTestProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ComponentTestComponent extends ComponentTestComponent {
  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      new _$$ComponentTestProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}
