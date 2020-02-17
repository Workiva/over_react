import 'package:over_react/over_react.dart';

import 'connect_flux_store.dart';

part 'flux_counter.over_react.g.dart';

@Factory()
UiFactory<FluxCounterProps> FluxCounter = _$FluxCounter;

@Props()
class _$FluxCounterProps
    extends FluxUiProps<FluxActions, TestConnectableFluxStore> {}

@Component2()
class FluxCounterComponent extends FluxUiComponent2<FluxCounterProps> {
  @override
  render() {
    return (Dom.div()..modifyProps(addUnconsumedProps))(
      Dom.div()('Count: ${props.store.count}'),
      (Dom.button()
        ..addTestId('button-increment')
        ..onClick = (_) {
          props.actions.incrementAction();
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          props.actions.decrementAction();
        }
      )('-'),
      props.children,
    );
  }
}
