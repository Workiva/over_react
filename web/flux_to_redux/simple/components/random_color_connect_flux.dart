import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';

import '../stores.dart';

part 'random_color_connect_flux.over_react.g.dart';

UiFactory<RandomColorConnectFluxProps> ConnectedRandomColorConnectFlux =
    connectFlux<ExampleFluxStore, RandomColorActions, RandomColorConnectFluxProps>(
  mapStateToProps: (state) => (RandomColorConnectFlux()..backgroundColor = state?.backgroundColor),
  mapActionsToProps: (actions) =>
      (RandomColorConnectFlux()..changeBackgroundColor = () => actions.changeBackgroundColor()),
)(RandomColorConnectFlux);

@Factory()
UiFactory<RandomColorConnectFluxProps> RandomColorConnectFlux = _$RandomColorConnectFlux;

@Props()
class _$RandomColorConnectFluxProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  Function changeBackgroundColor;
}

@Component2()
class RandomColorConnectFluxComponent extends UiComponent2<RandomColorConnectFluxProps> {
  @override
  render() {
    return ((Dom.div()
      ..style = {'padding': '50px', 'backgroundColor': props?.backgroundColor, 'color': 'white'}
    )(
      'This module uses a connect flux pattern to change its background color.',
      (Dom.button()
        ..onClick = (_) {
          props.changeBackgroundColor();
        }
        ..style = {'padding': '10px', 'margin': '10px'}
      )('Change Background Color'),
    ));
  }
}
