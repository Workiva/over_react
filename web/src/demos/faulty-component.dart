import 'package:over_react/over_react.dart';

import '../../component1/src/demo_components.dart';

part 'faulty-component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FaultyProps> Faulty = _$Faulty;

mixin FaultyProps on UiProps {}

mixin FaultyState on UiState {
  bool hasErrored;
}

class FaultyComponent extends UiStatefulComponent2<FaultyProps, FaultyState> {
  @override
  get initialState => (newState()..hasErrored = false);

  @override
  getSnapshotBeforeUpdate(Map prevProps, Map prevState) {
    final tPrevState = typedStateFactory(prevState);
    if (state.hasErrored && !tPrevState.hasErrored) {
      throw Error();
    }
  }

  @override
  render() {
    return (Dom.div()..className = 'btn-toolbar')(
      (Button()..onClick = (_) {
        setState(newState()..hasErrored = true);
      })('Click me to throw an error'),
    );
  }
}
