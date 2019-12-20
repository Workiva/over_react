import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'connect_flux_random_color.over_react.g.dart';

UiFactory<ConnectFluxRandomColorProps> ConnectedConnectFluxRandomColor =
    connectFlux<FluxStore, RandomColorActions, ConnectFluxRandomColorProps>(
  mapStateToProps: (state) => (ConnectFluxRandomColor()..backgroundColor = state?.backgroundColor),
  mapActionsToProps: (actions) =>
      (ConnectFluxRandomColor()..changeBackgroundColor = () => actions.changeBackgroundColor()),
)(ConnectFluxRandomColor);

@Factory()
UiFactory<ConnectFluxRandomColorProps> ConnectFluxRandomColor = _$ConnectFluxRandomColor;

@Props()
class _$ConnectFluxRandomColorProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  Function changeBackgroundColor;
}

@Component2()
class ConnectFluxRandomColorComponent extends UiComponent2<ConnectFluxRandomColorProps> {
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
