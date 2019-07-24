import 'dart:developer';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

@Factory()
UiFactory<CounterProps> Counter = _$Counter;

@Props()
class _$CounterProps extends UiProps with ConnectPropsMixin {
  int intProp;

  Map<String, dynamic> customStyles;

  void Function(dynamic action) dispatcherProp;
}

@Component2()
class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.customStyles)(
        Dom.div()('Count: ${props.intProp}'),
        (Dom.button()..onClick = (_){ props.dispatch != null ? props.dispatch(new IncrementAction()) : '';})('+1'),
        (Dom.button()..onClick = (_){ props.dispatch != null ? props.dispatch(new DecrementAction()) : '';})('-1'),
        props.children
    );
  }
}
