import 'package:over_react/over_react.dart';

import '../context.dart';

part 'my_context_component.over_react.g.dart';

UiFactory<MyContextComponentProps> MyContext =
    _$MyContext; // ignore: undefined_identifier

mixin MyContextComponentProps on UiProps {}

class MyContextComponentComponent extends UiComponent2<MyContextComponentProps> {
  @override
  get contextType => someContext.reactDartContext;

  @override
  render() {
    return Dom.div()('${this.context}');
  }
}
