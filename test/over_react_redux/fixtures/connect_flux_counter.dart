import 'package:over_react/over_react.dart';

part 'connect_flux_counter.over_react.g.dart';

@Factory()
UiFactory<ConnectFluxCounterProps> ConnectFluxCounter = _$ConnectFluxCounter;

@Props()
class _$ConnectFluxCounterProps extends UiProps {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  void Function() increment;

  void Function() decrement;
}

@Component2()
class ConnectFluxCounterComponent extends UiComponent2<ConnectFluxCounterProps> {
  @override
  render() {
    return (Dom.div()
      ..modifyProps(addUnconsumedProps)
      ..style = props.wrapperStyles
    )(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()
          ..addTestId('button-increment')
          ..onClick = (_) {
            props.increment();
          }
        )('+'),
        (Dom.button()
          ..addTestId('button-decrement')
          ..onClick = (_) {
            props.decrement();
          }
        )('-'),
        props.children
    );
  }
}
