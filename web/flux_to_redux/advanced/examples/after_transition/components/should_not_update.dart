import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../../../stores.dart';

part 'should_not_update.over_react.g.dart';

UiFactory<ShouldNotUpdateProps> ConnectedShouldNotUpdate = connect<AfterTransitionState, ShouldNotUpdateProps>(
  mapStateToProps: (_) => {},
)(ShouldNotUpdate);

@Factory()
UiFactory<ShouldNotUpdateProps> ShouldNotUpdate = _$ShouldNotUpdate;

@Props()
class _$ShouldNotUpdateProps extends UiProps {}

@Component2()
class ShouldNotUpdateComponent extends UiComponent2<ShouldNotUpdateProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': 'gray', 'color': 'white'})(
      'This component should not redraw when the others do.',
    ));
  }
}
