import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (Counter()..currentCount = state.count)
)(Counter);

UiFactory<CounterProps> ConnectedCounterWithDifferentContext = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (Counter()..currentCount = state.count),
  context: bigCounterContext,
)(Counter);

@Factory()
UiFactory<CounterProps> Counter = _$Counter;

@Props()
class _$CounterProps extends UiProps with ConnectPropsMixin {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  void Function() increment;

  void Function() decrement;
}

@Component2()
class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.wrapperStyles)(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()..onClick = (_) {
          if (props.increment != null) {
            props.increment();
          } else if (props.dispatch != null) {
            props.dispatch(new IncrementAction());
          }
        })('+'),
        (Dom.button()..onClick = (_) {
          if (props.decrement != null) {
            props.decrement();
          } else if (props.dispatch != null) {
            props.dispatch(new DecrementAction());
          }
        })('-'),
        props.children
    );
  }
}
