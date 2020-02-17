import 'package:over_react/over_react.dart';

import 'connect_flux_store.dart';

part 'connect_flux_counter.over_react.g.dart';

@Factory()
UiFactory<ConnectFluxCounterProps> ConnectFluxCounter = _$ConnectFluxCounter;

@Props()
class _$ConnectFluxCounterProps extends UiProps {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  List<String> mutatedList;

  void Function() increment;

  void Function() decrement;

  void Function() mutateStoreDirectly;
}

@Component2()
class ConnectFluxCounterComponent
    extends UiComponent2<ConnectFluxCounterProps> {
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
          if (props.mutateStoreDirectly != null) {
            props.mutateStoreDirectly();
          } else if (props.increment != null) {
            props.increment();
          } else {
            fluxActions.incrementAction();
          }
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          props.decrement();
        }
      )('-'),
      props.children,
    );
  }
}
