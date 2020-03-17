import 'package:over_react/over_react.dart';

import '../fixtures/test_context.dart';

part 'context_type_component.over_react.g.dart';

UiFactory<ContextTypeProps> ContextType = _$ContextType;

mixin ContextTypeProps on UiProps {}

class ContextTypeComponent extends UiComponent2<ContextTypeProps> {
  @override
  final contextType = someContext.reactDartContext;

  @override
  render() {
    return Dom.span()('${this.context}');
  }
}
