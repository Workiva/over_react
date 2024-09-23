// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

part 'invalid_generated_pat_filename_standalone.over_react.g.dart';

UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {}
}
