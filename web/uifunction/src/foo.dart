import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';
part 'foo.over_react.g.dart';

mixin FooPropsMixin on UiProps {
  dynamic foo;
}

class FooProps = UiProps
  with BarPropsMixin,
       FooPropsMixin,
       SomethingElsePropsMixin;

final Foo = uiFunction<FooProps>((props) {
  log('Foo', props.getUnused({FooPropsMixin}));
  return (Bar()
    ..addAll(props.getUnused({FooPropsMixin}))
  )();
}, _$FooConfig);

mixin BarPropsMixin on UiProps {
  dynamic bar;
}

final Bar = uiFunction<BarPropsMixin>((props) {
  log('Bar', props.unused);
  return (SomethingElse()
    ..addAll(props.unused)
  )();
}, _$BarConfig);


mixin SomethingElsePropsMixin on UiProps {
  dynamic somethingElse;
}

final SomethingElse = uiFunction<SomethingElsePropsMixin>((props) {
  log('SomethingElse', props.getUnused());
  return (Dom.div()
    ..addAll(props.getUnused())
  )(props.somethingElse);
}, _$SomethingElseConfig);


log(dynamic name, dynamic x) => callMethod(getProperty(window,'console'), 'log', [name, jsify(x)]);
