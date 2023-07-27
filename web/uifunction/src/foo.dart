import 'package:over_react/over_react.dart';

import 'button.dart';
import 'component_wrapper.dart';
import 'utils.dart';

part 'foo.over_react.g.dart';

// This is what it would default too when you dont include an `exclude` argument.
const excludeMixins = {FooPropsMixin};

final FooDemo = createVisualComponent(Foo, excludedMixins: excludeMixins);

mixin FooPropsMixin on UiProps {
  dynamic foo;
}

final Foo = uiFunction<FooPropsMixin>((props) {
  final randomState = useState(true);
  return Dom.div()(
    (Button()..onClick = (e) => randomState.set(!randomState.value))('UPDATE STATE'),
    (DomDivDemo()
    ..addAll(props.getPropsToForward(domOnly: true))
  )());
}, _$FooConfig);





