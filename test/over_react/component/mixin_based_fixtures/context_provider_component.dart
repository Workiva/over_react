import 'package:over_react/over_react.dart';

import '../fixtures/test_context.dart';

part 'context_provider_component.over_react.g.dart';

UiFactory<ContextProviderWrapperProps> ContextProviderWrapper = _$ContextProviderWrapper;

mixin ContextProviderWrapperProps on UiProps {}

mixin ContextProviderWrapperState on UiState {
  int latestValue;
}

class ContextProviderWrapperComponent
    extends UiStatefulComponent2<ContextProviderWrapperProps, ContextProviderWrapperState> {
  @override
  Map get initialState => newState()..latestValue = 1;

  @override
  render() {
    return (counterContext.Provider()..value = this.state.latestValue)(
      props.children,
    );
  }

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------
  void increment() {
    this.setState((newState()..latestValue = (this.state.latestValue + 1)));
  }
}
