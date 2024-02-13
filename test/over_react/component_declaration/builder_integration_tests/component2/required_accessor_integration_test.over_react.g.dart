// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'required_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ComponentTestComponentFactory = registerComponent2(
  () => _$ComponentTestComponent(),
  builderFactory: _$ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
);

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
      (props[_$key__required___$ComponentTestProps] ?? null) as dynamic;

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
      (props[_$key__nullable___$ComponentTestProps] ?? null) as dynamic;

  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  @Accessor(
      isRequired: true,
      isNullable: true,
      requiredErrorMessage: 'This prop can be set to null!')
  set nullable(dynamic value) =>
      props[_$key__nullable___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.requiredAndLengthLimited] -->
  @override
  @Accessor(
      isRequired: true,
      isNullable: false,
      requiredErrorMessage: 'This Prop Array is Required for testing purposes.')
  List? get requiredAndLengthLimited =>
      (props[_$key__requiredAndLengthLimited___$ComponentTestProps] ?? null)
          as List?;

  /// <!-- Generated from [_$ComponentTestProps.requiredAndLengthLimited] -->
  @override
  @Accessor(
      isRequired: true,
      isNullable: false,
      requiredErrorMessage: 'This Prop Array is Required for testing purposes.')
  set requiredAndLengthLimited(List? value) =>
      props[_$key__requiredAndLengthLimited___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.lateProp] -->
  @override
  bool get lateProp =>
      (props[_$key__lateProp___$ComponentTestProps] ?? null) as bool;

  /// <!-- Generated from [_$ComponentTestProps.lateProp] -->
  @override
  set lateProp(bool value) =>
      props[_$key__lateProp___$ComponentTestProps] = value;
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
  static const PropDescriptor
      _$prop__requiredAndLengthLimited___$ComponentTestProps = PropDescriptor(
          _$key__requiredAndLengthLimited___$ComponentTestProps,
          isRequired: true,
          errorMessage: 'This Prop Array is Required for testing purposes.');
  static const PropDescriptor _$prop__lateProp___$ComponentTestProps =
      PropDescriptor(_$key__lateProp___$ComponentTestProps,
          isRequired: true, isNullable: true);
  static const String _$key__required___$ComponentTestProps =
      'ComponentTestProps.required';
  static const String _$key__nullable___$ComponentTestProps =
      'ComponentTestProps.nullable';
  static const String _$key__requiredAndLengthLimited___$ComponentTestProps =
      'ComponentTestProps.requiredAndLengthLimited';
  static const String _$key__lateProp___$ComponentTestProps =
      'ComponentTestProps.lateProp';

  static const List<PropDescriptor> $props = [
    _$prop__required___$ComponentTestProps,
    _$prop__nullable___$ComponentTestProps,
    _$prop__requiredAndLengthLimited___$ComponentTestProps,
    _$prop__lateProp___$ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__required___$ComponentTestProps,
    _$key__nullable___$ComponentTestProps,
    _$key__requiredAndLengthLimited___$ComponentTestProps,
    _$key__lateProp___$ComponentTestProps
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

_$$ComponentTestProps _$ComponentTest([Map? backingProps]) =>
    _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ComponentTestProps extends _$ComponentTestProps
    with _$ComponentTestPropsAccessorsMixin
    implements ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps(Map? backingMap) : this._props = {} {
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
  late _$$ComponentTestProps _cachedTypedProps;

  @override
  _$$ComponentTestProps get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$ComponentTestProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ComponentTestProps(backingMap);

  @override
  _$$ComponentTestProps typedPropsFactory(Map? backingMap) =>
      _$$ComponentTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ComponentTest';

  /// The default consumed props, taken from _$ComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForComponentTestProps
  ];
}
