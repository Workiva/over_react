// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constant_required_accessor_integration_test.dart';

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

  /// Go to [_$ComponentTestProps.required] to see the source code for this prop
  @override
  @requiredProp
  get required => props['ComponentTestProps.required'];

  /// Go to [_$ComponentTestProps.required] to see the source code for this prop
  @override
  @requiredProp
  set required(value) => props['ComponentTestProps.required'] = value;

  /// Go to [_$ComponentTestProps.nullable] to see the source code for this prop
  @override
  @nullableRequiredProp
  get nullable => props['ComponentTestProps.nullable'];

  /// Go to [_$ComponentTestProps.nullable] to see the source code for this prop
  @override
  @nullableRequiredProp
  set nullable(value) => props['ComponentTestProps.nullable'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ComponentTestProps.required', isRequired: true),
    const PropDescriptor('ComponentTestProps.nullable',
        isRequired: true, isNullable: true)
  ];
  static const List<String> $propKeys = const [
    'ComponentTestProps.required',
    'ComponentTestProps.nullable'
  ];
}

const PropsMeta _$metaForComponentTestProps = const PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

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
