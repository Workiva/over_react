// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

part 'non_defaulted_prop.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    // Default props
    final content = props.content ?? 'abc';

    return Dom.div()(props.content);
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {
  String content;
}
