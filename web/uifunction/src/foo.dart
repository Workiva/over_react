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
  return (Bar()
    ..addAll(props.getPropsToForward(exclude: {FooPropsMixin}))
  )();
}, _$FooConfig);

mixin BarPropsMixin on UiProps {
  String bar;

  @Accessor(key:'data-lol', keyNamespace: '')
  String lol;
}

final Bar = uiFunction<BarPropsMixin>((props) {
  log('Bar', props.getPropsToForward());
  return Fragment()(
    (Dom.div()..modifyProps(props.addPropsToForward(exclude: {BarPropsMixin}, domOnly: true)))(),
    (SomethingElse()
    ..modifyProps(props.addPropsToForward())
  )());
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
