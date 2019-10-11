import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

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
    return (Dom.div()      // [ ] Check this box upon manual validation that this style map is receiving a value that is valid for the keys that are simple string variables.
            // CSS number strings are no longer auto-converted to px. Ensure values are of type `num`, or have units.
      // Incorrect value for 'width': '40'. Correct values: 40, '40px', '4em'.
    
      // This will be removed once the transition to React 16 is complete.
      ..style = props.wrapperStyles)(
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
