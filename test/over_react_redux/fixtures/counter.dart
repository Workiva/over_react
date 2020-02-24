import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'redux_actions.dart';

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
    return (Dom.div()
      ..modifyProps(addUnconsumedProps)
      ..style = props.wrapperStyles
      ..addTestId('counter-component')
    )(
      Dom.div()('Count: ${props.currentCount}'),
      (Dom.button()
        ..addTestId('button-increment')
        ..onClick = (_) {
          if (props.increment != null) {
            props.increment();
          } else if (props.dispatch != null) {
            props.dispatch(IncrementAction());
          }
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          if (props.decrement != null) {
            props.decrement();
          } else if (props.dispatch != null) {
            props.dispatch(DecrementAction());
          }
        }
      )('-'),
      props.children
    );
  }
}
