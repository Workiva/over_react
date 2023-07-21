import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';

import 'foo.dart';
part 'foobar.over_react.g.dart';

mixin FooBarPropsMixin on UiProps {
  dynamic foobar;
}

class FooBarProps = UiProps
  with FooBarPropsMixin,
       BarPropsMixin,
       FooPropsMixin,
       SomethingElsePropsMixin;

final FooBar = uiFunction<FooBarProps>((props) {
  return (Foo()
    ..addAll(props.getPropsToForward(exclude: {FooBarPropsMixin}))
  )();
}, _$FooBarConfig);
