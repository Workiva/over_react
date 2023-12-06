// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'null_safety_validate_required_props_test.dart';

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
);

abstract class _$ComponentTestPropsAccessorsMixin
    implements _$ComponentTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ComponentTestProps.requiredNonNullable] -->
  @override
  bool get requiredNonNullable =>
      (props[_$key__requiredNonNullable___$ComponentTestProps] ?? null) as bool;

  /// <!-- Generated from [_$ComponentTestProps.requiredNonNullable] -->
  @override
  set requiredNonNullable(bool value) =>
      props[_$key__requiredNonNullable___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.requiredNullable] -->
  @override
  bool? get requiredNullable =>
      (props[_$key__requiredNullable___$ComponentTestProps] ?? null) as bool?;

  /// <!-- Generated from [_$ComponentTestProps.requiredNullable] -->
  @override
  set requiredNullable(bool? value) =>
      props[_$key__requiredNullable___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.requiredDynamic] -->
  @override
  dynamic get requiredDynamic =>
      (props[_$key__requiredDynamic___$ComponentTestProps] ?? null) as dynamic;

  /// <!-- Generated from [_$ComponentTestProps.requiredDynamic] -->
  @override
  set requiredDynamic(dynamic value) =>
      props[_$key__requiredDynamic___$ComponentTestProps] = value;

  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  bool? get nullable =>
      (props[_$key__nullable___$ComponentTestProps] ?? null) as bool?;

  /// <!-- Generated from [_$ComponentTestProps.nullable] -->
  @override
  set nullable(bool? value) =>
      props[_$key__nullable___$ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__requiredNonNullable___$ComponentTestProps = PropDescriptor(
          _$key__requiredNonNullable___$ComponentTestProps,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor _$prop__requiredNullable___$ComponentTestProps =
      PropDescriptor(_$key__requiredNullable___$ComponentTestProps,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__requiredDynamic___$ComponentTestProps =
      PropDescriptor(_$key__requiredDynamic___$ComponentTestProps,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__nullable___$ComponentTestProps =
      PropDescriptor(_$key__nullable___$ComponentTestProps);
  static const String _$key__requiredNonNullable___$ComponentTestProps =
      'ComponentTestProps.requiredNonNullable';
  static const String _$key__requiredNullable___$ComponentTestProps =
      'ComponentTestProps.requiredNullable';
  static const String _$key__requiredDynamic___$ComponentTestProps =
      'ComponentTestProps.requiredDynamic';
  static const String _$key__nullable___$ComponentTestProps =
      'ComponentTestProps.nullable';

  static const List<PropDescriptor> $props = [
    _$prop__requiredNonNullable___$ComponentTestProps,
    _$prop__requiredNullable___$ComponentTestProps,
    _$prop__requiredDynamic___$ComponentTestProps,
    _$prop__nullable___$ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__requiredNonNullable___$ComponentTestProps,
    _$key__requiredNullable___$ComponentTestProps,
    _$key__requiredDynamic___$ComponentTestProps,
    _$key__nullable___$ComponentTestProps
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    if (!props.containsKey('ComponentTestProps.requiredNonNullable')) {
      throw MissingRequiredPropsError(
          'Required prop `requiredNonNullable` is missing.');
    }

    if (!props.containsKey('ComponentTestProps.requiredNullable')) {
      throw MissingRequiredPropsError(
          'Required prop `requiredNullable` is missing.');
    }

    if (!props.containsKey('ComponentTestProps.requiredDynamic')) {
      throw MissingRequiredPropsError(
          'Required prop `requiredDynamic` is missing.');
    }
  }
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