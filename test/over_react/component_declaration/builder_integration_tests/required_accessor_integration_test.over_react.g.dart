// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'required_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent(
    () => _$ComponentTestComponent(),
    builderFactory: ComponentTest,
    componentClass: ComponentTestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ComponentTest');

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ComponentTestProps.required] -->
  @override
  @Accessor(
      isRequired: true,
      requiredErrorMessage: 'This Prop is Required for testing purposes.')
  dynamic get required =>
      props[_$key__required___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.required] -->
  @override
  @Accessor(
      isRequired: true,
      requiredErrorMessage: 'This Prop is Required for testing purposes.')
  set required(dynamic value) =>
      props[_$key__required___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  @Accessor(
      isRequired: true,
      isNullable: true,
      requiredErrorMessage: 'This prop can be set to null!')
  dynamic get nullable =>
      props[_$key__nullable___$ComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  @Accessor(
      isRequired: true,
      isNullable: true,
      requiredErrorMessage: 'This prop can be set to null!')
  set nullable(dynamic value) =>
      props[_$key__nullable___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required___$ComponentTestProps =
      PropDescriptor(_$key__required___$ComponentTestProps,
          isRequired: true,
          errorMessage: 'This Prop is Required for testing purposes.');
  static const PropDescriptor _$prop__nullable___$ComponentTestProps =
      PropDescriptor(_$key__nullable___$ComponentTestProps,
          isRequired: true,
          isNullable: true,
          errorMessage: 'This prop can be set to null!');
  static const String _$key__required___$ComponentTestProps =
      'ComponentTestProps.required';
  static const String _$key__nullable___$ComponentTestProps =
      'ComponentTestProps.nullable';

  static const List<PropDescriptor> $props = [
    _$prop__required___$ComponentTestProps,
    _$prop__nullable___$ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__required___$ComponentTestProps,
    _$key__nullable___$ComponentTestProps
  ];
}

const PropsMeta _$metaForComponentTestProps = PropsMeta(
  fields: _$ComponentTestPropsAccessorsMixin.$props,
  keys: _$ComponentTestPropsAccessorsMixin.$propKeys,
);

class ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForComponentTestProps;
}

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
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}
