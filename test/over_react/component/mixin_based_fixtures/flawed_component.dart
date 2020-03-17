import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FlawedProps> Flawed = _$Flawed;

mixin FlawedProps on UiProps {
  String buttonTestIdPrefix;
}

mixin FlawedState on UiState {
  int errorCount;
  int differentTypeOfErrorCount;
}

class FlawedComponent extends UiStatefulComponent2<FlawedProps, FlawedState> {
  @override
  get defaultProps => (newProps()..buttonTestIdPrefix = 'flawedComponent_');

  @override
  get initialState => (newState()
    ..errorCount = 0
    ..differentTypeOfErrorCount = 0
  );

  @override
  getSnapshotBeforeUpdate(Map prevProps, Map prevState) {
    final tPrevState = typedStateFactory(prevState);
    if (state.errorCount > tPrevState.errorCount) {
      throw FlawedComponentException();
    }

    if (state.differentTypeOfErrorCount > tPrevState.differentTypeOfErrorCount) {
      throw FlawedComponentException2();
    }
  }

  @override
  render() {
    return Dom.div()(
      (Dom.button()
        ..addTestId('${props.buttonTestIdPrefix}flawedButton')
        ..onClick = (_) {
          setState(newState()..errorCount = state.errorCount + 1);
        }
      )(
        'oh hai',
      ),
      (Dom.button()
        ..addTestId('${props.buttonTestIdPrefix}flawedButtonThatThrowsADifferentError')
        ..onClick = (_) {
          setState(newState()..differentTypeOfErrorCount = state.differentTypeOfErrorCount + 1);
        }
      )(
        'oh hai',
      ),
      props.children,
    );
  }
}

class FlawedComponentException implements Exception {
  @override
  String toString() =>
      'FlawedComponentException: I was thrown from inside FlawedComponent.componentWillUpdate!';
}

class FlawedComponentException2 implements Exception {
  @override
  String toString() =>
      'FlawedComponentException2: I was thrown from inside FlawedComponent.componentWillUpdate!';
}
