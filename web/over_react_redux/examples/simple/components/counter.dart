import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/over_react_redux/over_react_flux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

/// Connected Redux Component
///
/// As shown in the example below, the same component can be connected to Redux in
/// such a way that it behaves differently.
UiFactory<CounterProps> ConnectedCounter = connectFlux<CounterStore, CounterProps>(
  mapStateToProps: (state) => (Counter()
    ..currentCount = state.smallCount
    ..increment = state.actions.smallIncrement
    ..decrement = state.actions.smallDecrement
  ),
)(Counter);

UiFactory<CounterProps> ConnectedBigCounter = connectFlux<CounterStore, CounterProps>(
  mapStateToProps: (state) => (Counter()
    ..currentCount = state.bigCount
    ..increment = state.actions.bigIncrement
    ..decrement = state.actions.bigDecrement
  ),
)(Counter);

@Factory()
UiFactory<CounterProps> Counter = _$Counter;

@Props()
class _$CounterProps extends UiProps {
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
          props.increment();
        })('+'),
        (Dom.button()..onClick = (_) {
          props.decrement();
        })('-'),
        props.children
    );
  }
}
