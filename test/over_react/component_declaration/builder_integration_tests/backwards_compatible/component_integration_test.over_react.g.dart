// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent(
  () => _$ComponentTestComponent(),
  builderFactory: _$ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ComponentTest',
);

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ComponentTestProps.stringProp] -->
  @override
  String get stringProp =>
      props[_$key__stringProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.stringProp] -->
  @override
  set stringProp(String value) =>
      props[_$key__stringProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.dynamicProp] -->
  @override
  dynamic get dynamicProp =>
      props[_$key__dynamicProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.dynamicProp] -->
  @override
  set dynamicProp(dynamic value) =>
      props[_$key__dynamicProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.untypedProp] -->
  @override
  get untypedProp =>
      props[_$key__untypedProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.untypedProp] -->
  @override
  set untypedProp(value) =>
      props[_$key__untypedProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customKeyProp] -->
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyProp =>
      props[_$key__customKeyProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customKeyProp] -->
  @override
  @Accessor(key: 'custom key!')
  set customKeyProp(dynamic value) =>
      props[_$key__customKeyProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceProp =>
      props[_$key__customNamespaceProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceProp(dynamic value) =>
      props[_$key__customNamespaceProp___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.customKeyAndNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceProp =>
      props[_$key__customKeyAndNamespaceProp___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.customKeyAndNamespaceProp] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceProp(dynamic value) =>
      props[_$key__customKeyAndNamespaceProp___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp___$ComponentTestProps =
      PropDescriptor(_$key__stringProp___$ComponentTestProps);
  static const PropDescriptor _$prop__dynamicProp___$ComponentTestProps =
      PropDescriptor(_$key__dynamicProp___$ComponentTestProps);
  static const PropDescriptor _$prop__untypedProp___$ComponentTestProps =
      PropDescriptor(_$key__untypedProp___$ComponentTestProps);
  static const PropDescriptor _$prop__customKeyProp___$ComponentTestProps =
      PropDescriptor(_$key__customKeyProp___$ComponentTestProps);
  static const PropDescriptor
      _$prop__customNamespaceProp___$ComponentTestProps =
      PropDescriptor(_$key__customNamespaceProp___$ComponentTestProps);
  static const PropDescriptor
      _$prop__customKeyAndNamespaceProp___$ComponentTestProps =
      PropDescriptor(_$key__customKeyAndNamespaceProp___$ComponentTestProps);
  static const String _$key__stringProp___$ComponentTestProps =
      'ComponentTestProps.stringProp';
  static const String _$key__dynamicProp___$ComponentTestProps =
      'ComponentTestProps.dynamicProp';
  static const String _$key__untypedProp___$ComponentTestProps =
      'ComponentTestProps.untypedProp';
  static const String _$key__customKeyProp___$ComponentTestProps =
      'ComponentTestProps.custom key!';
  static const String _$key__customNamespaceProp___$ComponentTestProps =
      'custom namespace~~customNamespaceProp';
  static const String _$key__customKeyAndNamespaceProp___$ComponentTestProps =
      'custom namespace~~custom key!';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp___$ComponentTestProps,
    _$prop__dynamicProp___$ComponentTestProps,
    _$prop__untypedProp___$ComponentTestProps,
    _$prop__customKeyProp___$ComponentTestProps,
    _$prop__customNamespaceProp___$ComponentTestProps,
    _$prop__customKeyAndNamespaceProp___$ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__stringProp___$ComponentTestProps,
    _$key__dynamicProp___$ComponentTestProps,
    _$key__untypedProp___$ComponentTestProps,
    _$key__customKeyProp___$ComponentTestProps,
    _$key__customNamespaceProp___$ComponentTestProps,
    _$key__customKeyAndNamespaceProp___$ComponentTestProps
  ];
}

const PropsMeta _$metaForComponentTestProps = PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ComponentTestComponentFactory;

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
      _$$ComponentTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in -`ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}
