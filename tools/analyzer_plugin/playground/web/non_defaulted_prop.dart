import 'package:over_react/over_react.dart';

part 'non_defaulted_prop.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    final prop1 = props.prop1 ?? 'abc';

    return (Dom.div()..id = props.prop1)(prop1);
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {
  String prop1;
}
