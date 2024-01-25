const sourceTemplate = /*language=dart*/ r'''
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


mixin OverriddenTestBaseProps on UiProps {
   late String? v4_lateRequiredProp_optionalInOtherType;
   late String? v4_lateRequiredProp_annotationRequiredInOtherType;
   
   @requiredProp String? v4_annotationRequiredProp_optionalInOtherType;
   @requiredProp String? v4_annotationRequiredProp_lateRequiredInOtherType;
   
   String? v4_optionalProp_annotationRequiredInOtherType;
   String? v4_optionalProp_lateRequiredInOtherType;   
}

mixin OverriddenTestSubtypeProps on UiProps, OverriddenTestBaseProps {
   @override String? v4_lateRequiredProp_optionalInOtherType;
   @override @requiredProp String? v4_lateRequiredProp_annotationRequiredInOtherType;
   
   @override String? v4_annotationRequiredProp_optionalInOtherType;
   @override late String? v4_annotationRequiredProp_lateRequiredInOtherType;
   
   @override @requiredProp String? v4_optionalProp_annotationRequiredInOtherType;
   @override late String? v4_optionalProp_lateRequiredInOtherType;
}

mixin OverriddenTestUnrelatedClassPropsMixin on UiProps {
   String? v4_lateRequiredProp_optionalInOtherType;
   @requiredProp String? v4_lateRequiredProp_annotationRequiredInOtherType;
   
   String? v4_annotationRequiredProp_optionalInOtherType;
   late String? v4_annotationRequiredProp_lateRequiredInOtherType;
   
   @requiredProp String? v4_optionalProp_annotationRequiredInOtherType;
   late String? v4_optionalProp_lateRequiredInOtherType;
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


mixin Ignore1PropsMixin on UiProps {
  late String lateRequired_1_ignored;
  late String lateRequired_1_notIgnored;
  
  String? optional_1_lateRequiredInOtherType_ignored;
  String? optional_1_lateRequiredInOtherType_notIgnored;
  
  late String? lateRequired_1_optionalInOtherType_ignored;
  late String? lateRequired_1_optionalInOtherType_notIgnored;
}

mixin Ignore2PropsMixin on UiProps, Ignore1PropsMixin {
  late String lateRequired_2_ignored;
  late String lateRequired_2_notIgnored;
  
  @override late String? optional_1_lateRequiredInOtherType_ignored;
  @override late String? optional_1_lateRequiredInOtherType_notIgnored;
  
  @override String? lateRequired_1_optionalInOtherType_ignored;
  @override String? lateRequired_1_optionalInOtherType_notIgnored;
}

@Props(disableRequiredPropValidation: {
  'lateRequired_1_ignored',
  'optional_1_lateRequiredInOtherType_ignored',
  'lateRequired_1_optionalInOtherType_ignored',
  'lateRequired_2_ignored',
})
class IgnoreInConcreteClassProps = UiProps with Ignore1PropsMixin, Ignore2PropsMixin;
UiFactory<IgnoreInConcreteClassProps> IgnoreInConcreteClass = castUiFactory(_$IgnoreInConcreteClass);

@Props(disableRequiredPropValidation: {'foo', 'bar'})
class IgnoreRequiredPropsAnnotationTest_WithIgnoresProps extends UiProps {}
UiFactory<IgnoreRequiredPropsAnnotationTest_WithIgnoresProps> IgnoreRequiredPropsAnnotationTest_WithIgnores = castUiFactory(_$IgnoreRequiredPropsAnnotationTest_WithIgnores);

@Props(keyNamespace: 'foo')
class IgnoreRequiredPropsAnnotationTest_WithoutIgnoresProps extends UiProps {}
UiFactory<IgnoreRequiredPropsAnnotationTest_WithoutIgnoresProps> IgnoreRequiredPropsAnnotationTest_WithoutIgnores = castUiFactory(_$IgnoreRequiredPropsAnnotationTest_WithoutIgnores);

class IgnoreRequiredPropsAnnotationTest_WithoutAnnotationProps extends UiProps {}
UiFactory<IgnoreRequiredPropsAnnotationTest_WithoutAnnotationProps> IgnoreRequiredPropsAnnotationTest_WithoutAnnotation = castUiFactory(_$IgnoreRequiredPropsAnnotationTest_WithoutAnnotation);

''';
