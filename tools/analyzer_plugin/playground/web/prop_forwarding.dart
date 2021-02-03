import 'package:over_react/over_react.dart';

part 'prop_forwarding.over_react.g.dart';

UiFactory<DomWrapperProps> DomWrapper = castUiFactory(_$DomWrapper); // ignore: undefined_identifier

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
