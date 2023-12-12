// @dart=2.11
import 'package:over_react/over_react.dart';

part 'create_ref_usage.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    final ref = createRef();

    return (Dom.div()..ref = ref)();
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {}
