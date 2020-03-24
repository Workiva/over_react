import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (_Counter()..currentCount = state.count)
)(_Counter);

UiFactory<CounterProps> CounterWithDifferentContext = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (_Counter()..currentCount = state.count),
  context: bigCounterContext,
)(_Counter);

UiFactory<CounterProps> _Counter = _$_Counter;

mixin CounterPropsMixin on UiProps {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  void Function() increment;

  void Function() decrement;
}

class CounterProps = UiProps with CounterPropsMixin, ConnectPropsMixin;

class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.wrapperStyles)(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()..onClick = (_) {
          if (props.increment != null) {
            props.increment();
          } else if (props.dispatch != null) {
            props.dispatch(IncrementAction());
          }
        })('+'),
        (Dom.button()..onClick = (_) {
          if (props.decrement != null) {
            props.decrement();
          } else if (props.dispatch != null) {
            props.dispatch(DecrementAction());
          }
        })('-'),
        props.children
    );
  }
}
