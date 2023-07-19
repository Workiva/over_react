import 'dart:html';
import 'dart:js_util';

import 'package:over_react/over_react.dart';
part 'foo.over_react.g.dart';

mixin FooBarPropsMixin on UiProps {
  String foobar;
}

class FooBarProps = UiProps
  with BarPropsMixin,
       FooPropsMixin,
       SomethingElsePropsMixin;

final FooBar = uiFunction<FooBarProps>((props) {
  return Fragment()(
    (Foo()
      ..addAll(props.getPropsToForward(exclude: {FooPropsMixin}))
    )(),
    (Bar()
      ..addAll(props.getPropsToForward(exclude: {BarPropsMixin}))
    )(),
    (SomethingElse()
      ..addAll(props.getPropsToForward(exclude: {SomethingElsePropsMixin}))
    )(),
  );
}, _$FooBarConfig);

mixin FooPropsMixin on UiProps {
  dynamic foo;
}

final Foo = uiFunction<FooPropsMixin>((props) {
  if (props.length > 1 ) {
    window.console.log(props.props);
  }
  return props.foo != null ? 'FOO!!!' : 'NO FOO :(';
}, _$FooConfig);

mixin BarPropsMixin on UiProps {
  String bar;
}

final Bar = uiFunction<BarPropsMixin>((props) {
  //var consumedProps = props.staticMeta.forMixins({FooPropsMixin});
  //log('Bar', props.getPropsToForward(exclude: {FooPropsMixin}));
  return props.bar != null ? 'BAR!!!' : 'NO BAR :(';
}, _$BarConfig);


mixin SomethingElsePropsMixin on UiProps {
  dynamic somethingElse;
}


final SomethingElse = uiFunction<SomethingElsePropsMixin>((props) {
  log('SomethingElse', props.getPropsToForward());
  return (Dom.div()
    ..addAll(props.getPropsToForward())
  )(props.somethingElse != null ? 'We received props.somethingElse! ${props.somethingElse}' : 'props.somethingElse was not forwarded.');
}, _$SomethingElseConfig);


log(dynamic name, dynamic x) => callMethod(getProperty(window,'console'), 'log', [name, jsify(x)]);
