import 'package:over_react/over_react.dart';

import 'bar.dart';
import 'baz.dart';
import 'foo.dart';
import 'component_wrapper.dart';

part 'foobar.over_react.g.dart';

const excludeMixins = {FooBarPropsMixin};

final FooBarDemo = createVisualComponent(FooBar, excludedMixins: excludeMixins);

mixin FooBarPropsMixin on UiProps {
  dynamic foobar;
}

class FooBarProps = UiProps
  with FooBarPropsMixin,
       FooPropsMixin,
       BarPropsMixin,
       BazPropsMixin;


final FooBar = uiFunction<FooBarProps>((props) {
  return (Dom.div()..style = {'display': 'flex'})(
      (FooDemo()
        ..addAll(props.getPropsToForward(exclude: excludeMixins))
      )(),
      (BarDemo()
        ..modifyProps(props.addPropsToForward(exclude: excludeMixins))
      )(),
    );
}, _$FooBarConfig);
