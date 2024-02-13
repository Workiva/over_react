import 'package:over_react/over_react.dart';

part 'missing_required_props.over_react.g.dart';

UiFactory<UiProps> GenericFactory = uiFunction((_) {}, UiFactoryConfig());

UiFactory<NoRequiredProps> NoRequired = uiFunction((_) {}, _$NoRequiredConfig);
mixin NoRequiredProps on UiProps {
  String? optional1;
  String? optional2;
}


UiFactory<WithLateRequiredProps> WithLateRequired = uiFunction((_) {}, _$WithLateRequiredConfig);
mixin WithLateRequiredProps on UiProps {
  late String required1;
  late String? required2;
  String? optional1;
  String? optional2;
}


UiFactory<InheritsLateRequiredProps> InheritsLateRequired = uiFunction((_) {}, _$InheritsLateRequiredConfig);
mixin InheritsLateRequiredPropsMixin on UiProps {
  late String requiredInSubclass;
}
class InheritsLateRequiredProps = UiProps with WithLateRequiredProps, InheritsLateRequiredPropsMixin;


UiFactory<RequiredWithSameNameAsPrefixedProps> RequiredWithSameNameAsPrefixed = uiFunction((_) {}, _$RequiredWithSameNameAsPrefixedConfig);
mixin RequiredWithSameNameAsPrefixedProps on UiProps {
  late bool hidden;
}


UiFactory<DisableValidationProps> DisableValidation = uiFunction((_) {}, _$DisableValidationConfig);
mixin DisableValidationProps on UiProps {
  @disableRequiredPropValidation
  late String requiredPropWithDisabledValidation;
}


UiFactory<IgnoresSomeRequiredProps> IgnoresSomeRequired = uiFunction((_) {}, _$IgnoresSomeRequiredConfig);
mixin IgnoresSomeRequiredPropsMixin on UiProps {
  late String requiredInSubclass1;
  late String requiredInSubclass2;
}
@Props(disableRequiredPropValidation: {'required1', 'requiredInSubclass1'})
class IgnoresSomeRequiredProps = UiProps with WithLateRequiredProps, IgnoresSomeRequiredPropsMixin;


UiFactory<WithAnnotationRequiredProps> WithAnnotationRequired = uiFunction((_) {}, _$WithAnnotationRequiredConfig);
mixin WithAnnotationRequiredProps on UiProps {
  @requiredProp String? required1;
  @requiredProp String? required2;
  String? optional1;
  String? optional2;
}

UiFactory<WithDefaultsProps> WithDefaults = castUiFactory(_$WithDefaults);

mixin WithDefaultsProps on UiProps {
  late String required;
  late String defaulted;
}

class WithDefaultsComponent extends UiComponent2<WithDefaultsProps> {
  @override
  get defaultProps => (newProps()
    ..defaulted = ''
  );

  @override
  render() {}
}


main() {
  NoRequired()();

  Dom.div()();

  // Also should not lint
  final incompleteBuilder = WithLateRequired();
  incompleteBuilder();

  (WithLateRequired()..disableRequiredPropValidation())();

  WithLateRequired()();

  InheritsLateRequired()();

  WithAnnotationRequired()();

  // Props defaulted in props class
  WithDefaults()();
  (WithDefaults()..required = '')();

  DisableValidation()();

  IgnoresSomeRequired()();

  // Make sure prefixed props aren't mistaken for the missing required prop.
  (RequiredWithSameNameAsPrefixed()..dom.hidden = true)();
}
