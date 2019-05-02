import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FlawedProps> Flawed = _$Flawed;

@Props()
class _$FlawedProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedProps extends _$FlawedProps with _$FlawedPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFlawedProps;
}

@State()
class _$FlawedState extends UiState {
  bool hasError;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedState extends _$FlawedState with _$FlawedStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForFlawedState;
}

@Component()
class FlawedComponent extends UiStatefulComponent<FlawedProps, FlawedState> {
  @override
  Map getInitialState() => (newState()..hasError = false);

  @override
  void componentWillUpdate(_, Map nextState) {
    final tNextState = typedStateFactory(nextState);
    if (tNextState.hasError && !state.hasError) {
      throw new Error();
    }
  }

  @override
  render() {
    return (Dom.button()
      ..addTestId('flawedButton')
      ..onClick = (_) {
        setState(newState()..hasError = true);
      }
    )('oh hai');
  }
}
