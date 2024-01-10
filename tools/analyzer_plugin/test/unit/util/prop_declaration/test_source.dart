const source = /*language=dart*/ r'''
//@dart=2.12
// ignore_for_file: deprecated_member_use_from_same_package

import 'package:over_react/over_react.dart';

part '{{PART_PATH}}';


// Give it some supertypes
abstract class NotAPropsClass implements Map {
  String? fieldThatWouldBeAPropInAPropsClass;
}

@Factory()
UiFactory<V2Props> V2 = castUiFactory(_$V2);

// ignore: undefined_class, mixin_of_non_class
class V2Props extends _$V2Props with _$V2PropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForV2Props;
}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$V2Props extends UiProps {
  late String v2_lateRequiredProp;
  String? v2_optionalProp;
  @requiredProp
  String? v2_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v2_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v2_getter => '';
  // ignore: avoid_setters_without_getters
  set v2_setter(_) => '';
  String get v2_getterAndSetter => '';
  set v2_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v2_static_field = '';
  static String get v2_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v2_static_setter(_) => '';
  static String get v2_static_getterAndSetter => '';
  static set v2_static_getterAndSetter(String _) {}
}

@Component()
class V2Component extends UiComponent2<V2Props> {
  @override
  render() {}
}

@Factory()
UiFactory<V3Props> V3 = castUiFactory(_$V3);

@Deprecated('This is deprecated')
@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$V3Props extends UiProps {
  late String v3_lateRequiredProp;
  String? v3_optionalProp;
  @requiredProp
  String? v3_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v3_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v3_getter => '';
  // ignore: avoid_setters_without_getters
  set v3_setter(_) => '';
  String get v3_getterAndSetter => '';
  set v3_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v3_static_field = '';
  static String get v3_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v3_static_setter(_) => '';
  static String get v3_static_getterAndSetter => '';
  static set v3_static_getterAndSetter(String _) {}
}

@Component()
class V3Component extends UiComponent2<V3Props> {
  @override
  render() {}
}


UiFactory<V4Props> V4 = castUiFactory(_$V4);

mixin V4PropsMixin on UiProps {
  late String v4_lateRequiredProp;
  String? v4_optionalProp;
  @requiredProp
  String? v4_annotationRequiredProp;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v4_doNotGenerate;

  //
  // Non-props: instance members
  //
  String get v4_getter => '';
  // ignore: avoid_setters_without_getters
  set v4_setter(_) => '';
  String get v4_getterAndSetter => '';
  set v4_getterAndSetter(String _) {}

  //
  // Non-props: static members
  //
  static String v4_static_field = '';
  static String get v4_static_getter => '';
  // ignore: avoid_setters_without_getters
  static set v4_static_setter(_) => '';
  static String get v4_static_getterAndSetter => '';
  static set v4_static_getterAndSetter(String _) {}
}

class V4Props = UiProps with V4PropsMixin;

class V4Component extends UiComponent2<V4Props> {
  @override
  render() {}
}

//
// Props mixins
//


@PropsMixin()
abstract class V2PropsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForV2PropsMixin;

  Map get props;

  late String v2_lateRequiredProp_inMixin;
  String? v2_optionalProp_inMixin;
  @requiredProp
  String? v2_annotationRequiredProp_inMixin;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v2_doNotGenerate_inMixin;

  //
  // Non-props: instance members
  //
  String get v2_getter_inMixin => '';
  // ignore: avoid_setters_without_getters
  set v2_setter_inMixin(_) => '';
  String get v2_getterAndSetter_inMixin => '';
  set v2_getterAndSetter_inMixin(String _) {}

  //
  // Non-props: static members
  //
  static String v2_static_field_inMixin = '';
  static String get v2_static_getter_inMixin => '';
  // ignore: avoid_setters_without_getters
  static set v2_static_setter_inMixin(_) => '';
  static String get v2_static_getterAndSetter_inMixin => '';
  static set v2_static_getterAndSetter_inMixin(String _) {}
}

@deprecated
@PropsMixin()
abstract class _$V3PropsMixin implements UiProps {
  @override
  Map get props;

  late String v3_lateRequiredProp_inMixin;
  String? v3_optionalProp_inMixin;
  @requiredProp
  String? v3_annotationRequiredProp_inMixin;

  //
  // Non-props: edge-cases
  //
  @Accessor(doNotGenerate: true)
  String? v3_doNotGenerate_inMixin;

  //
  // Non-props: instance members
  //
  String get v3_getter_inMixin => '';
  // ignore: avoid_setters_without_getters
  set v3_setter_inMixin(_) => '';
  String get v3_getterAndSetter_inMixin => '';
  set v3_getterAndSetter_inMixin(String _) {}

  //
  // Non-props: static members
  //
  static String v3_static_field_inMixin = '';
  static String get v3_static_getter_inMixin => '';
  // ignore: avoid_setters_without_getters
  static set v3_static_setter_inMixin(_) => '';
  static String get v3_static_getterAndSetter_inMixin => '';
  static set v3_static_getterAndSetter_inMixin(String _) {}
}

// V4 props can only be declared in mixins; this case is covered by other V4 cases


//
// Extending props classes
//


@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<ExtendsV2Props> ExtendsV2 = castUiFactory(_$ExtendsV2);

// ignore: undefined_class, mixin_of_non_class
class ExtendsV2Props extends _$ExtendsV2Props with _$ExtendsV2PropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForExtendsV2Props;
}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$ExtendsV2Props extends V2Props with
    V2PropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $V2PropsMixin {
  late String v2_lateRequiredProp_inSubclass;
  String? v2_optionalProp_inSubclass;
}

@Component()
class ExtendsV2Component extends UiComponent2<ExtendsV2Props> {
  @override
  render() {}
}


@Factory()
UiFactory<ExtendsV3Props> ExtendsV3 = castUiFactory(_$ExtendsV3);

@Deprecated('This is deprecated')
@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$ExtendsV3Props extends V3Props with V3PropsMixin {
  late String v3_lateRequiredProp_inSubclass;
  String? v3_optionalProp_inSubclass;
}

@Component()
class ExtendsV3Component extends UiComponent2<ExtendsV3Props> {
  @override
  render() {}
}


UiFactory<ExtendsV4Props> ExtendsV4 = castUiFactory(_$ExtendsV4);

mixin ExtendsV4PropsMixin on UiProps {
  late String v4_lateRequiredProp_inSubclass;
  String? v4_optionalProp_inSubclass;
}

class ExtendsV4Props = UiProps with V4PropsMixin, ExtendsV4PropsMixin;
class ExtendsV4Component extends UiComponent2<ExtendsV4Props> {
  @override
  render() {}
}


mixin OverriddenTestBaseProps on UiProps{
   late String? v4_lateRequiredProp_optionalInOtherType;
   String? v4_optionalProp_requiredInOtherType;
}

mixin OverriddenTestSubtypeProps on UiProps, OverriddenTestBaseProps {
   // Invert requiredness compared to base class
   @override
   String? v4_lateRequiredProp_optionalInOtherType;
   @override
   late String? v4_optionalProp_requiredInOtherType;
}

mixin OverriddenTestUnrelatedClassPropsMixin on UiProps {
   // Invert requiredness compared to base class
   String? v4_lateRequiredProp_optionalInOtherType;
   late String? v4_optionalProp_requiredInOtherType;
}


// Fields in `OverriddenTestUnrelatedClassPropsMixin` "override" fields in `OverriddenTestBaseProps` when mixed in.
UiFactory<OverriddenTestUnrelatedClassProps> OverriddenTestUnrelatedClass = castUiFactory(_$OverriddenTestUnrelatedClass);
class OverriddenTestUnrelatedClassProps = UiProps with OverriddenTestBaseProps, OverriddenTestUnrelatedClassPropsMixin;


mixin DisableRequiredPropValidationProps on UiProps {
  late String lateRequired;
  
  @disableRequiredPropValidation
  late String lateRequiredWithValidationDisabled;
}

UiFactory<ExtendsDisableRequiredPropValidationProps> ExtendsDisableRequiredPropValidation = castUiFactory(_$ExtendsDisableRequiredPropValidation);
class ExtendsDisableRequiredPropValidationProps = UiProps with DisableRequiredPropValidationProps;

''';

const partSource = /*language=dart*/ r'''
//@dart=2.12

part of '{{PART_OF_PATH}}';



// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $V4ComponentFactory = registerComponent2(
  () => _$V4Component(),
  builderFactory: _$V4,
  componentClass: V4Component,
  isWrapper: false,
  parentType: null,
);

_$$V4Props _$V4([Map? backingProps]) => backingProps == null
    ? _$$V4Props$JsMap(JsBackedMap())
    : _$$V4Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$V4Props extends UiProps
    with
        V4PropsMixin,
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        $V4PropsMixin
    implements
        V4Props {
  _$$V4Props._();

  factory _$$V4Props(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$V4Props$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$V4Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $V4ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        V4PropsMixin: $V4PropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V4Props(accessMap, (map) => _$$V4Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V4Props = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$V4Props$PlainMap extends _$$V4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V4Props$PlainMap(Map? backingMap)
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
class _$$V4Props$JsMap extends _$$V4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V4Props$JsMap(JsBackedMap? backingMap)
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
class _$V4Component extends V4Component {
  late _$$V4Props$JsMap _cachedTypedProps;

  @override
  _$$V4Props$JsMap get props => _cachedTypedProps;

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
  _$$V4Props$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$V4Props$JsMap(backingMap);

  @override
  _$$V4Props typedPropsFactory(Map? backingMap) => _$$V4Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V4';

  /// The default consumed props, comprising all props mixins used by V4Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        V4PropsMixin: $V4PropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ExtendsV4ComponentFactory = registerComponent2(
  () => _$ExtendsV4Component(),
  builderFactory: _$ExtendsV4,
  componentClass: ExtendsV4Component,
  isWrapper: false,
  parentType: null,
);

_$$ExtendsV4Props _$ExtendsV4([Map? backingProps]) => backingProps == null
    ? _$$ExtendsV4Props$JsMap(JsBackedMap())
    : _$$ExtendsV4Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExtendsV4Props extends UiProps
    with
        V4PropsMixin,
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        $V4PropsMixin,
        ExtendsV4PropsMixin,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        $ExtendsV4PropsMixin
    implements
        ExtendsV4Props {
  _$$ExtendsV4Props._();

  factory _$$ExtendsV4Props(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExtendsV4Props$JsMap(backingMap as JsBackedMap?);
    } else {
      return _$$ExtendsV4Props$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ExtendsV4ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        V4PropsMixin: $V4PropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        ExtendsV4PropsMixin: $ExtendsV4PropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV4Props(
          accessMap, (map) => _$$ExtendsV4Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV4Props = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExtendsV4Props$PlainMap extends _$$ExtendsV4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV4Props$PlainMap(Map? backingMap)
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
class _$$ExtendsV4Props$JsMap extends _$$ExtendsV4Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV4Props$JsMap(JsBackedMap? backingMap)
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
class _$ExtendsV4Component extends ExtendsV4Component {
  late _$$ExtendsV4Props$JsMap _cachedTypedProps;

  @override
  _$$ExtendsV4Props$JsMap get props => _cachedTypedProps;

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
  _$$ExtendsV4Props$JsMap typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$ExtendsV4Props$JsMap(backingMap);

  @override
  _$$ExtendsV4Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV4Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV4';

  /// The default consumed props, comprising all props mixins used by ExtendsV4Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because V4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of V4PropsMixin, and check that $V4PropsMixin is exported/imported properly.
        V4PropsMixin: $V4PropsMixin.meta,
        // If this generated mixin is undefined, it's likely because ExtendsV4PropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of ExtendsV4PropsMixin, and check that $ExtendsV4PropsMixin is exported/imported properly.
        ExtendsV4PropsMixin: $ExtendsV4PropsMixin.meta,
      });
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $V2ComponentFactory = registerComponent(
  () => _$V2Component(),
  builderFactory: _$V2,
  componentClass: V2Component,
  isWrapper: false,
  parentType: null,
);

abstract class _$V2PropsAccessorsMixin implements _$V2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$V2Props.v2_lateRequiredProp] -->
  @override
  String get v2_lateRequiredProp =>
      (props[_$key__v2_lateRequiredProp___$V2Props] ?? null) as String;

  /// <!-- Generated from [_$V2Props.v2_lateRequiredProp] -->
  @override
  set v2_lateRequiredProp(String value) =>
      props[_$key__v2_lateRequiredProp___$V2Props] = value;

  /// <!-- Generated from [_$V2Props.v2_optionalProp] -->
  @override
  String? get v2_optionalProp =>
      (props[_$key__v2_optionalProp___$V2Props] ?? null) as String?;

  /// <!-- Generated from [_$V2Props.v2_optionalProp] -->
  @override
  set v2_optionalProp(String? value) =>
      props[_$key__v2_optionalProp___$V2Props] = value;

  /// <!-- Generated from [_$V2Props.v2_annotationRequiredProp] -->
  @override
  @requiredProp
  String? get v2_annotationRequiredProp =>
      (props[_$key__v2_annotationRequiredProp___$V2Props] ?? null) as String?;

  /// <!-- Generated from [_$V2Props.v2_annotationRequiredProp] -->
  @override
  @requiredProp
  set v2_annotationRequiredProp(String? value) =>
      props[_$key__v2_annotationRequiredProp___$V2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v2_lateRequiredProp___$V2Props =
      PropDescriptor(_$key__v2_lateRequiredProp___$V2Props,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v2_optionalProp___$V2Props =
      PropDescriptor(_$key__v2_optionalProp___$V2Props);
  static const PropDescriptor _$prop__v2_annotationRequiredProp___$V2Props =
      PropDescriptor(_$key__v2_annotationRequiredProp___$V2Props,
          isRequired: true);
  static const String _$key__v2_lateRequiredProp___$V2Props =
      'V2Props.v2_lateRequiredProp';
  static const String _$key__v2_optionalProp___$V2Props =
      'V2Props.v2_optionalProp';
  static const String _$key__v2_annotationRequiredProp___$V2Props =
      'V2Props.v2_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v2_lateRequiredProp___$V2Props,
    _$prop__v2_optionalProp___$V2Props,
    _$prop__v2_annotationRequiredProp___$V2Props
  ];
  static const List<String> $propKeys = [
    _$key__v2_lateRequiredProp___$V2Props,
    _$key__v2_optionalProp___$V2Props,
    _$key__v2_annotationRequiredProp___$V2Props
  ];
}

const PropsMeta _$metaForV2Props = PropsMeta(
  fields: _$V2PropsAccessorsMixin.$props,
  keys: _$V2PropsAccessorsMixin.$propKeys,
);

_$$V2Props _$V2([Map? backingProps]) => _$$V2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$V2Props extends _$V2Props
    with _$V2PropsAccessorsMixin
    implements V2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V2Props(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $V2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'V2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V2Props(accessMap, (map) => _$$V2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$V2Component extends V2Component {
  @override
  _$$V2Props typedPropsFactory(Map? backingMap) => _$$V2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V2';

  /// The default consumed props, taken from _$V2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForV2Props];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $V3ComponentFactory = registerComponent(
  () => _$V3Component(),
  builderFactory: _$V3,
  componentClass: V3Component,
  isWrapper: false,
  parentType: null,
);

@Deprecated('This is deprecated')
abstract class _$V3PropsAccessorsMixin implements _$V3Props {
  @override
  Map get props;

  /// <!-- Generated from [_$V3Props.v3_lateRequiredProp] -->
  @override
  String get v3_lateRequiredProp =>
      (props[_$key__v3_lateRequiredProp___$V3Props] ?? null) as String;

  /// <!-- Generated from [_$V3Props.v3_lateRequiredProp] -->
  @override
  set v3_lateRequiredProp(String value) =>
      props[_$key__v3_lateRequiredProp___$V3Props] = value;

  /// <!-- Generated from [_$V3Props.v3_optionalProp] -->
  @override
  String? get v3_optionalProp =>
      (props[_$key__v3_optionalProp___$V3Props] ?? null) as String?;

  /// <!-- Generated from [_$V3Props.v3_optionalProp] -->
  @override
  set v3_optionalProp(String? value) =>
      props[_$key__v3_optionalProp___$V3Props] = value;

  /// <!-- Generated from [_$V3Props.v3_annotationRequiredProp] -->
  @override
  @requiredProp
  String? get v3_annotationRequiredProp =>
      (props[_$key__v3_annotationRequiredProp___$V3Props] ?? null) as String?;

  /// <!-- Generated from [_$V3Props.v3_annotationRequiredProp] -->
  @override
  @requiredProp
  set v3_annotationRequiredProp(String? value) =>
      props[_$key__v3_annotationRequiredProp___$V3Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v3_lateRequiredProp___$V3Props =
      PropDescriptor(_$key__v3_lateRequiredProp___$V3Props,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v3_optionalProp___$V3Props =
      PropDescriptor(_$key__v3_optionalProp___$V3Props);
  static const PropDescriptor _$prop__v3_annotationRequiredProp___$V3Props =
      PropDescriptor(_$key__v3_annotationRequiredProp___$V3Props,
          isRequired: true);
  static const String _$key__v3_lateRequiredProp___$V3Props =
      'V3Props.v3_lateRequiredProp';
  static const String _$key__v3_optionalProp___$V3Props =
      'V3Props.v3_optionalProp';
  static const String _$key__v3_annotationRequiredProp___$V3Props =
      'V3Props.v3_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v3_lateRequiredProp___$V3Props,
    _$prop__v3_optionalProp___$V3Props,
    _$prop__v3_annotationRequiredProp___$V3Props
  ];
  static const List<String> $propKeys = [
    _$key__v3_lateRequiredProp___$V3Props,
    _$key__v3_optionalProp___$V3Props,
    _$key__v3_annotationRequiredProp___$V3Props
  ];
}

const PropsMeta _$metaForV3Props = PropsMeta(
  fields: _$V3PropsAccessorsMixin.$props,
  keys: _$V3PropsAccessorsMixin.$propKeys,
);

@Deprecated('This is deprecated')
class V3Props extends _$V3Props with _$V3PropsAccessorsMixin {
  static String v3_static_field = '';
  static String get v3_static_getter => '';
  static set v3_static_setter(_) => '';
  static String get v3_static_getterAndSetter => '';
  static set v3_static_getterAndSetter(String _) {}
  static const PropsMeta meta = _$metaForV3Props;
}

_$$V3Props _$V3([Map? backingProps]) => _$$V3Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$V3Props extends _$V3Props
    with _$V3PropsAccessorsMixin
    implements V3Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$V3Props(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $V3ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'V3Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$V3Props(accessMap, (map) => _$$V3Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$V3Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$V3Component extends V3Component {
  @override
  _$$V3Props typedPropsFactory(Map? backingMap) => _$$V3Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'V3';

  /// The default consumed props, taken from _$V3Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForV3Props];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ExtendsV2ComponentFactory = registerComponent(
  () => _$ExtendsV2Component(),
  builderFactory: _$ExtendsV2,
  componentClass: ExtendsV2Component,
  isWrapper: false,
  parentType: null,
);

abstract class _$ExtendsV2PropsAccessorsMixin implements _$ExtendsV2Props {
  @override
  Map get props;

  /// <!-- Generated from [_$ExtendsV2Props.v2_lateRequiredProp_inSubclass] -->
  @override
  String get v2_lateRequiredProp_inSubclass =>
      (props[_$key__v2_lateRequiredProp_inSubclass___$ExtendsV2Props] ?? null)
          as String;

  /// <!-- Generated from [_$ExtendsV2Props.v2_lateRequiredProp_inSubclass] -->
  @override
  set v2_lateRequiredProp_inSubclass(String value) =>
      props[_$key__v2_lateRequiredProp_inSubclass___$ExtendsV2Props] = value;

  /// <!-- Generated from [_$ExtendsV2Props.v2_optionalProp_inSubclass] -->
  @override
  String? get v2_optionalProp_inSubclass =>
      (props[_$key__v2_optionalProp_inSubclass___$ExtendsV2Props] ?? null)
          as String?;

  /// <!-- Generated from [_$ExtendsV2Props.v2_optionalProp_inSubclass] -->
  @override
  set v2_optionalProp_inSubclass(String? value) =>
      props[_$key__v2_optionalProp_inSubclass___$ExtendsV2Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v2_lateRequiredProp_inSubclass___$ExtendsV2Props = PropDescriptor(
          _$key__v2_lateRequiredProp_inSubclass___$ExtendsV2Props,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor
      _$prop__v2_optionalProp_inSubclass___$ExtendsV2Props =
      PropDescriptor(_$key__v2_optionalProp_inSubclass___$ExtendsV2Props);
  static const String _$key__v2_lateRequiredProp_inSubclass___$ExtendsV2Props =
      'ExtendsV2Props.v2_lateRequiredProp_inSubclass';
  static const String _$key__v2_optionalProp_inSubclass___$ExtendsV2Props =
      'ExtendsV2Props.v2_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v2_lateRequiredProp_inSubclass___$ExtendsV2Props,
    _$prop__v2_optionalProp_inSubclass___$ExtendsV2Props
  ];
  static const List<String> $propKeys = [
    _$key__v2_lateRequiredProp_inSubclass___$ExtendsV2Props,
    _$key__v2_optionalProp_inSubclass___$ExtendsV2Props
  ];
}

const PropsMeta _$metaForExtendsV2Props = PropsMeta(
  fields: _$ExtendsV2PropsAccessorsMixin.$props,
  keys: _$ExtendsV2PropsAccessorsMixin.$propKeys,
);

_$$ExtendsV2Props _$ExtendsV2([Map? backingProps]) =>
    _$$ExtendsV2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ExtendsV2Props extends _$ExtendsV2Props
    with _$ExtendsV2PropsAccessorsMixin
    implements ExtendsV2Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV2Props(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $ExtendsV2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ExtendsV2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV2Props(
          accessMap, (map) => _$$ExtendsV2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ExtendsV2Component extends ExtendsV2Component {
  @override
  _$$ExtendsV2Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV2';

  /// The default consumed props, taken from _$ExtendsV2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForExtendsV2Props
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ExtendsV3ComponentFactory = registerComponent(
  () => _$ExtendsV3Component(),
  builderFactory: _$ExtendsV3,
  componentClass: ExtendsV3Component,
  isWrapper: false,
  parentType: null,
);

@Deprecated('This is deprecated')
abstract class _$ExtendsV3PropsAccessorsMixin implements _$ExtendsV3Props {
  @override
  Map get props;

  /// <!-- Generated from [_$ExtendsV3Props.v3_lateRequiredProp_inSubclass] -->
  @override
  String get v3_lateRequiredProp_inSubclass =>
      (props[_$key__v3_lateRequiredProp_inSubclass___$ExtendsV3Props] ?? null)
          as String;

  /// <!-- Generated from [_$ExtendsV3Props.v3_lateRequiredProp_inSubclass] -->
  @override
  set v3_lateRequiredProp_inSubclass(String value) =>
      props[_$key__v3_lateRequiredProp_inSubclass___$ExtendsV3Props] = value;

  /// <!-- Generated from [_$ExtendsV3Props.v3_optionalProp_inSubclass] -->
  @override
  String? get v3_optionalProp_inSubclass =>
      (props[_$key__v3_optionalProp_inSubclass___$ExtendsV3Props] ?? null)
          as String?;

  /// <!-- Generated from [_$ExtendsV3Props.v3_optionalProp_inSubclass] -->
  @override
  set v3_optionalProp_inSubclass(String? value) =>
      props[_$key__v3_optionalProp_inSubclass___$ExtendsV3Props] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v3_lateRequiredProp_inSubclass___$ExtendsV3Props = PropDescriptor(
          _$key__v3_lateRequiredProp_inSubclass___$ExtendsV3Props,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor
      _$prop__v3_optionalProp_inSubclass___$ExtendsV3Props =
      PropDescriptor(_$key__v3_optionalProp_inSubclass___$ExtendsV3Props);
  static const String _$key__v3_lateRequiredProp_inSubclass___$ExtendsV3Props =
      'ExtendsV3Props.v3_lateRequiredProp_inSubclass';
  static const String _$key__v3_optionalProp_inSubclass___$ExtendsV3Props =
      'ExtendsV3Props.v3_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v3_lateRequiredProp_inSubclass___$ExtendsV3Props,
    _$prop__v3_optionalProp_inSubclass___$ExtendsV3Props
  ];
  static const List<String> $propKeys = [
    _$key__v3_lateRequiredProp_inSubclass___$ExtendsV3Props,
    _$key__v3_optionalProp_inSubclass___$ExtendsV3Props
  ];
}

const PropsMeta _$metaForExtendsV3Props = PropsMeta(
  fields: _$ExtendsV3PropsAccessorsMixin.$props,
  keys: _$ExtendsV3PropsAccessorsMixin.$propKeys,
);

@Deprecated('This is deprecated')
class ExtendsV3Props extends _$ExtendsV3Props
    with _$ExtendsV3PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForExtendsV3Props;
}

_$$ExtendsV3Props _$ExtendsV3([Map? backingProps]) =>
    _$$ExtendsV3Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ExtendsV3Props extends _$ExtendsV3Props
    with _$ExtendsV3PropsAccessorsMixin
    implements ExtendsV3Props {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsV3Props(Map? backingMap) : this._props = {} {
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
      super.componentFactory ?? $ExtendsV3ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ExtendsV3Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsV3Props(
          accessMap, (map) => _$$ExtendsV3Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsV3Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ExtendsV3Component extends ExtendsV3Component {
  @override
  _$$ExtendsV3Props typedPropsFactory(Map? backingMap) =>
      _$$ExtendsV3Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'ExtendsV3';

  /// The default consumed props, taken from _$ExtendsV3Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForExtendsV3Props
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $V4PropsMixin on V4PropsMixin {
  static const PropsMeta meta = _$metaForV4PropsMixin;
  @override
  String get v4_lateRequiredProp =>
      (props[_$key__v4_lateRequiredProp__V4PropsMixin] ?? null) as String;
  @override
  set v4_lateRequiredProp(String value) =>
      props[_$key__v4_lateRequiredProp__V4PropsMixin] = value;
  @override
  String? get v4_optionalProp =>
      (props[_$key__v4_optionalProp__V4PropsMixin] ?? null) as String?;
  @override
  set v4_optionalProp(String? value) =>
      props[_$key__v4_optionalProp__V4PropsMixin] = value;
  @override
  @requiredProp
  String? get v4_annotationRequiredProp =>
      (props[_$key__v4_annotationRequiredProp__V4PropsMixin] ?? null)
          as String?;
  @override
  @requiredProp
  set v4_annotationRequiredProp(String? value) =>
      props[_$key__v4_annotationRequiredProp__V4PropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__v4_lateRequiredProp__V4PropsMixin =
      PropDescriptor(_$key__v4_lateRequiredProp__V4PropsMixin,
          isRequired: true, isNullable: true);
  static const PropDescriptor _$prop__v4_optionalProp__V4PropsMixin =
      PropDescriptor(_$key__v4_optionalProp__V4PropsMixin);
  static const PropDescriptor _$prop__v4_annotationRequiredProp__V4PropsMixin =
      PropDescriptor(_$key__v4_annotationRequiredProp__V4PropsMixin,
          isRequired: true);
  static const String _$key__v4_lateRequiredProp__V4PropsMixin =
      'V4PropsMixin.v4_lateRequiredProp';
  static const String _$key__v4_optionalProp__V4PropsMixin =
      'V4PropsMixin.v4_optionalProp';
  static const String _$key__v4_annotationRequiredProp__V4PropsMixin =
      'V4PropsMixin.v4_annotationRequiredProp';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp__V4PropsMixin,
    _$prop__v4_optionalProp__V4PropsMixin,
    _$prop__v4_annotationRequiredProp__V4PropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp__V4PropsMixin,
    _$key__v4_optionalProp__V4PropsMixin,
    _$key__v4_annotationRequiredProp__V4PropsMixin
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('V4PropsMixin.v4_lateRequiredProp')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_lateRequiredProp` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForV4PropsMixin = PropsMeta(
  fields: $V4PropsMixin.$props,
  keys: $V4PropsMixin.$propKeys,
);

abstract class $V2PropsMixin implements V2PropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForV2PropsMixin;
  static String v2_static_field_inMixin = '';
  static String get v2_static_getter_inMixin => '';
  static set v2_static_setter_inMixin(_) => '';
  static String get v2_static_getterAndSetter_inMixin => '';
  static set v2_static_getterAndSetter_inMixin(String _) {}
  @override
  @Accessor(doNotGenerate: true)
  String? v2_doNotGenerate_inMixin;
  @override
  String get v2_getter_inMixin => '';
  @override
  set v2_setter_inMixin(_) => '';
  @override
  String get v2_getterAndSetter_inMixin => '';
  @override
  set v2_getterAndSetter_inMixin(String _) {}

  /// <!-- Generated from [V2PropsMixin.v2_lateRequiredProp_inMixin] -->
  @override
  String get v2_lateRequiredProp_inMixin =>
      (props[_$key__v2_lateRequiredProp_inMixin__V2PropsMixin] ?? null)
          as String;

  /// <!-- Generated from [V2PropsMixin.v2_lateRequiredProp_inMixin] -->
  @override
  set v2_lateRequiredProp_inMixin(String value) =>
      props[_$key__v2_lateRequiredProp_inMixin__V2PropsMixin] = value;

  /// <!-- Generated from [V2PropsMixin.v2_optionalProp_inMixin] -->
  @override
  String? get v2_optionalProp_inMixin =>
      (props[_$key__v2_optionalProp_inMixin__V2PropsMixin] ?? null) as String?;

  /// <!-- Generated from [V2PropsMixin.v2_optionalProp_inMixin] -->
  @override
  set v2_optionalProp_inMixin(String? value) =>
      props[_$key__v2_optionalProp_inMixin__V2PropsMixin] = value;

  /// <!-- Generated from [V2PropsMixin.v2_annotationRequiredProp_inMixin] -->
  @override
  @requiredProp
  String? get v2_annotationRequiredProp_inMixin =>
      (props[_$key__v2_annotationRequiredProp_inMixin__V2PropsMixin] ?? null)
          as String?;

  /// <!-- Generated from [V2PropsMixin.v2_annotationRequiredProp_inMixin] -->
  @override
  @requiredProp
  set v2_annotationRequiredProp_inMixin(String? value) =>
      props[_$key__v2_annotationRequiredProp_inMixin__V2PropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v2_lateRequiredProp_inMixin__V2PropsMixin = PropDescriptor(
          _$key__v2_lateRequiredProp_inMixin__V2PropsMixin,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor _$prop__v2_optionalProp_inMixin__V2PropsMixin =
      PropDescriptor(_$key__v2_optionalProp_inMixin__V2PropsMixin);
  static const PropDescriptor
      _$prop__v2_annotationRequiredProp_inMixin__V2PropsMixin = PropDescriptor(
          _$key__v2_annotationRequiredProp_inMixin__V2PropsMixin,
          isRequired: true);
  static const String _$key__v2_lateRequiredProp_inMixin__V2PropsMixin =
      'V2PropsMixin.v2_lateRequiredProp_inMixin';
  static const String _$key__v2_optionalProp_inMixin__V2PropsMixin =
      'V2PropsMixin.v2_optionalProp_inMixin';
  static const String _$key__v2_annotationRequiredProp_inMixin__V2PropsMixin =
      'V2PropsMixin.v2_annotationRequiredProp_inMixin';

  static const List<PropDescriptor> $props = [
    _$prop__v2_lateRequiredProp_inMixin__V2PropsMixin,
    _$prop__v2_optionalProp_inMixin__V2PropsMixin,
    _$prop__v2_annotationRequiredProp_inMixin__V2PropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v2_lateRequiredProp_inMixin__V2PropsMixin,
    _$key__v2_optionalProp_inMixin__V2PropsMixin,
    _$key__v2_annotationRequiredProp_inMixin__V2PropsMixin
  ];
}

const PropsMeta _$metaForV2PropsMixin = PropsMeta(
  fields: $V2PropsMixin.$props,
  keys: $V2PropsMixin.$propKeys,
);

@deprecated
abstract class V3PropsMixin implements _$V3PropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForV3PropsMixin;
  static String v3_static_field_inMixin = '';
  static String get v3_static_getter_inMixin => '';
  static set v3_static_setter_inMixin(_) => '';
  static String get v3_static_getterAndSetter_inMixin => '';
  static set v3_static_getterAndSetter_inMixin(String _) {}
  @override
  @Accessor(doNotGenerate: true)
  String? v3_doNotGenerate_inMixin;
  @override
  String get v3_getter_inMixin => '';
  @override
  set v3_setter_inMixin(_) => '';
  @override
  String get v3_getterAndSetter_inMixin => '';
  @override
  set v3_getterAndSetter_inMixin(String _) {}

  /// <!-- Generated from [_$V3PropsMixin.v3_lateRequiredProp_inMixin] -->
  @override
  String get v3_lateRequiredProp_inMixin =>
      (props[_$key__v3_lateRequiredProp_inMixin___$V3PropsMixin] ?? null)
          as String;

  /// <!-- Generated from [_$V3PropsMixin.v3_lateRequiredProp_inMixin] -->
  @override
  set v3_lateRequiredProp_inMixin(String value) =>
      props[_$key__v3_lateRequiredProp_inMixin___$V3PropsMixin] = value;

  /// <!-- Generated from [_$V3PropsMixin.v3_optionalProp_inMixin] -->
  @override
  String? get v3_optionalProp_inMixin =>
      (props[_$key__v3_optionalProp_inMixin___$V3PropsMixin] ?? null)
          as String?;

  /// <!-- Generated from [_$V3PropsMixin.v3_optionalProp_inMixin] -->
  @override
  set v3_optionalProp_inMixin(String? value) =>
      props[_$key__v3_optionalProp_inMixin___$V3PropsMixin] = value;

  /// <!-- Generated from [_$V3PropsMixin.v3_annotationRequiredProp_inMixin] -->
  @override
  @requiredProp
  String? get v3_annotationRequiredProp_inMixin =>
      (props[_$key__v3_annotationRequiredProp_inMixin___$V3PropsMixin] ?? null)
          as String?;

  /// <!-- Generated from [_$V3PropsMixin.v3_annotationRequiredProp_inMixin] -->
  @override
  @requiredProp
  set v3_annotationRequiredProp_inMixin(String? value) =>
      props[_$key__v3_annotationRequiredProp_inMixin___$V3PropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v3_lateRequiredProp_inMixin___$V3PropsMixin = PropDescriptor(
          _$key__v3_lateRequiredProp_inMixin___$V3PropsMixin,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor _$prop__v3_optionalProp_inMixin___$V3PropsMixin =
      PropDescriptor(_$key__v3_optionalProp_inMixin___$V3PropsMixin);
  static const PropDescriptor
      _$prop__v3_annotationRequiredProp_inMixin___$V3PropsMixin =
      PropDescriptor(_$key__v3_annotationRequiredProp_inMixin___$V3PropsMixin,
          isRequired: true);
  static const String _$key__v3_lateRequiredProp_inMixin___$V3PropsMixin =
      'V3PropsMixin.v3_lateRequiredProp_inMixin';
  static const String _$key__v3_optionalProp_inMixin___$V3PropsMixin =
      'V3PropsMixin.v3_optionalProp_inMixin';
  static const String _$key__v3_annotationRequiredProp_inMixin___$V3PropsMixin =
      'V3PropsMixin.v3_annotationRequiredProp_inMixin';

  static const List<PropDescriptor> $props = [
    _$prop__v3_lateRequiredProp_inMixin___$V3PropsMixin,
    _$prop__v3_optionalProp_inMixin___$V3PropsMixin,
    _$prop__v3_annotationRequiredProp_inMixin___$V3PropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v3_lateRequiredProp_inMixin___$V3PropsMixin,
    _$key__v3_optionalProp_inMixin___$V3PropsMixin,
    _$key__v3_annotationRequiredProp_inMixin___$V3PropsMixin
  ];
}

const PropsMeta _$metaForV3PropsMixin = PropsMeta(
  fields: V3PropsMixin.$props,
  keys: V3PropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ExtendsV4PropsMixin on ExtendsV4PropsMixin {
  static const PropsMeta meta = _$metaForExtendsV4PropsMixin;
  @override
  String get v4_lateRequiredProp_inSubclass =>
      (props[_$key__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin] ??
          null) as String;
  @override
  set v4_lateRequiredProp_inSubclass(String value) =>
      props[_$key__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin] = value;
  @override
  String? get v4_optionalProp_inSubclass =>
      (props[_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin] ?? null)
          as String?;
  @override
  set v4_optionalProp_inSubclass(String? value) =>
      props[_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin =
      PropDescriptor(_$key__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin,
          isRequired: true, isNullable: true);
  static const PropDescriptor
      _$prop__v4_optionalProp_inSubclass__ExtendsV4PropsMixin =
      PropDescriptor(_$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin);
  static const String
      _$key__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin =
      'ExtendsV4PropsMixin.v4_lateRequiredProp_inSubclass';
  static const String _$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin =
      'ExtendsV4PropsMixin.v4_optionalProp_inSubclass';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin,
    _$prop__v4_optionalProp_inSubclass__ExtendsV4PropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp_inSubclass__ExtendsV4PropsMixin,
    _$key__v4_optionalProp_inSubclass__ExtendsV4PropsMixin
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props
        .containsKey('ExtendsV4PropsMixin.v4_lateRequiredProp_inSubclass')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_lateRequiredProp_inSubclass` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForExtendsV4PropsMixin = PropsMeta(
  fields: $ExtendsV4PropsMixin.$props,
  keys: $ExtendsV4PropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $OverriddenTestBaseProps on OverriddenTestBaseProps {
  static const PropsMeta meta = _$metaForOverriddenTestBaseProps;
  @override
  String? get v4_lateRequiredProp_optionalInOtherType => (props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps] ??
      null) as String?;
  @override
  set v4_lateRequiredProp_optionalInOtherType(String? value) => props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps] =
      value;
  @override
  String? get v4_optionalProp_requiredInOtherType => (props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps] ??
      null) as String?;
  @override
  set v4_optionalProp_requiredInOtherType(String? value) => props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps =
      PropDescriptor(
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor
      _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps =
      PropDescriptor(
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps);
  static const String
      _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps =
      'OverriddenTestBaseProps.v4_lateRequiredProp_optionalInOtherType';
  static const String
      _$key__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps =
      'OverriddenTestBaseProps.v4_optionalProp_requiredInOtherType';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps,
    _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestBaseProps,
    _$key__v4_optionalProp_requiredInOtherType__OverriddenTestBaseProps
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey(
        'OverriddenTestBaseProps.v4_lateRequiredProp_optionalInOtherType')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_lateRequiredProp_optionalInOtherType` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForOverriddenTestBaseProps = PropsMeta(
  fields: $OverriddenTestBaseProps.$props,
  keys: $OverriddenTestBaseProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $OverriddenTestSubtypeProps on OverriddenTestSubtypeProps {
  static const PropsMeta meta = _$metaForOverriddenTestSubtypeProps;
  @override
  @override
  String? get v4_lateRequiredProp_optionalInOtherType => (props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps] ??
      null) as String?;
  @override
  @override
  set v4_lateRequiredProp_optionalInOtherType(String? value) => props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps] =
      value;
  @override
  @override
  String? get v4_optionalProp_requiredInOtherType => (props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps] ??
      null) as String?;
  @override
  @override
  set v4_optionalProp_requiredInOtherType(String? value) => props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps =
      PropDescriptor(
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps);
  static const PropDescriptor
      _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps =
      PropDescriptor(
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps,
          isRequired: true,
          isNullable: true);
  static const String
      _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps =
      'OverriddenTestSubtypeProps.v4_lateRequiredProp_optionalInOtherType';
  static const String
      _$key__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps =
      'OverriddenTestSubtypeProps.v4_optionalProp_requiredInOtherType';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps,
    _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestSubtypeProps,
    _$key__v4_optionalProp_requiredInOtherType__OverriddenTestSubtypeProps
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey(
        'OverriddenTestSubtypeProps.v4_optionalProp_requiredInOtherType')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_optionalProp_requiredInOtherType` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForOverriddenTestSubtypeProps = PropsMeta(
  fields: $OverriddenTestSubtypeProps.$props,
  keys: $OverriddenTestSubtypeProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $OverriddenTestUnrelatedClassPropsMixin
    on OverriddenTestUnrelatedClassPropsMixin {
  static const PropsMeta meta = _$metaForOverriddenTestUnrelatedClassPropsMixin;
  @override
  String? get v4_lateRequiredProp_optionalInOtherType => (props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin] ??
      null) as String?;
  @override
  set v4_lateRequiredProp_optionalInOtherType(String? value) => props[
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin] =
      value;
  @override
  String? get v4_optionalProp_requiredInOtherType => (props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin] ??
      null) as String?;
  @override
  set v4_optionalProp_requiredInOtherType(String? value) => props[
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin =
      PropDescriptor(
          _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin);
  static const PropDescriptor
      _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin =
      PropDescriptor(
          _$key__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin,
          isRequired: true,
          isNullable: true);
  static const String
      _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin =
      'OverriddenTestUnrelatedClassPropsMixin.v4_lateRequiredProp_optionalInOtherType';
  static const String
      _$key__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin =
      'OverriddenTestUnrelatedClassPropsMixin.v4_optionalProp_requiredInOtherType';

  static const List<PropDescriptor> $props = [
    _$prop__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin,
    _$prop__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__v4_lateRequiredProp_optionalInOtherType__OverriddenTestUnrelatedClassPropsMixin,
    _$key__v4_optionalProp_requiredInOtherType__OverriddenTestUnrelatedClassPropsMixin
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey(
        'OverriddenTestUnrelatedClassPropsMixin.v4_optionalProp_requiredInOtherType')) {
      throw MissingRequiredPropsError(
          'Required prop `v4_optionalProp_requiredInOtherType` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForOverriddenTestUnrelatedClassPropsMixin = PropsMeta(
  fields: $OverriddenTestUnrelatedClassPropsMixin.$props,
  keys: $OverriddenTestUnrelatedClassPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $DisableRequiredPropValidationProps
    on DisableRequiredPropValidationProps {
  static const PropsMeta meta = _$metaForDisableRequiredPropValidationProps;
  @override
  String get lateRequired =>
      (props[_$key__lateRequired__DisableRequiredPropValidationProps] ?? null)
          as String;
  @override
  set lateRequired(String value) =>
      props[_$key__lateRequired__DisableRequiredPropValidationProps] = value;
  @override
  @disableRequiredPropValidation
  String get lateRequiredWithValidationDisabled => (props[
          _$key__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps] ??
      null) as String;
  @override
  @disableRequiredPropValidation
  set lateRequiredWithValidationDisabled(String value) => props[
          _$key__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__lateRequired__DisableRequiredPropValidationProps = PropDescriptor(
          _$key__lateRequired__DisableRequiredPropValidationProps,
          isRequired: true,
          isNullable: true);
  static const PropDescriptor
      _$prop__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps =
      PropDescriptor(
          _$key__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps,
          isRequired: true,
          isNullable: true);
  static const String _$key__lateRequired__DisableRequiredPropValidationProps =
      'DisableRequiredPropValidationProps.lateRequired';
  static const String
      _$key__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps =
      'DisableRequiredPropValidationProps.lateRequiredWithValidationDisabled';

  static const List<PropDescriptor> $props = [
    _$prop__lateRequired__DisableRequiredPropValidationProps,
    _$prop__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps
  ];
  static const List<String> $propKeys = [
    _$key__lateRequired__DisableRequiredPropValidationProps,
    _$key__lateRequiredWithValidationDisabled__DisableRequiredPropValidationProps
  ];

  @override
  @mustCallSuper
  void validateRequiredProps() {
    super.validateRequiredProps();
    if (!props.containsKey('DisableRequiredPropValidationProps.lateRequired')) {
      throw MissingRequiredPropsError(
          'Required prop `lateRequired` is missing.');
    }
  }
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForDisableRequiredPropValidationProps = PropsMeta(
  fields: $DisableRequiredPropValidationProps.$props,
  keys: $DisableRequiredPropValidationProps.$propKeys,
);

_$$OverriddenTestUnrelatedClassProps _$OverriddenTestUnrelatedClass(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$OverriddenTestUnrelatedClassProps$JsMap(JsBackedMap())
        : _$$OverriddenTestUnrelatedClassProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$OverriddenTestUnrelatedClassProps extends UiProps
    with
        OverriddenTestBaseProps,
        // If this generated mixin is undefined, it's likely because OverriddenTestBaseProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OverriddenTestBaseProps, and check that $OverriddenTestBaseProps is exported/imported properly.
        $OverriddenTestBaseProps,
        OverriddenTestUnrelatedClassPropsMixin,
        // If this generated mixin is undefined, it's likely because OverriddenTestUnrelatedClassPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OverriddenTestUnrelatedClassPropsMixin, and check that $OverriddenTestUnrelatedClassPropsMixin is exported/imported properly.
        $OverriddenTestUnrelatedClassPropsMixin
    implements
        OverriddenTestUnrelatedClassProps {
  _$$OverriddenTestUnrelatedClassProps._();

  factory _$$OverriddenTestUnrelatedClassProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$OverriddenTestUnrelatedClassProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$OverriddenTestUnrelatedClassProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because OverriddenTestBaseProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OverriddenTestBaseProps, and check that $OverriddenTestBaseProps is exported/imported properly.
        OverriddenTestBaseProps: $OverriddenTestBaseProps.meta,
        // If this generated mixin is undefined, it's likely because OverriddenTestUnrelatedClassPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of OverriddenTestUnrelatedClassPropsMixin, and check that $OverriddenTestUnrelatedClassPropsMixin is exported/imported properly.
        OverriddenTestUnrelatedClassPropsMixin:
            $OverriddenTestUnrelatedClassPropsMixin.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$OverriddenTestUnrelatedClassProps(
          accessMap, (map) => _$$OverriddenTestUnrelatedClassProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$OverriddenTestUnrelatedClassProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$OverriddenTestUnrelatedClassProps$PlainMap
    extends _$$OverriddenTestUnrelatedClassProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OverriddenTestUnrelatedClassProps$PlainMap(Map? backingMap)
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
class _$$OverriddenTestUnrelatedClassProps$JsMap
    extends _$$OverriddenTestUnrelatedClassProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$OverriddenTestUnrelatedClassProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

_$$ExtendsDisableRequiredPropValidationProps
    _$ExtendsDisableRequiredPropValidation([Map? backingProps]) =>
        backingProps == null
            ? _$$ExtendsDisableRequiredPropValidationProps$JsMap(JsBackedMap())
            : _$$ExtendsDisableRequiredPropValidationProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ExtendsDisableRequiredPropValidationProps extends UiProps
    with
        DisableRequiredPropValidationProps,
        // If this generated mixin is undefined, it's likely because DisableRequiredPropValidationProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DisableRequiredPropValidationProps, and check that $DisableRequiredPropValidationProps is exported/imported properly.
        $DisableRequiredPropValidationProps
    implements
        ExtendsDisableRequiredPropValidationProps {
  _$$ExtendsDisableRequiredPropValidationProps._();

  factory _$$ExtendsDisableRequiredPropValidationProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ExtendsDisableRequiredPropValidationProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$ExtendsDisableRequiredPropValidationProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because DisableRequiredPropValidationProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of DisableRequiredPropValidationProps, and check that $DisableRequiredPropValidationProps is exported/imported properly.
        DisableRequiredPropValidationProps:
            $DisableRequiredPropValidationProps.meta,
      });

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$ExtendsDisableRequiredPropValidationProps(accessMap,
          (map) => _$$ExtendsDisableRequiredPropValidationProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$ExtendsDisableRequiredPropValidationProps = getPropKey;

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ExtendsDisableRequiredPropValidationProps$PlainMap
    extends _$$ExtendsDisableRequiredPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsDisableRequiredPropValidationProps$PlainMap(Map? backingMap)
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
class _$$ExtendsDisableRequiredPropValidationProps$JsMap
    extends _$$ExtendsDisableRequiredPropValidationProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ExtendsDisableRequiredPropValidationProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

    ''';
