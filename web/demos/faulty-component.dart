part of over_react.web.demos;

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

@Component()
class FaultyComponent extends UiStatefulComponent<FaultyProps, FaultyState> {
  @override
  Map getInitialState() => (newState()..hasErrored = false);

  @override
  void componentWillUpdate(_, Map nextState) {
    final tNextState = typedStateFactory(nextState);
    if (tNextState.hasErrored && !state.hasErrored) {
      throw new Error();
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
