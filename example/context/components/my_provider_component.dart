import 'package:over_react/over_react.dart';

import '../context.dart';

part 'my_provider_component.over_react.g.dart';

UiFactory<MyProviderProps> MyProvider = _$MyProvider; // ignore: undefined_identifier

mixin MyProviderProps on UiProps {}

mixin MyProviderState on UiState {
  String latestValue;
}

class MyProviderComponent extends UiStatefulComponent2<MyProviderProps, MyProviderState> {
  @override
  render() {
    return Dom.div()(
      (Dom.button()..onClick = (_) { setState((newState()..latestValue = 'Hi Sydney')); })('Sydney'),
      (Dom.button()..onClick = (_) { setState((newState()..latestValue = 'Hi Keal')); })('Keal'),
      (someContext.Provider()..value = state.latestValue)(
        props.children
      )
    );
  }
}
