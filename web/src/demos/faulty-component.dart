import 'package:over_react/over_react.dart';

import '../../component1/src/demo_components.dart';

part 'faulty-component.over_react.g.dart';


@Factory()
// ignore: undefined_identifier
UiFactory<FaultyProps> Faulty = _$Faulty;

@Props()
class _$FaultyProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FaultyProps extends _$FaultyProps with _$FaultyPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFaultyProps;
}

@State()
class _$FaultyState extends UiState {
  bool hasErrored;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FaultyState extends _$FaultyState with _$FaultyStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForFaultyState;
}

@Component2()
class FaultyComponent extends UiStatefulComponent2<FaultyProps, FaultyState> {
  @override
  get initialState => (newState()..hasErrored = false);

  @override
  dynamic getSnapshotBeforeUpdate(Map prevProps, Map prevState) {
    final tPrevState = typedStateFactory(prevState);
    if (!tPrevState.hasErrored && state.hasErrored) {
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
