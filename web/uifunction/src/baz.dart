import 'package:over_react/over_react.dart';

import 'component_wrapper.dart';
import 'utils.dart';

part 'baz.over_react.g.dart';

mixin BazPropsMixin on UiProps {
  dynamic baz;
}

final BazDemo = createVisualComponent(Baz, domOnly: true);

final Baz = uiFunction<BazPropsMixin>((props) {
  return (DomDivDemo()
    ..addAll(props.getPropsToForward(domOnly: true))
  )(props.baz != null ? 'We received props.Baz! ${props.baz}' : 'props.Baz was not forwarded.');
}, _$BazConfig);
