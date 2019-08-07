import 'package:over_react/over_react.dart';
import '../store.dart';

part 'my_provider_component.over_react.g.dart';

@Factory()
UiFactory<MyProviderComponentProps> MyProviderComponent = _$MyProviderComponent;

@Props()
class _$MyProviderComponentProps extends UiProps {

}

@State()
class _$MyProviderComponentState extends UiState {
  String latestValue;
}

@Component2()
class MyProviderComponentComponent extends UiStatefulComponent2<MyProviderComponentProps, MyProviderComponentState> {

  

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
