// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

part 'prop_forwarding.over_react.g.dart';

UiFactory<DomWrapperProps> DomWrapper =
    castUiFactory(_$DomWrapper); // ignore: undefined_identifier

mixin DomWrapperProps on UiProps {}

class DomWrapperComponent extends UiComponent2<DomWrapperProps> {
  @override
  render() {
    return (Dom.div()
      // This should lint since only dom props can be forwarded to Dom components
      ..modifyProps(addUnconsumedProps)
      ..id = 'foo'
    )();
  }
}

final DomWrapperFn = uiFunction<UiProps>(
  (props) {
    return (Dom.div()
      // This should lint since only dom props can be forwarded to Dom components
      ..addUnconsumedProps(props, const [])
      ..id = 'foo'
    )();
  },
  UiFactoryConfig(displayName: 'DomWrapperFn'),
);
