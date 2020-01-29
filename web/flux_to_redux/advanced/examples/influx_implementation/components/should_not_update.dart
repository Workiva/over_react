import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'should_not_update.over_react.g.dart';

UiFactory<ShouldNotUpdateProps> ConnectedShouldNotUpdate = composeHocs([
  connect<RandomColorStore, ShouldNotUpdateProps>(
    context: randomColorStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<LowLevelStore, ShouldNotUpdateProps>(
    context: lowLevelStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<AnotherColorStore, ShouldNotUpdateProps>(
    context: anotherColorStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  )
])(ShouldNotUpdate);

@Factory()
UiFactory<ShouldNotUpdateProps> ShouldNotUpdate = _$ShouldNotUpdate;

@Props()
class _$ShouldNotUpdateProps extends UiProps {}

@Component2()
class ShouldNotUpdateComponent extends UiComponent2<ShouldNotUpdateProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': 'gray', 'color': 'white'})(
      'In a full Redux implementation, this component would not redraw on '
      'unrelated store updates (such as when the background color changes).'
      'However, with an Influx implementation it will.',
    ));
  }
}
