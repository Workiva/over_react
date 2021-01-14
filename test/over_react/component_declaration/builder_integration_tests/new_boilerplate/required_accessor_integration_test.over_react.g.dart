// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'required_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ComponentTestComponentFactory = registerComponent2(
  () => _$ComponentTestComponent(),
  builderFactory: _$ComponentTest,
  componentClass: ComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ComponentTest',
);

_$$ComponentTestProps _$ComponentTest([Map backingProps]) =>
    backingProps == null
        ? _$$ComponentTestProps$JsMap(JsBackedMap())
        : _$$ComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ComponentTestProps extends UiProps
    with
        ComponentTestProps,
        $ComponentTestProps // If this generated mixin is undefined, it's likely because ComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestProps, and check that $ComponentTestProps is exported/imported properly.
{
  _$$ComponentTestProps._();

  factory _$$ComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ComponentTestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestProps, and check that $ComponentTestProps is exported/imported properly.
        ComponentTestProps: $ComponentTestProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps$PlainMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ComponentTestProps$JsMap extends _$$ComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ComponentTestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$ComponentTestComponent extends ComponentTestComponent {
  _$$ComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$ComponentTestProps$JsMap get props => _cachedTypedProps;

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
  _$$ComponentTestProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ComponentTestProps$JsMap(backingMap);

  @override
  _$$ComponentTestProps typedPropsFactory(Map backingMap) =>
      _$$ComponentTestProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ComponentTestProps, and check that $ComponentTestProps is exported/imported properly.
        ComponentTestProps: $ComponentTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ComponentTestProps on ComponentTestProps {
  static const PropsMeta meta = _$metaForComponentTestProps;
  @override
  @Accessor(
      isRequired: true,
      requiredErrorMessage: 'This Prop is Required for testing purposes.')
  dynamic get required =>
      (props[_$key__required__ComponentTestProps] ?? null) as dynamic;
  @override
  @Accessor(
      isRequired: true,
      requiredErrorMessage: 'This Prop is Required for testing purposes.')
  set required(dynamic value) =>
      props[_$key__required__ComponentTestProps] = value;
  @override
  @Accessor(
      isRequired: true,
      isNullable: true,
      requiredErrorMessage: 'This prop can be set to null!')
  dynamic get nullable =>
      (props[_$key__nullable__ComponentTestProps] ?? null) as dynamic;
  @override
  @Accessor(
      isRequired: true,
      isNullable: true,
      requiredErrorMessage: 'This prop can be set to null!')
  set nullable(dynamic value) =>
      props[_$key__nullable__ComponentTestProps] = value;
  @override
  @Accessor(
      isRequired: true,
      isNullable: false,
      requiredErrorMessage: 'This Prop Array is Required for testing purposes.')
  List get requiredAndLengthLimited =>
      (props[_$key__requiredAndLengthLimited__ComponentTestProps] ?? null)
          as List;
  @override
  @Accessor(
      isRequired: true,
      isNullable: false,
      requiredErrorMessage: 'This Prop Array is Required for testing purposes.')
  set requiredAndLengthLimited(List value) =>
      props[_$key__requiredAndLengthLimited__ComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__required__ComponentTestProps =
      PropDescriptor(_$key__required__ComponentTestProps,
          isRequired: true,
          errorMessage: 'This Prop is Required for testing purposes.');
  static const PropDescriptor _$prop__nullable__ComponentTestProps =
      PropDescriptor(_$key__nullable__ComponentTestProps,
          isRequired: true,
          isNullable: true,
          errorMessage: 'This prop can be set to null!');
  static const PropDescriptor
      _$prop__requiredAndLengthLimited__ComponentTestProps = PropDescriptor(
          _$key__requiredAndLengthLimited__ComponentTestProps,
          isRequired: true,
          errorMessage: 'This Prop Array is Required for testing purposes.');
  static const String _$key__required__ComponentTestProps =
      'ComponentTestProps.required';
  static const String _$key__nullable__ComponentTestProps =
      'ComponentTestProps.nullable';
  static const String _$key__requiredAndLengthLimited__ComponentTestProps =
      'ComponentTestProps.requiredAndLengthLimited';

  static const List<PropDescriptor> $props = [
    _$prop__required__ComponentTestProps,
    _$prop__nullable__ComponentTestProps,
    _$prop__requiredAndLengthLimited__ComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__required__ComponentTestProps,
    _$key__nullable__ComponentTestProps,
    _$key__requiredAndLengthLimited__ComponentTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForComponentTestProps = PropsMeta(
  fields: $ComponentTestProps.$props,
  keys: $ComponentTestProps.$propKeys,
);
