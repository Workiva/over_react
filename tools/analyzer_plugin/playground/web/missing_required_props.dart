import 'package:over_react/over_react.dart';

part 'missing_required_props.over_react.g.dart';

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


UiFactory<RequiredWithSameNameAsPrefixedProps> RequiredWithSameNameAsPrefixed = uiFunction((_) {},
    _$RequiredWithSameNameAsPrefixedConfig);
mixin RequiredWithSameNameAsPrefixedProps on UiProps {
  late bool hidden;
}


class InheritsLateRequiredProps = UiProps with WithLateRequiredProps, InheritsLateRequiredPropsMixin;

UiFactory<WithAnnotationRequiredProps> WithAnnotationRequired = uiFunction((_) {}, _$WithAnnotationRequiredConfig);
mixin WithAnnotationRequiredProps on UiProps {
  @requiredProp
  String? required1;
  @requiredProp
  String? required2;
  String? optional1;
  String? optional2;
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

  // Make sure prefixed props aren't mistaken for the missing required prop.
  (RequiredWithSameNameAsPrefixed()..dom.hidden = true)();
}
