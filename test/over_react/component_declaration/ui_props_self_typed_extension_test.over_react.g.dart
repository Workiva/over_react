// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'ui_props_self_typed_extension_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $TestProps on TestProps {
  static const PropsMeta meta = _$metaForTestProps;
  @override
  String get requiredProp =>
      (props[_$key__requiredProp__TestProps] ?? null) as String;
  @override
  set requiredProp(String value) =>
      props[_$key__requiredProp__TestProps] = value;
  @override
  String? get requiredNullableProp =>
      (props[_$key__requiredNullableProp__TestProps] ?? null) as String?;
  @override
  set requiredNullableProp(String? value) =>
      props[_$key__requiredNullableProp__TestProps] = value;
  @override
  String? get optionalProp =>
      (props[_$key__optionalProp__TestProps] ?? null) as String?;
  @override
  set optionalProp(String? value) =>
      props[_$key__optionalProp__TestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__requiredProp__TestProps = PropDescriptor(
      _$key__requiredProp__TestProps,
      isRequired: true,
      isNullable: true);
  static const PropDescriptor _$prop__requiredNullableProp__TestProps =
      PropDescriptor(_$key__requiredNullableProp__TestProps,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__optionalProp__TestProps =
      PropDescriptor(_$key__optionalProp__TestProps);
  static const String _$key__requiredProp__TestProps = 'TestProps.requiredProp';
  static const String _$key__requiredNullableProp__TestProps =
      'TestProps.requiredNullableProp';
  static const String _$key__optionalProp__TestProps = 'TestProps.optionalProp';

  static const List<PropDescriptor> $props = [
    _$prop__requiredProp__TestProps,
    _$prop__requiredNullableProp__TestProps,
    _$prop__optionalProp__TestProps
  ];
  static const List<String> $propKeys = [
    _$key__requiredProp__TestProps,
    _$key__requiredNullableProp__TestProps,
    _$key__optionalProp__TestProps
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('TestProps.requiredProp') &&
        !requiredPropNamesToSkipValidation.contains('requiredProp')) {
      throw MissingRequiredPropsError(
          'Required prop `requiredProp` is missing.');
    }

    if (!props.containsKey('TestProps.requiredNullableProp') &&
        !requiredPropNamesToSkipValidation.contains('requiredNullableProp')) {
      throw MissingRequiredPropsError(
          'Required prop `requiredNullableProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForTestProps = PropsMeta(
  fields: $TestProps.$props,
  keys: $TestProps.$propKeys,
);

_$$TestProps _$Test([Map? backingProps]) => _$$TestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$TestProps extends UiProps
    with
        TestProps,
        // If this generated mixin is undefined, it's likely because TestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestProps, and check that $TestProps is exported/imported properly.
        $TestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestProps(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because TestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of TestProps, and check that $TestProps is exported/imported properly.
        TestProps: $TestProps.meta,
      });
}
