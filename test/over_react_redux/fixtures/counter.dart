import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'store.dart';

part 'counter.over_react.g.dart';

@Factory()
UiFactory<CounterProps> Counter = _$Counter;

@Props()
class _$CounterProps extends UiProps with ConnectPropsMixin {
  int currentCount;

  Map<String, dynamic> customStyles;

  void Function() dispatchDecrement;
}

@Component2()
class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.customStyles)(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()..addTestId('button-increment')..onClick = (_){ props.dispatch != null ? props.dispatch(new IncrementAction()) : '';})('+1'),
        (Dom.button()..addTestId('button-decrement')..onClick = (_){ props.dispatchDecrement(); })('-1'),
        props.children
    );
  }
}

